const std = @import("std");

pub fn main() !void {}

comptime {
    _ = @import("./test/test_binary_search.zig");
    _ = @import("./test/test_linear_search.zig");
    _ = @import("./test/test_two_cristal_balls.zig");
}
