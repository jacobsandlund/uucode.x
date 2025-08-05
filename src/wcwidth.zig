const get = @import("get.zig");
const tableFor = get.tableFor;
const data = get.data;

pub fn wcwidth(cp: u21) i3 {
    const table = comptime tableFor("wcwidth");
    return data(table, cp).wcwidth;
}
