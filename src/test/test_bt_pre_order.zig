const expectEqual = @import("std").testing.expectEqual;
const tree = @import("./tree.zig").tree;
const bt_pre_order = @import("../kata/bt_pre_order.zig").bt_pre_order;

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
    expectEqual(bt_pre_order(&array, tree), &expected);
}
