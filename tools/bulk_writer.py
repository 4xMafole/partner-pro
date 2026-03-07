import json, sys, os

manifest_path = sys.argv[1]
with open(manifest_path, 'r', encoding='utf-8') as f:
    manifest = json.load(f)

count = 0
for entry in manifest:
    path = entry['path']
    content = entry['content']
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(content)
    count += 1
    print(f"  Wrote: {path} ({len(content)} bytes)")

print(f"\nDone. Wrote {count} files.")
