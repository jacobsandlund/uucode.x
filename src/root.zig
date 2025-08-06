const uucode = @import("uucode");
pub const types = @import("x.types.zig");

pub fn wcwidth(cp: u21) i3 {
    return uucode.get("wcwidth", cp);
}
