const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn RingBuffer(comptime T: type) type {
    return struct {
        const Self = @This();
        head: ?usize,
        tail: ?usize,
        storage: []T,
        capacity: usize,
        allocator: Allocator,

        pub fn init(capacity: usize, allocator: Allocator) !Self {
            return Self{
                .head = null,
                .tail = null,
                .storage = try allocator.alloc(T, capacity),
                .capacity = capacity,
                .allocator = allocator,
            };
        }

        pub fn delete(self: Self) void {
            self.allocator.free(self.storage);
        }

        /// adds element at head and shifts head
        pub fn push(self: *Self, element: T) void {
            if (self.head == null or self.tail == null) {
                self.tail = 0;
                self.head = 0;
                self.storage[self.head.?] = element;
                return;
            }
            const head = self.head.?;
            const tail = self.tail.?;

            // Note: here you have to add some mechanism to expand the capacity if head reaches tail
            if ((head + 1) % self.capacity == tail) {
                std.log.warn("capacity of ringbuffer is reached", .{});
                return;
            }
            self.head = (head + 1) % self.capacity;
            self.storage[self.head.?] = element;
        }

        /// returns the element at tail and shifts tail
        pub fn pop(self: *Self) ?T {
            if (self.head == null or self.tail == null) {
                return null;
            }
            const head = self.head.?;
            const tail = self.tail.?;

            const res = self.storage[tail];
            if (head == tail) {
                // no elements left in ring buffer
                self.head = null;
                self.tail = null;
            } else {
                self.tail = (tail + 1) % self.capacity;
            }

            return res;
        }

        pub fn get(self: Self, idx: usize) ?T {
            if (self.head == null or self.tail == null) return null;
            return self.storage[(self.tail.? + idx) % self.capacity];
        }
    };
}
