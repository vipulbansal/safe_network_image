# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-06-03
## [1.0.1] - 2025-06-03
- Minor fixes and updates before first stable release

### Added
- Initial release of SafeNetworkImage widget
- Shimmer loading animation with customizable colors
- Automatic retry mechanism with configurable attempts and delays
- Network connectivity awareness and offline handling
- Multiple fallback options (icons and custom widgets)
- Pre-built variants: avatar, card, and banner image types
- Full accessibility support with semantic labels
- Touch gesture handling with onTap callbacks
- Performance optimizations with cached_network_image integration
- Comprehensive documentation and examples
- Support for custom border radius and image fitting
- Memory-efficient placeholder rendering
- Hardware-accelerated animations

### Features
- `SafeNetworkImage` - Main widget with full configuration options
- `SafeNetworkImageBuilder.avatar()` - Circular profile images
- `SafeNetworkImageBuilder.card()` - Product/content cards
- `SafeNetworkImageBuilder.banner()` - Full-width hero images
- Connectivity monitoring with automatic retry on reconnection
- Customizable retry logic with exponential backoff support
- Accessibility features for screen readers
- Error state indicators with user-friendly messages

### Dependencies
- `cached_network_image: ^3.4.1` - Core image caching functionality
- `connectivity_plus: ^6.1.4` - Network connectivity monitoring
- `flutter: ">=3.0.0"` - Minimum Flutter version support

### Compatibility
- Dart SDK: `>=3.0.0 <4.0.0`
- Flutter: `>=3.0.0`
- Platforms: iOS, Android, Web, Desktop (Windows, macOS, Linux)