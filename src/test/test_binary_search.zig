const binaryFn = @import("../kata/binary_search.zig").binaryFn;
const expectEqual = @import("std").testing.expectEqual;

test "binary search test" {
    const foo = [_]u32{ 1, 3, 4, 69, 71, 81, 90, 99, 420, 1337, 69420 };
    try expectEqual(true, binaryFn(&foo, 69));
    try expectEqual(false, binaryFn(&foo, 1336));
    try expectEqual(true, binaryFn(&foo, 69420));
    try expectEqual(false, binaryFn(&foo, 69421));
    try expectEqual(true, binaryFn(&foo, 1));
    try expectEqual(false, binaryFn(&foo, 0));
}
