const MinHeap = @import("../kata/min_heap.zig").MinHeap;
const std = @import("std");
const test_allocator = std.testing.allocator;
const expectEqual = std.testing.espectEqual;

test "min heap" {
    var heap = MinHeap(isize).init(test_allocator);

    try expectEqual(heap.length, 0);

    heap.insert(5);
    heap.insert(3);
    heap.insert(69);
    heap.insert(420);
    heap.insert(4);
    heap.insert(1);
    heap.insert(8);
    heap.insert(7);

    try expectEqual(heap.length, 8);
    try expectEqual(heap.delete(), 1);
    try expectEqual(heap.delete(), 3);
    try expectEqual(heap.delete(), 4);
    try expectEqual(heap.delete(), 5);
    try expectEqual(heap.length, 4);
    try expectEqual(heap.delete(), 7);
    try expectEqual(heap.delete(), 8);
    try expectEqual(heap.delete(), 69);
    try expectEqual(heap.delete(), 420);
    try expectEqual(heap.length, 0);
}
