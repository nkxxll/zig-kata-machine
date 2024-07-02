const std = @import("std");
const tree = @import("./tree.zig").tree;
const bt_in_order = @import("../kata/bt_in_order.zig").bt_in_order;

test "In order" {
    var array_list: std.ArrayList(u32) = std.ArrayList(u32).init(std.testing.allocator);
    defer array_list.deinit();
    const expected = [_]u32{
        5,
        7,
        10,
        15,
        20,
        29,
        30,
        45,
        50,
        100,
    };
    bt_in_order(&array_list, tree);
    const owned = try array_list.toOwnedSlice();
    defer std.testing.allocator.free(owned);
    try std.testing.expectEqualSlices(u32, &expected, owned);
}
