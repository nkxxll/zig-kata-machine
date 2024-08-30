const std = @import("std");
const Allocator = std.mem.Allocator;
const print = std.debug.print;

pub fn MinHeap(comptime T: type) type {
    return struct {
        const Self = @This();
        storage: []T,
        allocator: Allocator,
        capacity: usize,
        length: usize,

        pub fn init(capacity: usize, allocator: Allocator) !Self {
            return Self{
                .storage = try allocator.alloc(T, capacity),
                .capacity = capacity,
                .length = 0,
                .allocator = allocator,
            };
        }

        fn parent(idx: usize) usize {
            return idx / 2;
        }

        fn leftChild(idx: usize) usize {
            return idx * 2;
        }

        fn rightChild(idx: usize) usize {
            return idx * 2 + 1;
        }

        pub fn insert(self: *Self, item: T) void {
            if (self.size >= self.capacity) {
                // todo: adjust the capacity
                return;
            }
            self.size += 1;
            self.storage[self.size] = item;

            var current = self.size;
            while (self.storage[current] < self.storage[parent(current)]) {
                self.swap(current, parent(current));
                current = parent(current);
            }
        }

        fn swap(self: *Self, a: usize, b: usize) void {
            const tmp = self.storage[a];
            self.storage[a] = self.storage[b];
            self.storage[b] = tmp;
        }

        fn isLeaf(self: Self, idx: usize) bool {
            return idx * 2 > self.size;
        }

        fn minHeapify(self: *Self, idx: usize) void {
            if (!self.isLeaf(idx)) {
                // if the node at idx is not in the right place swap with one
                // of the node with a lower value
                if (self.storage[idx] > self.storage[leftChild(idx)]) {
                    self.swap(idx, leftChild(idx));
                    self.minHeapify(leftChild(idx));
                }
                if (self.storage[idx] > self.storage[rightChild(idx)]) {
                    self.swap(idx, rightChild(idx));
                    self.minHeapify(rightChild(idx));
                }
            }
        }

        pub fn delete(self: *Self) ?T {
            return null;
        }

        /// debug print the min heap
        pub fn debug(self: Self) void {
            for (1..(self.length / 2 + 1)) |idx| {
                print("Parent: {}, left: {}, right: {}\n", .{ self.storage[idx], self.storage[leftChild(idx)], self.storage[rightChild(idx)] });
            }
        }
    };
}
