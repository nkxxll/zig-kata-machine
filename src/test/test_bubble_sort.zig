const bubble_sort = @import("../kata/bubble_sort.zig").bubble_sort;
const std = @import("std");

test "bubble-sort" {
    var arr = [_]u32{ 9, 3, 7, 4, 69, 420, 42 };

    const expect = [_]u32{ 3, 4, 7, 9, 42, 69, 420 };
    bubble_sort(&arr);
    try std.testing.expectEqualSlices(u32, &expect, &arr);
}
