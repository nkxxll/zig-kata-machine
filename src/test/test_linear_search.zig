const std = @import("std");
const linearFn = @import("../kata/linear_search.zig");
const expectEqual = std.testing.expectEqual;

test "linear search array" {
    expectEqual(linearFn(&foo, 69), true);
    expectEqual(linearFn(&foo, 1336), false);
    expectEqual(linearFn(&foo, 69420), true);
    expectEqual(linearFn(&foo, 69421), false);
    expectEqual(linearFn(&foo, 1), true);
    expectEqual(linearFn(&foo, 0), false);
}


