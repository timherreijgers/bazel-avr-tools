load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "feature_set",
    "flag_group",
    "flag_set",
    "tool_path",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(":cc_toolchain_config_base.bzl", "get_base_features")

def _impl(ctx):

    base_folder = "/opt/homebrew/bin/" if "toolchain/host_os/macos" in ctx.features else "/user/bin/" if "toolchain/host_os/linux" in ctx.features else ""

    tool_paths = [
        tool_path(
            name = "ar",
            path = base_folder + "avr-ar",
        ),
        tool_path(
            name = "compat-ld",
            path = base_folder + "avr-ld",
        ),
        tool_path(
            name = "cpp",
            path = base_folder + "avr-cpp",
        ),
        tool_path(
            name = "gcc",
            path = base_folder + "avr-gcc",
        ),
        tool_path(
            name = "gcov",
            path = base_folder + "avr-gcov",
        ),
        tool_path(
            name = "ld",
            path = base_folder + "avr-ld",
        ),
        tool_path(
            name = "nm",
            path = base_folder + "avr-gcc-nm",
        ),
        tool_path(
            name = "objcopy",
            path = base_folder + "avr-objcopy",
        ),
        tool_path(
            name = "objdump",
            path = base_folder + "avr-objdump",
        ),
        tool_path(
            name = "size",
            path = base_folder + "avr-size",
        ),
        tool_path(
            name = "strip",
            path = base_folder + "avr-strip",
        ),
    ]

    features = get_base_features(ctx)

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
