#!/usr/bin/env python3
# CyberTuz CLI entry point.
# Extracts bundled shell scripts to ~/.cybertuz and launches cybertuz.sh

import os
import sys
import stat
import shutil
import subprocess
import importlib.resources

INSTALL_DIR = os.path.expanduser("~/.cybertuz")
DATA_DIR    = os.path.join(INSTALL_DIR, "data")
MAIN_SCRIPT = os.path.join(DATA_DIR, "cybertuz.sh")


def _get_data_path():
    try:
        from importlib.resources import files
        return str(files("cybertuz").joinpath("data"))
    except Exception:
        return os.path.join(os.path.dirname(__file__), "data")


def _make_executable(path):
    st = os.stat(path)
    os.chmod(path, st.st_mode | stat.S_IEXEC | stat.S_IXGRP | stat.S_IXOTH)


def install_files():
    src = _get_data_path()

    if os.path.exists(DATA_DIR):
        shutil.rmtree(DATA_DIR)

    shutil.copytree(src, DATA_DIR)

    for root, _, files in os.walk(DATA_DIR):
        for fname in files:
            if fname.endswith(".sh"):
                _make_executable(os.path.join(root, fname))

    os.makedirs(os.path.join(INSTALL_DIR, "logs"),   exist_ok=True)
    os.makedirs(os.path.join(INSTALL_DIR, "reports"), exist_ok=True)


def main():
    if not shutil.which("bash"):
        print("\033[0;31m[✗] bash is not installed or not in PATH.\033[0m")
        print("    Please install bash and try again.")
        sys.exit(1)

    install_files()

    args = sys.argv[1:]
    cmd = ["bash", MAIN_SCRIPT] + args

    try:
        result = subprocess.run(cmd)
        sys.exit(result.returncode)
    except KeyboardInterrupt:
        print("\n")
        sys.exit(0)
    except FileNotFoundError:
        print(f"\033[0;31m[✗] Could not find: {MAIN_SCRIPT}\033[0m")
        sys.exit(1)


if __name__ == "__main__":
    main()
