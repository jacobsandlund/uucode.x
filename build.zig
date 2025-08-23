const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const types_x_mod = b.createModule(.{
        .root_source_file = b.path("src/types.x/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const config_x_mod = b.addModule("config.x.zig", .{
        .root_source_file = b.path("src/config/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    config_x_mod.addImport("types.x.zig", types_x_mod);

    const lib_x_mod = b.addModule("uucode.x", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib_x_mod.addImport("types.x.zig", types_x_mod);
}

pub fn connectBuild(uucode_x: *std.Build.Dependency, uucode: *std.Build.Dependency) void {
    const config_mod = uucode_x.module("config.x.zig");

    uucode.module("build_config").addImport("config.x.zig", config_mod);
    config_mod.addImport("config.zig", uucode.module("config.zig"));
    config_mod.addImport("types.zig", uucode.module("types.zig"));
}
