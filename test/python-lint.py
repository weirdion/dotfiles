import os
import subprocess
from typing import List

CI_CHECK = os.environ.get("CI_CHECK", False)


def find_python_shebang_files(root_dir):
    python_files = []
    for dirpath, _, filenames in os.walk(root_dir):
        for filename in filenames:
            file_path = os.path.join(dirpath, filename)
            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    first_line = f.readline().strip()
                    if first_line == "#!/usr/bin/env python3":
                        python_files.append(file_path)
            except (IOError, OSError):
                continue
    return python_files


def run_linter(files):
    command_check: str = " --check" if CI_CHECK else ""
    command: List[str] = f"poetry run black{command_check}".split(" ")

    command.extend(files)
    result = subprocess.run(command, check=False, )
    print(f"Black exited with code {result.returncode}")
    if result.returncode != 0:
        exit(result.returncode)


def main():
    root_dir = "/".join([os.getcwd(), "bin"])
    python_files = find_python_shebang_files(root_dir)

    if not python_files:
        print("No Python files with shebang found.")
        return

    run_linter(python_files)


if __name__ == "__main__":
    main()
