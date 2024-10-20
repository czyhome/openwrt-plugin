import io
import json
import pathlib
import argparse
import yaml

parser = argparse.ArgumentParser()
parser.add_argument('--openwrt-master', action="store_true")
args: argparse.Namespace = parser.parse_args()

targets = []
subtargets = []
devices = []
archs = []
for t in pathlib.Path(__file__).parent.parent.rglob("target-*.yml"):
    with io.open(t, "r", encoding="utf8") as f:
        target_obj: dict = yaml.full_load(f)
        build_ext = target_obj.get("jobs").get("build_ext")
        target = build_ext.get("with").get("target")
        device_image_type = build_ext.get("with").get("device_image_type", "")
        stable_devices = build_ext.get("strategy").get("matrix").get("stable_device", [])
        master_devices = build_ext.get("strategy").get("matrix").get("master_device", [])

        target_subtargets = [{"target": target, "subtarget": st} for st in list(set([t.split("-")[0] for t in stable_devices + master_devices]))]
        subtargets.extend(target_subtargets)

        target_devices = [{"target": target, "device": st, "device_image_type": device_image_type} for st in (master_devices if args.openwrt_master else stable_devices)]
        devices.extend(target_devices)
        if target_devices:
            targets.append(target)

config_path = pathlib.Path(__file__).joinpath("../../../../config").resolve()

for p in config_path.rglob("profiles.json"):
    profile_obj = json.loads(p.read_text())
    arch_packages = profile_obj.get("arch_packages")
    if arch_packages:
        archs.append(arch_packages)

print("targets={0}".format(json.dumps(targets)))
print("targets_subtargets={0}".format(json.dumps(subtargets)))
print("targets_devices={0}".format(json.dumps(devices)))
print("archs={0}".format(json.dumps(archs)))
