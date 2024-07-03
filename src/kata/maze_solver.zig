const std = @import("std");

pub const Point = struct { x: i8, y: i8 };

const directions = [_]Point{
    .{ .x = 1, .y = 1 },
    .{ .x = 1, .y = 0 },
    .{ .x = 0, .y = 1 },
    .{ .x = -1, .y = -1 },
};

fn walk(maze: *[][]const u8, wall: u8, current: Point, end: Point, visited: *std.ArrayList(Point), array_list: *std.ArrayList(Point)) !bool {
    // out of bounds
    const mlen = maze.len;
    const mwidth = maze[0].len;
    if (current.x < 0 or current.x >= mwidth or current.y < 0 or current.y >= mlen) {
        try visited.append(current);
        return false;
    }
    // in wall
    if (maze[current.y][current.x] == wall) {
        try visited.append(current);
        return false;
    }
    // already visited
    for (visited) |p| {
        if (p.x == current.x and p.y == current.y) {
            return false;
        }
    }
    // end
    if (current.y == end.y and current.x == end.x) {
        try visited.append(current);
        return true;
    }

    for (directions) |direction| {
        try array_list.append(.{ .x = current.x + direction.x, .y = current.y + direction.y });
        if (walk(&maze, wall, current, end, &visited, &array_list)) {
            return true;
        } // if walk == true then return
        _ = array_list.pop();
    }
    // loop in the maze should not happen
    return false;
}

pub fn solve_maze(maze: *[][]const u8, wall: u8, start: Point, end: Point, allocator: std.mem.Allocator) ![]Point {
    var array_list = std.ArrayList(Point).init(allocator);
    defer array_list.deinit();
    var visited = std.ArrayList(Point).init(allocator);
    defer visited.deinit();

    const current = start;
    _ = walk(&maze, wall, current, end, &visited, &array_list);
    const res = try array_list.toOwnedSlice();
    return res;
}
