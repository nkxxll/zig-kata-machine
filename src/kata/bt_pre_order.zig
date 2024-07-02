const BinaryNode = @import("../test/tree.zig").BinaryNode;

fn walk(array: []u32, current_root: ?*BinaryNode) void {}

/// array is length of nodesn in tree
pub fn bt_in_order(array: []u32, tree_root: ?BinaryNode) []u32 {
    walk(&array, tree_root, 0);
    return array;
}
