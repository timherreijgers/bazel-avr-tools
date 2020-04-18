load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

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
                            "external/avr_tools/tools/avr/avr8-gnu-toolchain-linux_x86_64/avr/include",
                        ],
                    ),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "avr8-gnu-toolchain-linux_x86_64",
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
