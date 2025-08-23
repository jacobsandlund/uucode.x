const std = @import("std");
const config = @import("config.zig");
const types_x = @import("types.x.zig");

// TODO: once #1 is solved, this can be moved to a `types.x.zig` and shared
// with `root.zig`.
const GraphemeBreakXEmoji = enum(u5) {
    other,
    control,
    prepend,
    cr,
    lf,
    regional_indicator,
    spacing_mark,
    l,
    v,
    t,
    lv,
    lvt,
    zwj,
    zwnj,
    extended_pictographic,
    // extend, ==
    //   zwnj +
    //   indic_conjunct_break_extend +
    //   indic_conjunct_break_linker
    indic_conjunct_break_extend,
    indic_conjunct_break_linker,
    indic_conjunct_break_consonant,

    // Additional fields:
    emoji_modifier,
    emoji_modifier_base,
};

fn compute(cp: u21, data: anytype, backing: anytype, tracking: anytype) void {
    _ = cp;
    _ = backing;
    _ = tracking;

    if (data.is_emoji_modifier) {
        data.grapheme_break_x_emoji = .emoji_modifier;
    } else if (data.is_emoji_modifier_base) {
        data.grapheme_break_x_emoji = .emoji_modifier_base;
    } else {
        switch (data.grapheme_break) {
            inline else => |gb| {
                data.grapheme_break_x_emoji = comptime std.meta.stringToEnum(
                    GraphemeBreakXEmoji,
                    @tagName(gb),
                ) orelse unreachable;
            },
        }
    }
}

pub const grapheme_break_x_emoji = config.Extension{
    .inputs = &.{
        "grapheme_break",
        "is_emoji_modifier",
        "is_emoji_modifier_base",
    },
    .compute = &compute,
    .fields = &.{
        .{ .name = "grapheme_break_x_emoji", .type = i3 },
    },
};
