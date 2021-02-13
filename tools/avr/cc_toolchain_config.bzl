load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "ar",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-ar",
        ),
        tool_path(
            name = "compat-ld",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-ld",
        ),
        tool_path(
            name = "cpp",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-cpp",
        ),
        tool_path(
            name = "gcc",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-gcc",
        ),
        tool_path(
            name = "gcov",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-gcov",
        ),
        tool_path(
            name = "ld",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-ld",
        ),
        tool_path(
            name = "nm",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-gcc-nm",
        ),
        tool_path(
            name = "objcopy",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-objcopy",
        ),
        tool_path(
            name = "objdump",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-objdump",
        ),
        tool_path(
            name = "size",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-size",
        ),
        tool_path(
            name = "strip",
            path = "avr-gcc-10.1.0-x64-linux/bin/avr-strip",
        ),
    ]

    toolchain_include_directories_feature = feature(
        name = "toolchain_include_directories",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-isystem",
                            "external/avr_tools/tools/avr/avr-gcc-10.1.0-x64-linux/avr/include",
                            "-isystem",
                            "external/avr_tools/tools/avr/avr-gcc-10.1.0-x64-linux/lib/gcc/avr/10.1.0/include",
                            "-isystem",
                            "external/avr_tools/tools/avr/avr-gcc-10.1.0-x64-linux/lib/gcc/avr/10.1.0/include-fixed/",
                        ],
                    ),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "avr-gcc-10.1.0-x64-linux",
        host_system_name = "x86_64-pc-linux-gnu",
        target_system_name = "avr",
        target_cpu = "avr",
        target_libc = "toolchain_avr",
        compiler = "gcc",
        abi_version = "avr",
        abi_libc_version = "avr",
        tool_paths = tool_paths,
        features = [toolchain_include_directories_feature],
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
