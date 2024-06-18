pub fn binary_fn(array: []const u32, to_find: u32) bool {
    var lo: usize = 0;
    var hi: usize = array.len;
    var middle: usize = 0;

    while (true) {
        // this should floor by default
        middle = lo + (hi - lo) / 2;
        const middle_val = array[middle];

        if (middle_val == to_find) {
            return true;
        } else if (middle_val > to_find) {
            hi = middle;
        } else if (middle_val < to_find) {
            lo = middle + 1;
        }
        // do while the lords loop
        if (lo >= hi) {
            break;
        }
    }

    return false;
}
