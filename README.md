# Ferr0x - Security Testing Tool (Binaries & Documentation)

<p align="center">
  <img src="https://img.shields.io/badge/Version-v0.1.0-blue.svg" alt="Version">
  <img src="https://img.shields.io/badge/Language-Rust-orange.svg" alt="Language">
  <img src="https://img.shields.io/badge/Platform-Cross%20Platform-green.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Performance-High%20Speed-blue.svg" alt="Performance">
  <img src="https://img.shields.io/badge/Proxy-Supported-purple.svg" alt="Proxy Support">
</p>

```
  █████▒▓█████  ██▀███   ██▀███   ▒█████  ▒██   ██▒
▓██   ▒ ▓█   ▀ ▓██ ▒ ██▒▓██ ▒ ██▒▒██▒  ██▒▒▒ █ █ ▒░
▒████ ░ ▒███   ▓██ ░▄█ ▒▓██ ░▄█ ▒▒██░  ██▒░░  █   ░
░▓█▒  ░ ▒▓█  ▄ ▒██▀▀█▄  ▒██▀▀█▄  ▒██   ██░ ░ █ █ ▒ 
░▒█░    ░▒████▒░██▓ ▒██▒░██▓ ▒██▒░ ████▓▒░▒██▒ ▒██▒
 ▒ ░    ░░ ▒░ ░░ ▒▓ ░▒▓░░ ▒▓ ░▒▓░░ ▒░▒░▒░ ▒▒ ░ ░▓ ░
 ░       ░ ░  ░  ░▒ ░ ▒░  ░▒ ░ ▒░  ░ ▒ ▒░ ░░   ░▒ ░
 ░ ░       ░     ░░   ░   ░░   ░ ░ ░ ░ ▒   ░    ░  
           ░  ░   ░        ░         ░ ░   ░    ░  
```

**This repository contains only the compiled binaries and documentation for the `ferr0x` security testing tool. The full source code is maintained in a separate private repository.**

---

## About

`ferr0x` is a high-performance security testing tool written in Rust for analyzing HTTP requests and identifying potential vulnerabilities. This is the Rust implementation of the Amba2Pen security testing tool.

- 🚀 **High Performance**: Built with Rust for maximum speed and efficiency
- 🔍 **Multiple Testing Modes**: Header injection, parameter injection, path traversal, HTTP methods
- 🔄 **Parallel Processing**: Configurable multi-threading for concurrent requests
- 🌐 **Proxy Support**: Route requests through proxy servers
- 🎯 **Status Code Filtering**: Filter responses by specific status codes
- 📊 **Colored Output**: Color-coded status codes for better visibility
- 🔁 **Retry Logic**: Automatic retry for failed requests
- 🎨 **ASCII Art Banner**: Beautiful banner display with version information

---

## Project Structure & Source Code

- **This repository (`ferr0x`)**: Contains only the compiled binaries (in the `release/` directory) and documentation for public distribution.
- **Source code repository (`ferr0x-src`)**: The full Rust source code is maintained in a separate, private repository. If you are interested in contributing or reviewing the source, please contact the maintainer.

> **Note:** The source code is not included here for distribution purposes. This split helps keep the public release focused on easy-to-use binaries, while development and contributions are managed privately.

---

## Quick Start

### Download

Download the latest release for your platform from the [Releases](https://github.com/yourusername/ferr0x/releases) page or from the `release/` directory.

### Basic Usage

```bash
# Display banner
./ferr0x --banner

# Test HTTP methods
./ferr0x method request.txt

# Header injection testing
./ferr0x header --payload "test" request.txt

# Parameter injection with threading
./ferr0x param --payload-file payloads.txt --thread 10 request.txt
```

---

## Command Line Options

```
USAGE:
    ferr0x [OPTIONS] [COMMAND]

COMMANDS:
    header  Test for header injection vulnerabilities
    param   Test for parameter injection vulnerabilities
    path    Test for path traversal vulnerabilities
    method  Test for potentially dangerous HTTP methods
    stress  Run stress testing

OPTIONS:
    --banner       Display the banner and exit
    -h, --help     Print help information
    -V, --version  Print version information
```

---

## Features

### Header Injection Testing

Test for header-based vulnerabilities by injecting payloads into HTTP headers.

```bash
# Single payload
./ferr0x header --payload "'; DROP TABLE users; --" request.txt

# From header file
./ferr0x header --header-file headers.txt --payload "test" request.txt

# Payload file injection
./ferr0x header --payload-file payloads.txt request.txt
```

### Parameter Injection Testing

Test for parameter-based vulnerabilities in query strings and request bodies.

```bash
# Single payload
./ferr0x param --payload "'; DROP TABLE users; --" request.txt

# From file
./ferr0x param --payload-file payloads.txt request.txt

# Target specific parameters
./ferr0x param --payload "test" --specific-params "id,user,name" request.txt
```

### Path Traversal Testing

Test for path traversal vulnerabilities.

```bash
./ferr0x path --payload-file path_traversal_payloads.txt request.txt
```

### HTTP Methods Testing

Test for potentially dangerous HTTP methods.

```bash
./ferr0x method request.txt
```

### Stress Testing

Perform load testing with multiple requests.

```bash
./ferr0x stress -r 1000 request.txt
```

### Proxy Support

Route requests through proxy servers.

```bash
./ferr0x param --payload "test" --proxy http://127.0.0.1:8080 request.txt
```

### Status Code Filtering

Filter responses by specific status codes.

```bash
# Specific codes
./ferr0x param --payload "test" --status-code "200,400,404" request.txt

# Range filtering
./ferr0x param --payload "test" --status-code "4xx,5xx" request.txt
```

### Custom Headers

Add custom headers to requests.

```bash
./ferr0x param --payload "test" -H "X-Custom-Header: value" -H "Authorization: Bearer token" request.txt
```

### Multi-threading

Use parallel processing for faster testing.

```bash
./ferr0x param --payload-file payloads.txt --thread 10 request.txt
```

---

## HTTP Request File Format

Create a text file containing a raw HTTP request:

```
GET /api/users?id=1 HTTP/1.1
Host: example.com
User-Agent: Mozilla/5.0
Accept: application/json
Content-Type: application/json

{"key": "value"}
```

See `release/example-request.txt` for a template.

---

## Use Cases

### Security Testing
```bash
# Header injection testing
./ferr0x header --payload-file sql-injection.txt request.txt

# XSS testing in parameters
./ferr0x param --payload-file xss-payloads.txt request.txt
```

### Load Testing
```bash
# Stress test with 1000 requests
./ferr0x stress -r 1000 request.txt
```

### Proxy Testing
```bash
# Test through HTTP proxy
./ferr0x param --payload "test" --proxy http://127.0.0.1:8080 request.txt
```

---

## Performance Features

- **Multi-threading**: Parallel request processing with Rayon
- **Async Operations**: Built with Tokio for efficient I/O
- **Connection Pooling**: Reuses connections to reduce overhead
- **Native Compilation**: Rust provides optimal performance

---

## Security Notice

⚠️ **Warning**: This tool is designed for authorized security testing only. Use responsibly and only on systems you own or have explicit permission to test.

- Always obtain proper authorization before testing any system
- Use responsibly and in accordance with applicable laws and regulations
- The tool may generate a high volume of requests - use appropriate rate limiting
- Do not use for malicious purposes

---

## Building from Source

> **Source code is not included in this repository.**
>
> If you wish to build from source, you can contact me for access.

---

## Support

For issues, questions, or feature requests, please open an issue on GitHub.

---

## License

This project is licensed under the same license as the original Amba2Pen tool.

---

## Acknowledgments

This tool is a Rust implementation of the Amba2Pen security testing tool, providing the same functionality with improved performance and reliability.
