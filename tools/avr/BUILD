load("@rules_cc//cc:defs.bzl", "cc_toolchain", "cc_toolchain_suite")
load(":cc_toolchain_config.bzl", "cc_toolchain_config")
load("@SSEB_platforms//:platform.bzl", "get_constraints")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "ar",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-ar.sh",
    ],
)

filegroup(
    name = "as",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-as.sh",
    ],
)

filegroup(
    name = "gcc",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-gcc.sh",
    ],
)

filegroup(
    name = "ld",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-ld.sh",
    ],
)

filegroup(
    name = "nm",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-gcc-nm.sh",
    ],
)

filegroup(
    name = "objcopy",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-objcopy.sh",
    ],
)

filegroup(
    name = "objdump",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-objdump.sh",
    ],
)

filegroup(
    name = "size",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-size.sh",
    ],
)

filegroup(
    name = "strip",
    srcs = [
        "avr-gcc-10.1.0-x64-linux/bin/avr-strip.sh",
    ],
)

filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "avr-gcc-10.1.0-x64-linux/avr/include/**",
        "avr-gcc-10.1.0-x64-linux/avr/lib/**",
        "avr-gcc-10.1.0-x64-linux/include/**",
        "avr-gcc-10.1.0-x64-linux/lib/gcc/avr/**",
        "avr-gcc-10.1.0-x64-linux/libexec/gcc/avr/**",
        "avr-gcc-10.1.0-x64-linux/x86_64-pc-linux-gnu/**",
    ]),
)

filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":gcc",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":size",
        ":strip",
    ],
)

filegroup(
    name = "avr_gcc_all_files",
    srcs = [
        ":compiler_components",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "avr_gcc_linker_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":gcc",
        ":ld",
    ],
)

filegroup(
    name = "avr_gcc_compiler_files",
    srcs = [
        ":as",
        ":gcc",
        ":ld",
    ],
)

filegroup(
    name = "all",
    srcs = glob(["**/*"]),
)

cc_toolchain_config(
    name = "avr_toolchain_config",
    features = get_constraints()
)

cc_toolchain(
    name = "cc-compiler-avr-gcc",
    all_files = ":all",
    compiler_files = ":all",
    dwp_files = ":empty",
    linker_files = ":all",
    objcopy_files = ":objcopy",
    strip_files = ":strip",
    supports_param_files = 1,
    toolchain_config = "avr_toolchain_config",
)

toolchain(
    name = "toolchain_avr",
    exec_compatible_with = ["@SSEB_platforms//toolchain/compiler/avr8"],
    toolchain = ":cc-compiler-avr-gcc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
	visibility = ["//visibility:public"],
)
