import json, os

with open('tools/batch3.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

seen = set()
unique = []
for item in data:
    if item['path'] not in seen:
        seen.add(item['path'])
        unique.append(item)

print("Total: %d, Unique: %d" % (len(data), len(unique)))

for item in unique:
    full = os.path.abspath(item['path'])
    os.makedirs(os.path.dirname(full), exist_ok=True)
    with open(full, 'w', encoding='utf-8', newline='\n') as f:
        f.write(item['content'])
    size = os.path.getsize(full)
    print("  Wrote %s (%d bytes)" % (item['path'], size))
