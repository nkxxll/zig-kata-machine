const std = @import("std");
const tree = @import("./tree.zig").tree;
const bt_post_order = @import("../kata/bt_post_order.zig").bt_post_order;

test "In order" {
    var array_list = std.ArrayList(u32).init(std.testing.allocator);
    defer array_list.deinit();
    const expected = [_]u32{
        7,
        5,
        15,
        10,
        29,
        45,
        30,
        100,
        50,
        20,
    };
    bt_post_order(&array_list, tree);
    const owned = try array_list.toOwnedSlice();
    defer std.testing.allocator.free(owned);
    try std.testing.expectEqualSlices(u32, &expected, owned);
}
