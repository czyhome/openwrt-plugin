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
        obj: dict = yaml.full_load(f)
        target = obj.get("jobs").get("build_ext").get("with").get("target")
        output_image_type = obj.get("jobs").get("build_ext").get("with").get("output_image_type","")
        targets.append(target)
        for sub in obj.get("jobs").get("build_ext").get("strategy").get("matrix").get("{}_subtarget".format('master' if args.openwrt_master else 'stable'),[]):
            st = {"target": target, "subtarget": sub,"output_image_type":output_image_type}
            subtargets.append(st)
print("targets={0}".format(json.dumps(targets)))
print("targets_subtargets={0}".format(json.dumps(subtargets)))
