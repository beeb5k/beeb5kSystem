import subprocess
import json


def get_workspaces():
    output = subprocess.check_output(["swaymsg", "-t", "get_workspaces"])
    return json.loads(output.decode("utf-8"))


def generate_workspace_data():
    # Return a flat array of workspaces instead of a nested dictionary
    workspaces = []
    for wsp in get_workspaces():
        workspaces.append({
            "name": wsp["name"],
            "monitor": wsp["output"],
            "focused": wsp["focused"],
            "visible": wsp["visible"],
        })
    return workspaces


if __name__ == "__main__":
    # Send initial data immediately
    print(json.dumps(generate_workspace_data()), flush=True)
    
    process = subprocess.Popen(
        ["swaymsg", "-t", "subscribe", "-m", '["workspace"]', "--raw"],
        stdout=subprocess.PIPE,
    )
    if process.stdout is None:
        print("Error: could not subscribe to sway events")
        exit(1)
    while True:
        line = process.stdout.readline().decode("utf-8")
        if line == "":
            break
        print(json.dumps(generate_workspace_data()), flush=True)