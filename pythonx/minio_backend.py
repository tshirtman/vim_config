import json
import sys
import os
from pathlib import Path
from minio import Minio
from minio.error import S3Error

def load_aliases():
    config_path = Path.home() / ".mc" / "config.json"
    if not config_path.exists():
        raise Exception(f"MinIO config not found at {config_path}")
    with open(config_path) as f:
        config = json.load(f)
    aliases = {}
    for name, conf in config.get("aliases", {}).items():
        aliases[name] = {
            "endpoint": conf["url"].replace("http://", "").replace("https://", ""),
            "access_key": conf["accessKey"],
            "secret_key": conf["secretKey"],
            "secure": conf["url"].startswith("https://"),
        }
    return aliases

def list_aliases():
    return [{"type": "alias", "name": name} for name in load_aliases().keys()]

def list_objects(alias, path):
    aliases = load_aliases()
    conf = aliases[alias]
    client = Minio(
        conf["endpoint"],
        access_key=conf["access_key"],
        secret_key=conf["secret_key"],
        secure=conf["secure"]
    )
    parts = path.strip("/").split("/", 1)
    bucket = parts[0]
    prefix = parts[1] if len(parts) > 1 else ""

    if not client.bucket_exists(bucket):
        return [{"type": "error", "message": f"Bucket '{bucket}' does not exist."}]

    objects = client.list_objects(bucket, prefix=prefix, recursive=False)
    results = []
    seen = set()
    for obj in objects:
        key = obj.object_name[len(prefix):] if prefix else obj.object_name
        key = key.lstrip("/")
        part = key.split("/")[0]
        if part not in seen:
            seen.add(part)
            results.append({
                "type": "folder" if obj.is_dir or '/' in key else "file",
                "key": part,
            })
    return results

def cat(alias, fullpath):
    aliases = load_aliases()
    conf = aliases[alias]
    client = Minio(
        conf["endpoint"],
        access_key=conf["access_key"],
        secret_key=conf["secret_key"],
        secure=conf["secure"]
    )
    bucket, *path_parts = fullpath.split("/", 1)
    if not path_parts:
        return f"<empty object path in {fullpath}>"
    obj_path = path_parts[0]
    response = client.get_object(bucket, obj_path)
    return response.read().decode()

def main():
    cmd = sys.argv[1]
    if cmd == "aliases":
        print(json.dumps(list_aliases()))
    elif cmd == "ls":
        alias, path = sys.argv[2], sys.argv[3]
        print(json.dumps(list_objects(alias, path)))
    elif cmd == "cat":
        alias, path = sys.argv[2], sys.argv[3]
        print(cat(alias, path))

if __name__ == "__main__":
    main()
