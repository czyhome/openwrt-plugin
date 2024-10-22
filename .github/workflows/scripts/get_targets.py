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
archs = []

config_path = pathlib.Path(__file__).joinpath("../../../../config").resolve()

for p in config_path.rglob("profiles.json"):
    profile_obj = json.loads(p.read_text())
    profile_target = profile_obj.get("target")

    target = profile_target.split("/")[0]
    subtarget = profile_target.split("/")[1]
    targets.append(target)
    subtargets.append({"target":target,"subtarget": subtarget})

    arch_packages = profile_obj.get("arch_packages")
    if arch_packages:
        archs.append(arch_packages)

archs = list(set(archs))

print("targets={0}".format(json.dumps(targets)))
print("targets_subtargets={0}".format(json.dumps(subtargets)))
print("archs={0}".format(json.dumps(archs)))
