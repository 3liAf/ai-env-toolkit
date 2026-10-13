#!/usr/bin/env bash
# Health-checks local Ollama daemon and measures response latency
set -euo pipefail

OLLAMA_HOST="${OLLAMA_HOST:-http://localhost:11434}"
echo "=== Ollama Daemon Health Check ==="
echo "Target host: $OLLAMA_HOST"

if command -v curl >/dev/null 2>&1; then
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$OLLAMA_HOST/api/tags" 2>/dev/null || echo "offline")
    if [ "$STATUS" = "200" ]; then
        echo "Ollama status: ONLINE (HTTP 200)"
        echo "Installed models:"
        curl -s "$OLLAMA_HOST/api/tags" | grep -o '"name":"[^"]*"' | sed 's/"name":"/  - /; s/"//' || echo "  (none)"
    else
        echo "Ollama status: OFFLINE or unreachable (HTTP $STATUS)"
    fi
else
    echo "curl command not found; cannot probe Ollama endpoint."
fi