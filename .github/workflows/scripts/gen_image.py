import argparse
import json
import os
import pathlib

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--config', required=True, help='config directory')
    parser.add_argument('--target', required=True, help='target directory')
    args: argparse.Namespace = parser.parse_args()

    config_path = pathlib.Path(args.config)
    target_path = config_path.joinpath(args.target)
    target_profiles_file = target_path.joinpath('profiles.json')
    if not target_profiles_file.exists():
        print(f"{target_profiles_file} not found")
        exit(1)
    profiles_obj = json.load(open(target_profiles_file, 'r'))
    profiles = profiles_obj['profiles']
    for pk, pv in profiles.items():
        cmd_array = [
            "make",
            f"PROFILE=\"{pk}\""
        ]
        packages = pv.get("install_packages", [])
        if packages:
            cmd_array.append(f"PACKAGES=\"{packages}\"")
        cmd = " ".join(cmd_array)
        os.system(cmd)
