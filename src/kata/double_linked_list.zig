const std = @import("std");
const Allocator = std.mem.Allocator;

fn Node(comptime T: type) type {
    return struct {
        const Self = @This();
        value: T,
        next: ?*Self,
        prev: ?*Self,

        pub fn init(value: T, prev: ?*Self, next: ?*Self) Self {
            return Self{
                .value = value,
                .next = next,
                .prev = prev,
            };
        }
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

        pub fn append(self: *Self, item: T) !void {
            // todo: use allocator.create alloc in init
            const node = (try self.allocator.alloc(Node(T), 1))[0];
            node.init(item, null, null);
            if (self.head == null and self.tail == null and self.length == 0) {
                self.head = &node;
                self.tail = &node;
                self.length += 1;
                return;
            }
            node.prev = self.tail;
            self.tail.?.next = node;
            self.tail = node;
            self.length += 1;
        }

        pub fn prepend(self: *Self, item: T) !void {
            var node = (try self.allocator.alloc(Node(T), 1))[0];
            node.init(item, null, null);
            if (self.head == null and self.tail == null and self.length == 0) {
                self.head = &node;
                self.tail = &node;
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
            var item: ?*Node(T) = self.head;
            for (0..index) |_| {
                item = item.next;
                // if next item is out of range return null
                if (item.next == null) {
                    return null;
                }
            }
            return item.?.value;
        }

        pub fn remove(self: *Self, item: T) ?T {
            var current: ?*Node(T) = self.head;
            while (current != null) : (current = current.next) {
                const val = current.?.value;
                if (val == item) {
                    const tmp = current.prev;
                    current.prev = current.next;
                    current.next.prev = tmp;
                    self.length -= 1;
                    self.allocator.free(current);
                    return val;
                }
            }
            return null;
        }
        pub fn removeAt(self: *Self, index: usize) ?T {
            // if there is nothing return null
            if (self.head == null) {
                return null;
            }
            // set current to head
            var current: ?*Node(T) = self.head;
            for (0..index) |_| {
                current = current.next;
                // if next current is out of range return null
                if (current == null) {
                    return null;
                }
            }
            const tmp = current.prev;
            const val = current.?.value;
            current.prev = current.next;
            if (current.next == null) {
                return val;
            }
            current.next.prev = tmp;
            self.length -= 1;
            self.allocator.free(current);
            return val;
        }

        /// Release all allocated memory.
        pub fn deinit(self: Self) void {
            while (self.head != null) {
                if (self.head.next == null) {
                    self.allocator.free(self.head);
                    return;
                }
                self.head = self.head.?.next;
                self.allocator.free(self.head.?.prev);
                self.head.prev = null;
            }
        }
    };
}
