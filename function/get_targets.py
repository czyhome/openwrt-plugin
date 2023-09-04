import io
import json
import pathlib

import yaml

exclude_build = ["build-latest"]
targets = []
subtargets = []
for t in pathlib.Path(__file__).parent.parent.joinpath(".github/workflows").rglob("build-*.yml"):
    if t.stem in exclude_build:
        continue
    with io.open(t, "r", encoding="utf8") as f:
        obj: dict = yaml.full_load(f)
        target = obj.get("jobs").get("build_ext").get("with").get("target")
        output_image_type = obj.get("jobs").get("build_ext").get("with").get("output_image_type")
        targets.append(target)
        for sub in obj.get("jobs").get("build_ext").get("strategy").get("matrix").get("subtarget"):
            st = {"target": target, "subtarget": sub}
            if output_image_type:
                st["output_image_type"] = output_image_type
            subtargets.append(st)
print("targets={0}".format(json.dumps(targets)))
print("targets_subtargets={0}".format(json.dumps(subtargets)))
