# ai-env-toolkit

A lightweight collection of POSIX shell scripts for inspecting, auditing, and maintaining local AI development environments, LLM caches, and GPU hardware.

## Tools Included

- `scripts/env-doctor.sh`: Validates core AI engineering toolchains (Python, Node, Docker, Git).
- `scripts/check-gpu-vram.sh`: Probes discrete GPU VRAM and outputs model quantization recommendations (Q4_K_M vs Q8_0).
- `scripts/clean-hf-cache.sh`: Audits Hugging Face model cache sizes and identifies models taking up disk space.
- `scripts/verify-ollama.sh`: Health-checks local Ollama endpoints and lists active local models.

## Usage

```bash
chmod +x scripts/*.sh

# Run environment diagnostic
./scripts/env-doctor.sh

# Probe GPU memory
./scripts/check-gpu-vram.sh

# Health-check Ollama daemon
./scripts/verify-ollama.sh
```

## License

MIT License. See [LICENSE](LICENSE) for details.