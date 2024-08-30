const RingBuffer = @import("../kata/ring_buffer.zig").RingBuffer;
const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "RingBuffer" {
    const allocator = std.testing.allocator;
    var buffer = try RingBuffer(isize).init(5, allocator);
    defer buffer.delete();

    buffer.push(5);
    try expectEqual(buffer.pop(), 5);
    try expectEqual(buffer.pop(), null);

    buffer.push(42);
    buffer.push(9);
    try expectEqual(buffer.pop(), 42);
    try expectEqual(buffer.pop(), 9);
    try expectEqual(buffer.pop(), null);

    buffer.push(42);
    buffer.push(9);
    buffer.push(12);
    try expectEqual(buffer.get(2), 12);
    try expectEqual(buffer.get(1), 9);
    try expectEqual(buffer.get(0), 42);
}
