const SingleLinkedList = @import("../kata/single_linked_list.zig").SingleLinkedList;
const test_list = @import("./list_test.zig").test_list;
const std = @import("std");

test "DoublyLinkedList" {
    var list = SingleLinkedList(u32).init(std.testing.allocator);
    defer list.deinit();
    try test_list(&list);
}
