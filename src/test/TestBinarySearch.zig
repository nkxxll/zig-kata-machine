const binary_fn = @import("../BinarySearch.zig").binary_fn;
const expectEqual = @import("std").testing.expectEqual;

test "binary search test" {
    const foo = [_]u32{ 1, 3, 4, 69, 71, 81, 90, 99, 420, 1337, 69420 };
    try expectEqual(true, binary_fn(&foo, 69));
    try expectEqual(false, binary_fn(&foo, 1336));
    try expectEqual(true, binary_fn(&foo, 69420));
    try expectEqual(false, binary_fn(&foo, 69421));
    try expectEqual(true, binary_fn(&foo, 1));
    try expectEqual(false, binary_fn(&foo, 0));
}
