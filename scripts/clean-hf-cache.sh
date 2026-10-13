#!/usr/bin/env bash
# Inspects and cleans orphaned Hugging Face model cache snapshots
set -euo pipefail

HF_HOME="${HF_HOME:-$HOME/.cache/huggingface/hub}"
echo "=== Hugging Face Cache Inspector ==="
echo "Target directory: $HF_HOME"

if [ -d "$HF_HOME" ]; then
    SIZE=$(du -sh "$HF_HOME" 2>/dev/null | cut -f1 || echo "unknown")
    echo "Current Hub cache size: $SIZE"
    echo "Models stored:"
    find "$HF_HOME" -maxdepth 2 -name "models--*" -type d 2>/dev/null | sed 's/.*models--/  - /' || echo "  (none)"
else
    echo "Hugging Face cache directory does not exist or is empty."
fi