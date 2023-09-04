import io
import json
import pathlib
import sys

import yaml

targets = []
subtargets = []
for t in pathlib.Path(__file__).parent.parent.joinpath(".github/workflows").rglob("build-*.yml"):
    with io.open(t, "r", encoding="utf8") as f:
        obj: dict = yaml.full_load(f)
        target = obj.get("jobs").get("build_ext").get("with").get("target")
        targets.append(target)
        for sub in obj.get("jobs").get("build_ext").get("strategy").get("matrix").get("subtarget"):
            subtargets.append({"target": target, "subtarget": sub})
print(json.dumps(targets))
print(json.dumps(subtargets))
