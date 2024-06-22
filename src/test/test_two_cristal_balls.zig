const twoCrystalBalls = @import("../kata/two_crystal_balls.zig").twoCrystalBalls;
const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "two crystal balls" {
    var rng = std.Random.DefaultPrng.init(0);
    const idx = rng.random().int(usize) % 10000;
    var data: [10000]bool = undefined;
    var i = idx;
    @memset(&data, false);
    while (i < 10000) : (i += 1) {
        data[i] = true;
    }

    try expectEqual(twoCrystalBalls(&data), idx);
    var testArray: [821]bool = undefined;
    @memset(&testArray, false);
    try expectEqual(twoCrystalBalls(&testArray), null);
}
