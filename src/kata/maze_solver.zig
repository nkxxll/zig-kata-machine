const std = @import("std");

pub const Point = struct { x: u8, y: u8 };
const Direction = struct { x: i8, y: i8 };

const directions = [_]Direction{
    .{ .x = 1, .y = 1 },
    .{ .x = 1, .y = 0 },
    .{ .x = 0, .y = 1 },
    .{ .x = -1, .y = -1 },
};

fn walk(maze: [][]const u8, wall: u8, current: Point, end: Point, visited: *std.ArrayList(Point), array_list: *std.ArrayList(Point)) !bool {
    // out of bounds
    // in wall
    // already visited
    // end

    for (directions) |direction| {
        // push
        // walk
        // if walk == true then return
        // pop
    }
    // loop in the maze should not happen
    return false;
}

pub fn solve_maze(maze: [][]const u8, wall: u8, start: Point, end: Point, allocator: std.mem.Allocator) ![]Point {
    var array_list = std.ArrayList(Point).init(allocator);
    defer array_list.deinit();
    var visited = std.ArrayList(Point).init(allocator);
    defer visited.deinit();

    const current = start;

    walk(maze, wall, current, end, &visited, &array_list);
    return try array_list.toOwnedSlice();
}
