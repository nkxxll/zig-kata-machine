const std = @import("std");
const Allocator = std.mem.Allocator;
const print = std.debug.print;

fn Node(comptime T: type) type {
    return struct {
        const Self = @This();
        value: T,
        next: ?*Self,
        prev: ?*Self,
    };
}

pub fn DoubleLinkedList(comptime T: type) type {
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
            node.prev = null;
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
            var node = try self.createNode(item);
            if (self.head == null and self.tail == null and self.length == 0) {
                self.head = node;
                self.tail = node;
                self.length += 1;
                return;
            }
            node.prev = self.tail;
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
            self.head.?.prev = node;
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
            var current: *Node(T) = self.head.?;
            while (true) {
                const val = current.value;
                if (val == item) {
                    if (current.prev != null) {
                        const prev = current.prev.?;
                        prev.next = current.next;
                    } else {
                        self.head = current.next;
                    }
                    if (current.next != null) {
                        const next = current.next.?;
                        next.prev = current.prev;
                    } else {
                        self.tail = current.prev;
                    }
                    self.length -= 1;
                    self.allocator.destroy(current);
                    return val;
                }
                if (current.next == null) {
                    break;
                }
                current = current.next.?;
            }
            return null;
        }
        pub fn removeAt(self: *Self, index: usize) ?T {
            // if there is nothing return null
            if (self.head == null) {
                return null;
            }
            // set current to head
            var current: *Node(T) = self.head.?;
            for (0..index) |_| {
                if (current.next == null) {
                    print("should not happen", .{});
                    return null;
                }
                current = current.next.?;
            }
            const val = current.value;

            if (current.prev != null) {
                const prev = current.prev.?;
                prev.next = current.next;
            } else {
                self.head = current.next;
            }
            if (current.next != null) {
                const next = current.next.?;
                next.prev = current.prev;
            } else {
                self.tail = current.prev;
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
