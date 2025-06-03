# Contributing to SafeNetworkImage

Thank you for your interest in contributing to SafeNetworkImage! We welcome contributions from the community.

## Development Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/safe_network_image.git
   cd safe_network_image
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run tests to ensure everything works:
   ```bash
   flutter test
   ```

## Making Changes

1. Create a new branch for your feature/fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. Make your changes
3. Add tests for new functionality
4. Ensure all tests pass:
   ```bash
   flutter test
   ```
5. Run the analyzer:
   ```bash
   flutter analyze
   ```
6. Format your code:
   ```bash
   dart format .
   ```

## Code Style

- Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Keep functions small and focused
- Write tests for new features and bug fixes

## Testing

- Write unit tests for all new functionality
- Ensure existing tests continue to pass
- Test on multiple platforms when possible
- Include integration tests for complex features

## Documentation

- Update README.md for significant changes
- Add inline documentation for new public APIs
- Update CHANGELOG.md following semantic versioning
- Include examples for new features

## Pull Request Process

1. Update documentation as needed
2. Add tests for your changes
3. Ensure CI passes
4. Request review from maintainers
5. Address feedback and make requested changes

## Reporting Issues

When reporting issues, please include:

- Flutter version
- Dart version
- Platform (iOS, Android, Web, Desktop)
- Minimal reproduction code
- Expected vs actual behavior
- Error messages and stack traces

## Feature Requests

For feature requests, please:

- Check if the feature already exists
- Describe the use case clearly
- Provide examples of how it would be used
- Consider backward compatibility

## Code of Conduct

Be respectful and inclusive in all interactions. We're building this together.

## Questions?

Feel free to open an issue for questions about contributing.