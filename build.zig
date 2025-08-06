const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("uucode.x.config", .{
        .root_source_file = b.path("src/config/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    _ = b.addModule("uucode.x", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
}

pub fn connectBuild(uucode_x: *std.Build.Dependency, uucode: *std.Build.Dependency) void {
    const config_mod = uucode_x.module("uucode.x.config");

    uucode.module("build_config").addImport("uucode.x.config", config_mod);
    config_mod.addImport("config.zig", uucode.module("config.zig"));
    config_mod.addImport("types.zig", uucode.module("types.zig"));
}
