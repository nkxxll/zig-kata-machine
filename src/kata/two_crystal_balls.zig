const std = @import("std");

pub fn twoCrystalBalls(data: []bool) ?usize {
    const jump: usize = std.math.sqrt(data.len);
    var i: usize = 0;
    while (i < data.len) : (i += jump) {
        if (data[i]) {
            break;
        }
    }
    i -= jump;
    var j: usize = i;
    while (j < i + jump and j < data.len) : (j += 1) {
        if (data[j]) {
            return j;
        }
    }
    return null;
}
