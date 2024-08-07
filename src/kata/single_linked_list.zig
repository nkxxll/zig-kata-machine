const std = @import("std");
const Allocator = std.mem.Allocator;
const print = std.debug.print;

fn Node(comptime T: type) type {
    return struct {
        const Self = @This();
        value: T,
        next: ?*Self,
    };
}

pub fn SingleLinkedList(comptime T: type) type {
    return struct {
        const Self = @This();
        head: ?*Node(T),
        tail: ?*Node(T),
        length: usize,
        allocator: Allocator,

        pub fn init(allocator: Allocator) Self {
            return Self{
                .head = null,
                .tail = null,
                .length = 0,
                .allocator = allocator,
            };
        }
        pub fn createNode(self: Self, value: T) !*Node(T) {
            var node = try self.allocator.create(Node(T));
            node.value = value;
            node.next = null;
            return node;
        }

        pub fn debug(self: Self) void {
            print("start debug print: ", .{});
            if (self.head == null) {
                print("the list is empty len {?} head {?} tail {?}", .{ self.length, self.head, self.tail });
            } else {
                var current: *Node(T) = self.head.?;
                while (true) {
                    print("{?}, ", .{current.value});
                    if (current.next == null) {
                        break;
                    }
                    current = current.next.?;
                }
            }
            print(" list end\n", .{});
        }

        pub fn append(self: *Self, item: T) !void {
            // todo: use allocator.create alloc in init
            const node = try self.createNode(item);
            if (self.head == null and self.tail == null and self.length == 0) {
                self.head = node;
                self.tail = node;
                self.length += 1;
                return;
            }
            self.tail.?.next = node;
            self.tail = node;
            self.length += 1;
        }

        pub fn prepend(self: *Self, item: T) !void {
            var node = try self.createNode(item);
            if (self.head == null and self.tail == null and self.length == 0) {
                self.head = node;
                self.tail = node;
                self.length += 1;
                return;
            }
            node.next = self.head;
            self.head = node;
            self.length += 1;
        }

        pub fn get(self: Self, index: usize) ?T {
            // if there is nothing return null
            if (self.head == null) {
                return null;
            }
            // set item to head
            var item: *Node(T) = self.head.?;
            for (0..index) |_| {
                if (item.next == null) {
                    return null;
                }
                item = item.next.?;
            }
            return item.value;
        }

        pub fn remove(self: *Self, item: T) ?T {
            if (self.head == null) {
                return null;
            }
            if (self.head.?.value == item) {
                const next = self.head.?.next;
                if (next == null) {
                    self.tail = null;
                }
                self.allocator.destroy(self.head.?);
                self.head = next;
                self.length -= 1;
                return item;
            }
            var tmp: *Node(T) = self.head.?;
            var current: *Node(T) = self.head.?.next.?;
            while (true) {
                const val = current.value;
                if (val == item) {
                    if (current.next) |next| {
                        tmp.next = next;
                    } else {
                        self.tail = tmp;
                    }
                    self.length -= 1;
                    self.allocator.destroy(current);
                    return val;
                }
                if (current.next == null) {
                    return null;
                }
                tmp = current;
                current = current.next.?;
            }
            return null;
        }

        pub fn removeAt(self: *Self, index: usize) ?T {
            // if there is nothing return null
            if (self.head == null) {
                return null;
            }
            if (self.head != null and index == 0) {
                print("remove head not null and idx = 0", .{});
                const head = self.head.?;
                const res = head.value;
                // if head.next is null then this is the last node and head and tail are null
                if (head.next == null) {
                    self.tail = null;
                }
                self.head = head.next;
                self.length -= 1;
                self.allocator.destroy(head);
                return res;
            }
            // set current to head
            var current: *Node(T) = self.head.?.next.?;
            var tmp: *Node(T) = self.head.?;
            for (1..index) |i| {
                if (current.next == null) {
                    return null;
                }
                if (i == index - 1) {
                    tmp = current;
                }
                current = current.next.?;
            }
            const val = current.value;

            if (current.next) |next| {
                tmp.next = next;
            } else {
                self.tail = tmp;
            }
            self.length -= 1;
            self.allocator.destroy(current);
            return val;
        }

        /// Release all allocated memory.
        pub fn deinit(self: Self) void {
            if (self.head == null and self.tail == null) {
                return;
            }
            var current: *Node(T) = self.head.?;
            while (true) {
                if (current.next == null) {
                    self.allocator.destroy(current);
                    return;
                }
                const tmp = current.next.?;
                self.allocator.destroy(current);
                current = tmp;
            }
        }
    };
}
