const linearFn = @import("../kata/linear_search.zig").linearFn;
const expectEqual = @import("std").testing.expectEqual;

test "linear search array" {
    const foo = [_]u32{ 1, 3, 4, 69, 71, 81, 90, 99, 420, 1337, 69420 };

    try expectEqual(linearFn(&foo, 69), true);
    try expectEqual(linearFn(&foo, 1336), false);
    try expectEqual(linearFn(&foo, 69420), true);
    try expectEqual(linearFn(&foo, 69421), false);
    try expectEqual(linearFn(&foo, 1), true);
    try expectEqual(linearFn(&foo, 0), false);
}
