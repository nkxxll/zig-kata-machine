const std = @import("std");
const tree = @import("./tree.zig").tree;
const bt_pre_order = @import("../kata/bt_pre_order.zig").bt_pre_order;

test "In order" {
    var array_list = std.ArrayList(u32).init(std.testing.allocator);
    defer array_list.deinit();
    const expected = [_]u32{
        20,
        10,
        5,
        7,
        15,
        50,
        30,
        29,
        45,
        100,
    };
    bt_pre_order(&array_list, tree);
    const owned = try array_list.toOwnedSlice();
    defer std.testing.allocator.free(owned);
    try std.testing.expectEqualSlices(u32, &expected, owned);
}
