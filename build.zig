const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const types_mod = b.createModule(.{
        .root_source_file = b.path("src/types.x.zig"),
        .target = target,
        .optimize = optimize,
    });

    const config_mod = b.addModule("config.x", .{
        .root_source_file = b.path("src/config/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    config_mod.addImport("types.x.zig", types_mod);

    const lib_mod = b.addModule("uucode.x", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib_mod.addImport("types.x.zig", types_mod);
}

pub fn configureBuild(uucode_x: *std.Build.Dependency, uucode: *std.Build.Dependency) void {
    const config_x = uucode_x.module("config.x");

    uucode.module("build_config").addImport("config.x", config_x);
    config_x.addImport("config", uucode.module("config"));
    config_x.addImport("types", uucode.module("types"));
}

pub fn configureRoot(uucode_x: *std.Build.Dependency, uucode: *std.Build.Dependency) void {
    const uucode_x_mod = uucode_x.module("uucode.x");
    uucode_x_mod.addImport("get", uucode.module("get"));
    uucode.module("x").addImport("uucode_x", uucode_x_mod);
}
