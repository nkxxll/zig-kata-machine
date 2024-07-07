const std = @import("std");
const expectEqual = std.testing.expectEqual;
const debug = std.debug.print;

pub fn test_list(list: anytype) !void {
    debug("starting list test\n", .{});
    list.debug();
    try list.append(5);
    debug("after append 5\n", .{});
    list.debug();
    try list.append(7);
    debug("after append 7\n", .{});
    list.debug();
    try list.append(9);
    debug("after append 9\n", .{});
    list.debug();

    try expectEqual(list.get(2), 9);
    debug("first equal check get idx 2 should be 9\n", .{});
    list.debug();
    try expectEqual(list.removeAt(1), 7);
    debug("equal check removeAt idx 1 should be 7\n", .{});
    list.debug();
    try expectEqual(list.length, 2);
    debug("equal check len should be 2\n", .{});
    list.debug();

    try list.append(11);
    debug("after append 11\n", .{});
    list.debug();
    try expectEqual(list.removeAt(1), 9);
    debug("equal check removeAt idx 1 should be 9\n", .{});
    list.debug();
    try expectEqual(list.remove(9), null);
    debug("equal check remove item 9 should be null\n", .{});
    list.debug();
    try expectEqual(list.removeAt(0), 5);
    debug("equal check removeAt idx 0 should be 5\n", .{});
    list.debug();
    try expectEqual(list.removeAt(0), 11);
    debug("equal check removeAt idx 0 should be 11\n", .{});
    list.debug();
    try expectEqual(list.length, 0);
    debug("equal check length should be 0\n", .{});
    list.debug();

    try list.prepend(5);
    debug("after prepend 5\n", .{});
    list.debug();
    try list.prepend(7);
    debug("after prepend 7\n", .{});
    list.debug();
    try list.prepend(9);
    debug("after prepend 9\n", .{});
    list.debug();

    try expectEqual(list.get(2), 5);
    debug("equal check get idx 2 should be 5\n", .{});
    list.debug();
    try expectEqual(list.get(0), 9);
    debug("equal check get idx 0 should be 9\n", .{});
    list.debug();
    try expectEqual(list.remove(9), 9);
    debug("equal check remove item 9 should be 9\n", .{});
    list.debug();
    try expectEqual(list.length, 2);
    debug("equal check length should be 2\n", .{});
    list.debug();
    try expectEqual(list.get(0), 7);
    debug("equal check get idx 0 should be 7\n", .{});
    list.debug();
}
