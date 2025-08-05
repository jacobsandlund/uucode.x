const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const types_mod = b.createModule(.{
        .root_source_file = b.path("src/x.types.zig"),
        .target = target,
        .optimize = optimize,
    });

    const config_mod = b.addModule("uucode.x.config", .{
        .root_source_file = b.path("src/config/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    config_mod.addImport("x.types.zig", types_mod);

    const lib_mod = b.addModule("uucode.x", .{
        .root_source_file = b.path("src/x.root.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib_mod.addImport("x.types.zig", types_mod);
}

pub fn configureBuild(uucode_x: *std.Build.Dependency, uucode: *std.Build.Dependency) void {
    const config_mod = uucode_x.module("uucode.x.config");

    uucode.module("build_config").addImport("uucode.x.config", config_mod);
    config_mod.addImport("config.zig", uucode.module("config.zig"));
    config_mod.addImport("types.zig", uucode.module("types.zig"));
}

pub fn configureRoot(uucode_x: *std.Build.Dependency, uucode: *std.Build.Dependency) void {
    const lib_mod = uucode_x.module("uucode.x");
    lib_mod.addImport("get.zig", uucode.module("get.zig"));
    uucode.module("x").addImport("uucode.x", lib_mod);
}
