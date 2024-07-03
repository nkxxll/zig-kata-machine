const std = @import("std");
const BinaryNode = @import("../test/tree.zig").BinaryNode;

fn walk(array_list: *std.ArrayList(u32), tree: ?*const BinaryNode) !void {
    if (tree == null) {
        return;
    }

    try walk(array_list, tree.?.left);
    try walk(array_list, tree.?.right);
    try array_list.append(tree.?.value);
}

pub fn bt_post_order(array_list: *std.ArrayList(u32), tree: *const BinaryNode) void {
    walk(array_list, tree) catch {
        unreachable;
    };
}
