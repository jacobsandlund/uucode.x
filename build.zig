const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("uucode.x.config", .{
        .root_source_file = b.path("src/x_config.zig"),
        .target = target,
        .optimize = optimize,
    });

    _ = b.addModule("uucode.x", .{
        .root_source_file = b.path("src/x_root.zig"),
        .target = target,
        .optimize = optimize,
    });
}
