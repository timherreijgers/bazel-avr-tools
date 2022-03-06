load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "feature_set",
    "flag_group",
    "flag_set",
    "tool_path",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")


def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "ar",
            path = "/usr/bin/avr-ar",
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

    all_compile_actions = [
        ACTION_NAMES.c_compile,
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.linkstamp_compile,
        ACTION_NAMES.assemble,
        ACTION_NAMES.preprocess_assemble,
        ACTION_NAMES.cpp_header_parsing,
        ACTION_NAMES.cpp_module_compile,
        ACTION_NAMES.cpp_module_codegen,
        ACTION_NAMES.clif_match,
        ACTION_NAMES.lto_backend,
    ]

    all_link_actions = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_dynamic_library,
        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ]

    features = [
        feature(
            name = "std_incl",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
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
        ),
        feature(
            name = "optimize",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compile_actions + all_link_actions,
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-O0" if "toolchain/optimize/O0" in ctx.features else
                                "-O1" if "toolchain/optimize/O1" in ctx.features else
                                "-O2" if "toolchain/optimize/O2" in ctx.features else 
                                "-O3" if "toolchain/optimize/O3" in ctx.features else
                                "-Os" if "toolchain/optimize/Os" in ctx.features else
                                "-Ofast" if "toolchain/optimize/Ofast" in ctx.features else "-O0",
                            ],
                        ),
                    ],
                ),
            ],
        ),
        feature(
            name = "chip",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-mmcu=atmega328p" if "chip/atmega328p" in ctx.features else "",
                            ],
                        ),
                    ],
                ),
            ],
        ),
        feature(
            name = "chip_define",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-D__AVR_ATmega328__" if "chip/atmega328p" in ctx.features else "",
                            ],
                        ),
                    ],
                ),
            ],
        ),
        feature(
            name = "chip_frequency",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compile_actions,
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-DF_CPU=16000000" if "chip/atmega328p" in ctx.features else "",
                            ],
                        ),
                    ],
                ),
            ],
        ),
    ]

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
        features = features,
    )

cc_toolchain_config = rule(
    implementation = _impl,
	attrs = {},
    provides = [CcToolchainConfigInfo],
)
