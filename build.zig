const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("config.x.zig", .{
        .root_source_file = b.path("src/config/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    _ = b.addModule("gib.x", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
}

pub fn connectBuild(gib_x: *std.Build.Dependency, gib: *std.Build.Dependency) void {
    const config_mod = gib_x.module("config.x.zig");

    gib.module("build_config").addImport("config.x.zig", config_mod);
    config_mod.addImport("config.zig", gib.module("config.zig"));
    config_mod.addImport("types.zig", gib.module("types.zig"));
}
