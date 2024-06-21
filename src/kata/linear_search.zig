pub fn linearFn(foo: []u32, to_find: u32) bool {
    for (foo) |elem| {
        if (elem == to_find) {
            return true;
        }
    }
    return false;
}
