import subprocess
import json
import os

RIVER_BEDLOAD_PATH = os.path.expanduser("~/.local/bin/river-bedload")
SCRATHPAD_ID = 1 << 20

def get_workspaces():
    output = subprocess.check_output([RIVER_BEDLOAD_PATH, "-print", "active", "-minified"])
    return json.loads(output.decode("utf-8"))

def generate_workspace_data():
    workspaces = get_workspaces()
    workspace_data = []
    for workspace in workspaces:
        if 1 << (workspace["id"] - 1) == SCRATHPAD_ID:
            continue
        
        workspace_info = {
            "output": workspace["output"],
            "id": workspace["id"],
            "tag": 1 << (workspace["id"] - 1),
            "active": workspace["active"],
            "focused": workspace["focused"],
            "occupied": workspace["occupied"],
            "urgent": workspace["urgent"],
        }
        workspace_data.append(workspace_info)
    return workspace_data

if __name__ == "__main__":
    # Send initial data immediately
    print(json.dumps(generate_workspace_data()), flush=True)
   
    process = subprocess.Popen(
        [RIVER_BEDLOAD_PATH, "-watch", "active", "-minified"],
        stdout=subprocess.PIPE,
    )
    if process.stdout is None:
        print("Error: could not subscribe to river events", flush=True)
        exit(1)
    while True:
        line = process.stdout.readline().decode("utf-8")
        if line == "":
            break
        print(json.dumps(generate_workspace_data()), flush=True)


# https://google.com