const expectEqual = @import("std").testing.expectEqual;
const tree = @import("./tree.zig").tree;
const bt_in_order = @import("../kata/bt_in_order.zig").bt_in_order;

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
    expectEqual(bt_in_order(&array, tree), &expected);
}
