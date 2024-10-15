import argparse
import json
import pathlib


def gen_overview(release_name, release_dir):
    version_overview_obj = {
        "release": release_name,
        "profiles": []
    }
    version_overview_file = release_dir.joinpath(".overview.json")
    for p in t.rglob("profiles.json"):
        profile_obj = json.loads(p.read_text())
        profile_obj_profiles: dict[str, dict] = profile_obj["profiles"]
        for pk, pv in profile_obj_profiles.items():
            t_overview = {
                "id": pk,
                "titles": pv.get("titles"),
                "target": profile_obj["target"]
            }
            version_overview_obj["profiles"].append(t_overview)
    version_overview_file.write_text(json.dumps(version_overview_obj))

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--openwrt-master', action="store_true")
    parser.add_argument('--download-dir', required=True, type=str, help='Path to the download directory')
    args: argparse.Namespace = parser.parse_args()

    download_dir = pathlib.Path(args.download_dir)

    download_versions_file = download_dir.joinpath(".versions.json")

    download_releases_dir = download_dir.joinpath("releases")
    download_snapshots_dir = download_dir.joinpath("snapshots")

    if args.openwrt_master:
        gen_overview("SNAPSHOT", download_snapshots_dir)
    else:
        version_list = []
        for t in sorted(filter(lambda f: f.is_dir(), download_releases_dir.glob("[0-9]*")), reverse=True, key=lambda x: x.name):
            gen_overview(t.name, download_releases_dir)
            version_list.append(t.name)
        stable_version = version_list[0]

        download_versions_obj = {
            'stable_version': stable_version,
            'versions_list': version_list
        }
        download_versions_file.write_text(json.dumps(download_versions_obj))
