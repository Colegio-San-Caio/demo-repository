# Contributing to RFC Editor Website (RED)

Thank you for your interest in contributing to the RFC Editor Website and associated tools!

## Development Workflow

1. Fork the repository and create your feature branch from `qxd-release-clean`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. Install dependencies for the relevant package (e.g., `worker/`):
   ```bash
   npm install --prefix worker
   ```
3. Run tests to ensure everything is passing:
   ```bash
   npm test --prefix worker
   ```
4. Commit your changes and push your branch, then open a Pull Request.

## Coding Standards

- Follow existing TypeScript / JavaScript conventions and idiomatic patterns.
- Ensure all new features or bug fixes include corresponding unit test coverage.
- Keep dependency additions minimal and maintain strict type safety.
