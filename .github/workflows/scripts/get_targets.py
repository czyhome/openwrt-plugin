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
for t in pathlib.Path(__file__).parent.parent.rglob("target-*.yml"):
    with io.open(t, "r", encoding="utf8") as f:
        target_obj: dict = yaml.full_load(f)
        build_ext = target_obj.get("jobs").get("build_ext")
        target = build_ext.get("with").get("target")
        output_image_type = build_ext.get("with").get("output_image_type","")
        target_subtargets=[{"target": target, "subtarget": st,"output_image_type":output_image_type} for st in build_ext.get("strategy").get("matrix").get("{}_subtarget".format('master' if args.openwrt_master else 'stable'),[])]
        subtargets.extend(target_subtargets)
        if target_subtargets:
            targets.append(target)

print("targets={0}".format(json.dumps(targets)))
print("targets_subtargets={0}".format(json.dumps(subtargets)))
