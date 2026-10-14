#!/usr/bin/env python3

import socket
import subprocess

formula_packages = [
    "bash",
    "bash-completion@2",
    "lld",
    "llvm",
    "pkgconf",
]

cask_packages = [
    "chatgpt",
    "doll",
    "font-fantasque-sans-mono-nerd-font",
    "font-iosevka-term-nerd-font",
    "font-jetbrains-mono-nerd-font",
    "font-recursive-mono-nerd-font",
    "manico",
    "rectangle",
    "scroll-reverser",
    "session-manager-plugin",
    "snipaste",
]

if (hostname := socket.gethostname()) == "yhjs-MacBook-Pro.local":
    formula_packages += ["platformio"]
    cask_packages += ["telegram-desktop"]
elif hostname.startswith("IT"):
    cask_packages += ["cursor"]


if __name__ == "__main__":
    subprocess.run(["brew", "install", "--formula"] + formula_packages, check=True)
    subprocess.run(["brew", "install", "--cask"] + cask_packages, check=True)
