import io
import json
import pathlib
import argparse
import yaml

parser = argparse.ArgumentParser()
parser.add_argument('--openwrt-master', action="store_true")
args: argparse.Namespace = parser.parse_args()

targets = []
devices = []
for t in pathlib.Path(__file__).parent.parent.rglob("target-*.yml"):
    with io.open(t, "r", encoding="utf8") as f:
        target_obj: dict = yaml.full_load(f)
        build_ext = target_obj.get("jobs").get("build_ext")
        target = build_ext.get("with").get("target")
        device_image_type = build_ext.get("with").get("device_image_type","")
        target_devices=[{"target": target, "device": st,"device_image_type":device_image_type} for st in build_ext.get("strategy").get("matrix").get("{}_device".format('master' if args.openwrt_master else 'stable'),[])]
        devices.extend(target_devices)
        if target_devices:
            targets.append(target)

print("targets={0}".format(json.dumps(targets)))
print("targets_devices={0}".format(json.dumps(devices)))
