const config = @import("config.zig");
const d = config.default;

fn computeWidth(cp: u21, data: anytype) void {
    _ = cp;
    data.width = switch (data.east_asian_width) {
        .wide, .fullwidth => 2,
        else => 1,
    };
}

pub const width = config.Extension{
    .inputs = &.{"east_asian_width"},
    .compute = &computeWidth,
    .fields = &.{.extension("width", u2)},
};
