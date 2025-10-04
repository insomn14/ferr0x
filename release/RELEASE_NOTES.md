# Ferr0x Release

## What's New
- High-performance security testing tool written in Rust
- Header injection testing
- Parameter injection testing
- Path traversal testing
- HTTP methods testing
- Stress testing capabilities
- Multi-threading support
- Proxy support
- Status code filtering
- Retry logic for failed requests

## Supported Platforms
- macOS (Apple Silicon & Intel)
- Linux (x86_64)
- Windows (x86_64)

## Quick Start
1. Download the binary for your platform
2. Make it executable: `chmod +x ferr0x` (macOS/Linux)
3. Create a request file (see example-request.txt)
4. Run: `./ferr0x method request.txt`

## Usage Examples
```bash
# Display banner
./ferr0x --banner

# Test HTTP methods
./ferr0x method request.txt

# Header injection testing
./ferr0x header --payload "test" request.txt

# Parameter injection with threading
./ferr0x param --payload-file payloads.txt --thread 10 request.txt

# Path traversal testing
./ferr0x path --payload-file traversal.txt request.txt

# Stress testing
./ferr0x stress -r 1000 request.txt

# With proxy
./ferr0x param --payload "test" --proxy http://127.0.0.1:8080 request.txt
```

## Security Notice
This tool is for authorized security testing only. Use responsibly and only on systems you own or have permission to test.
