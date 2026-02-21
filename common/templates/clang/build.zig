const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "hello-c",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });

    // 1. Link the C standard library
    exe.linkLibC();

    // 2. Add your C source files
    exe.addCSourceFile(.{
        .file = b.path("src/main.c"),
        .flags = &.{ "-Wall", "-Wextra", "-O2" },
    });

    // 3. Declare intent for the executable to be installed
    b.installArtifact(exe);

    // 4. Create the 'run' step
    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);

    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // --- 5. Support Testing ---
    // This creates an executable that runs 'test' blocks in src/test.zig
    const exe_unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // This exposes our Zig exported functions to the Linux 
    // dynamic symbol table so dlsym() can actually find them.
    exe_unit_tests.rdynamic = true;

    exe_unit_tests.addCSourceFile(.{
        .file = b.path("src/main.c"),
        .flags = &.{ "-Wall", "-Wextra", "-pedantic", "-Dmain=nomain" },
    });

    // Allow tests to link against C and find your headers
    exe_unit_tests.linkLibC();
    exe_unit_tests.addIncludePath(b.path("src"));

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}

