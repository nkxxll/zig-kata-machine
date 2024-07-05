const DoubleLinkedList = @import("../kata/double_linked_list.zig").DoubleLinkedList;
const test_list = @import("./list_test.zig").test_list;
const std = @import("std");

test "DoublyLinkedList" {
    var list = DoubleLinkedList(u32).init(std.testing.allocator);
    defer list.deinit();
    try test_list(&list);
}
