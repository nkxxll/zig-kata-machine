const expectEqual = @import("std").testing.expectEqual;
const tree = @import("./tree.zig").tree;
const bt_post_order = @import("../kata/bt_post_order.zig").bt_post_order;

test "In order" {
    var array = [_]u32{
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    };
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
    expectEqual(bt_post_order(&array, tree), &expected);
}
