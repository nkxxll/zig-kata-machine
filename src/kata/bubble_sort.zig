const std = @import("std");

pub fn bubble_sort(arr: []u32) void {
    for (0..arr.len) |i| {
        for (0..arr.len) |j| {
            if (arr[i] < arr[j]) {
                arr[i] = arr[i] ^ arr[j];
                arr[j] = arr[i] ^ arr[j];
                arr[i] = arr[i] ^ arr[j];
            }
        }
    }
}
