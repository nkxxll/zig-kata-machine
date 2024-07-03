const solve_maze = @import("../kata/maze_solver.zig").solve_maze;
const Point = @import("../kata/maze_solver.zig").Point;
const std = @import("std");

test "maze solver" {
    const maze = [_][]const u8{
        "xxxxxxxxxx x",
        "x        x x",
        "x        x x",
        "x xxxxxxxx x",
        "x          x",
        "x xxxxxxxxxx",
    };

    const mazeResult = [_]Point{
        .{ .x = 10, .y = 0 },
        .{ .x = 10, .y = 1 },
        .{ .x = 10, .y = 2 },
        .{ .x = 10, .y = 3 },
        .{ .x = 10, .y = 4 },
        .{ .x = 9, .y = 4 },
        .{ .x = 8, .y = 4 },
        .{ .x = 7, .y = 4 },
        .{ .x = 6, .y = 4 },
        .{ .x = 5, .y = 4 },
        .{ .x = 4, .y = 4 },
        .{ .x = 3, .y = 4 },
        .{ .x = 2, .y = 4 },
        .{ .x = 1, .y = 4 },
        .{ .x = 1, .y = 5 },
    };

    // there is only one path through
    const result = try solve_maze(&maze, 'x', .{ .x = 10, .y = 0 }, .{ .x = 1, .y = 5 }, std.testing.allocator);
    try std.testing.expectEqualSlices(Point, &mazeResult, result);
}
