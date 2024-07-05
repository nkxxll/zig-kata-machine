const std = @import("std");
const expectEqual = std.testing.expectEqualEqual;

pub fn test_list(list: anytype) !void {
    try list.append(5);
    try list.append(7);
    try list.append(9);

    try expectEqual(list.get(2), 9);
    try expectEqual(list.removeAt(1), 7);
    try expectEqual(list.length, 2);

    try list.append(11);
    try expectEqual(list.removeAt(1), 9);
    try expectEqual(list.remove(9), null);
    try expectEqual(list.removeAt(0), 5);
    try expectEqual(list.removeAt(0), 11);
    try expectEqual(list.length, 0);

    list.prepend(5);
    list.prepend(7);
    list.prepend(9);

    try expectEqual(list.get(2), 5);
    try expectEqual(list.get(0), 9);
    try expectEqual(list.remove(9), 9);
    try expectEqual(list.length, 2);
    try expectEqual(list.get(0), 7);
}
