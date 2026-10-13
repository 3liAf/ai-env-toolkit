#!/usr/bin/env bash
# Probes GPU memory availability and recommends quant levels for LLM execution
set -euo pipefail

echo "=== GPU & VRAM Memory Inspector ==="

if command -v nvidia-smi >/dev/null 2>&1; then
    echo "NVIDIA GPU Detected:"
    nvidia-smi --query-gpu=name,memory.total,memory.free,driver_version --format=csv,noheader
    TOTAL_VRAM=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -n1)
    echo "Recommendation:"
    if [ "$TOTAL_VRAM" -ge 24000 ]; then
        echo "  - 24GB+ VRAM: Fits 70B models at Q4_K_M or 32B at Q8_0 / BF16"
    elif [ "$TOTAL_VRAM" -ge 12000 ]; then
        echo "  - 12-16GB VRAM: Fits 14B models at Q8_0 or 32B at Q4_K_M"
    elif [ "$TOTAL_VRAM" -ge 8000 ]; then
        echo "  - 8GB VRAM: Optimal for 7B/8B models at Q4_K_M / Q5_K_M"
    else
        echo "  - Under 8GB VRAM: Use quantized small models (3B) or CPU offloading"
    fi
else
    echo "No discrete NVIDIA GPU detected via nvidia-smi. Unified / CPU RAM mode active."
fi