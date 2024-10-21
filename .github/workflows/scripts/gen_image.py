import argparse
import json
import os
import pathlib

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--openwrt-dir', required=True, help="openwrt workspace")
    parser.add_argument('--config', required=True, help='config directory')
    parser.add_argument('--target', required=True, help='target directory')
    args: argparse.Namespace = parser.parse_args()

    config_path = pathlib.Path(args.config)
    target_path = config_path.joinpath(args.target)
    target_profiles_file = target_path.joinpath('profiles.json')
    if not target_profiles_file.exists():
        print(f"{target_profiles_file} not found")
        exit(0)
    profiles_obj = json.load(open(target_profiles_file, 'r'))
    profiles = profiles_obj['profiles']

    config_file = pathlib.Path(args.openwrt_dir).joinpath(".config")
    config_bak_file = pathlib.Path(args.openwrt_dir).joinpath(".config.bak")
    config_bak_file.write_text(config_file.read_text())

    for pk, pv in profiles.items():
        config_file.write_text(config_bak_file.read_text())
        cmd_arr = [
            f"cd {args.openwrt_dir};",
            "make image",
            f"PROFILE=\"{pk}\""
        ]
        image_builder_config = pv.get("image_builder_config", [])
        if image_builder_config:
            config_file.open(mode="a+", encoding="utf-8").write('\n'.join(image_builder_config))

        packages = pv.get("install_packages", [])
        packages_str = " ".join(packages)
        if packages:
            cmd_arr.append(f"PACKAGES=\"{packages_str}\"")
        cmd_str = " ".join(cmd_arr)
        os.system(f"echo \'{cmd_str}\'")
        os.system(cmd_str)
