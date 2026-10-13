#!/usr/bin/env bash
# Validates core dev dependencies for AI and Agent development
set -euo pipefail

echo "======================================"
echo "    AI Engineering Environment Doctor  "
echo "======================================"

check_cmd() {
    local cmd="$1"
    local label="$2"
    if command -v "$cmd" >/dev/null 2>&1; then
        local ver
        ver=$("$cmd" --version 2>&1 | head -n1 || echo "installed")
        echo "[OK] $label: $ver"
    else
        echo "[MISSING] $label: Not found in PATH"
    fi
}

check_cmd "python3" "Python 3" || check_cmd "python" "Python"
check_cmd "node" "Node.js"
check_cmd "git" "Git"
check_cmd "curl" "Curl"
check_cmd "docker" "Docker"

echo "--------------------------------------"
echo "Environment check complete."