const get = @import("get.zig");

pub fn width(cp: u21) u2 {
    const table = comptime get.tableFor("width");
    return get.data(table, cp).width;
}
