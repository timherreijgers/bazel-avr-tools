load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "tool_path")

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "ar",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-ar",
        ),
        tool_path(
            name = "compat-ld",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-ld",
        ),
        tool_path(
            name = "cpp",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-cpp",
        ),
        tool_path(
            name = "gcc",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-gcc",
        ),
        tool_path(
            name = "gcov",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-gcov",
        ),
        tool_path(
            name = "ld",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-ld",
        ),
        tool_path(
            name = "nm",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-gcc-nm",
        ),
        tool_path(
            name = "objcopy",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-objcopy",
        ),
        tool_path(
            name = "objdump",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-objdump",
        ),
        tool_path(
            name = "size",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-size",
        ),
        tool_path(
            name = "strip",
            path = "avr8-gnu-toolchain-linux_x86_64/bin/avr-strip",
        ),
    ]
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "avr8-gnu-toolchain-linux_x86_64",
        host_system_name = "x86_64-pc-linux-gnu",
        target_system_name = "avr",
        target_cpu = "avr",
        target_libc = "avr",
        compiler = "gcc",
        abi_version = "avr",
        abi_libc_version = "avr",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = [
            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/lib/gcc/avr/include",
            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/lib/gcc/avr/include-fixed",
            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/avr/include",
            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/lib/gcc/avr/include",
            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/lib/gcc/avr/include-fixed",
            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/avr/include/avr",
        ],
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
