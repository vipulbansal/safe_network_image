# SafeNetworkImage

[![pub package](https://img.shields.io/pub/v/safe_network_image.svg)](https://pub.dev/packages/safe_network_image)
[![style: flutter lints](https://img.shields.io/badge/style-flutter__lints-blue)](https://pub.dev/packages/flutter_lints)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A robust Flutter widget that extends `cached_network_image` with enhanced error handling, connectivity awareness, shimmer effects, and automatic retry functionality.

## Features

- **✨ Shimmer Loading Animation**: Beautiful animated placeholder while images load
- **🔄 Automatic Retry**: Configurable retry attempts with customizable delays
- **📶 Connectivity Awareness**: Detects network status and handles offline scenarios
- **🎯 Flexible Fallbacks**: Support for icon fallbacks or custom widgets
- **🎨 Built-in Variants**: Pre-configured avatar, card, and banner image types
- **♿ Accessibility**: Full semantic label support for screen readers
- **👆 Touch Handling**: Optional tap gesture handling
- **⚡ Performance**: Built on top of `cached_network_image` for optimal caching

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  safe_network_image: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:safe_network_image/safe_network_image.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeNetworkImage(
      url: 'https://example.com/image.jpg',
      fallback: Icons.person,
      width: 100,
      height: 100,
    );
  }
}
```

## Usage Examples

### Avatar Images

```dart
// Simple circular avatar
SafeNetworkImageBuilder.avatar(
  url: user.avatarUrl,
  radius: 24,
  fallback: Icons.person,
  onTap: () => navigateToProfile(),
)

// Large profile picture
SafeNetworkImageBuilder.avatar(
  url: user.avatarUrl,
  radius: 48,
)
```

### Card Images

```dart
// Product card image
SafeNetworkImageBuilder.card(
  url: product.imageUrl,
  width: 200,
  height: 150,
  borderRadius: 12,
  onTap: () => viewProduct(),
)

// Square thumbnail
SafeNetworkImageBuilder.card(
  url: thumbnail.url,
  width: 100,
  height: 100,
)
```

### Banner Images

```dart
// Hero banner
SafeNetworkImageBuilder.banner(
  url: article.heroImageUrl,
  height: 250,
  fallback: Icons.article,
)

// Full-width image
SafeNetworkImageBuilder.banner(
  url: banner.imageUrl,
  height: 200,
  onTap: () => handleBannerTap(),
)
```

## Advanced Configuration

```dart
SafeNetworkImage(
  url: imageUrl,
  width: 200,
  height: 150,
  
  // Retry configuration
  maxRetries: 5,
  retryDelay: Duration(seconds: 2),
  
  // Shimmer customization
  showShimmer: true,
  shimmerBaseColor: Colors.grey[300],
  shimmerHighlightColor: Colors.grey[100],
  
  // Connectivity
  enableConnectivityCheck: true,
  
  // Fallback options
  fallback: Icons.image,
  fallbackWidget: CustomErrorWidget(),
  
  // Interaction
  onTap: () => handleImageTap(),
  semanticLabel: 'Product image',
  
  // Styling
  fit: BoxFit.cover,
  borderRadius: BorderRadius.circular(8),
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `url` | `String?` | required | Image URL to load |
| `fallback` | `IconData?` | `Icons.image` | Icon to show on error |
| `fallbackWidget` | `Widget?` | null | Custom widget for error state |
| `width` | `double?` | null | Image width |
| `height` | `double?` | null | Image height |
| `fit` | `BoxFit` | `BoxFit.cover` | How image should fit container |
| `borderRadius` | `BorderRadius?` | null | Border radius for clipping |
| `maxRetries` | `int` | 3 | Maximum retry attempts |
| `retryDelay` | `Duration` | 2 seconds | Delay between retries |
| `showShimmer` | `bool` | true | Enable shimmer loading effect |
| `shimmerBaseColor` | `Color?` | `Colors.grey[300]` | Shimmer base color |
| `shimmerHighlightColor` | `Color?` | `Colors.grey[100]` | Shimmer highlight color |
| `semanticLabel` | `String?` | null | Accessibility label |
| `onTap` | `VoidCallback?` | null | Tap gesture handler |
| `enableConnectivityCheck` | `bool` | true | Monitor network connectivity |

## Common Use Cases

### E-commerce Product Grid

```dart
GridView.builder(
  itemBuilder: (context, index) {
    final product = products[index];
    return SafeNetworkImageBuilder.card(
      url: product.imageUrl,
      width: 150,
      height: 150,
      onTap: () => viewProduct(product),
    );
  },
)
```

### User Profile Header

```dart
Row(
  children: [
    SafeNetworkImageBuilder.avatar(
      url: user.avatarUrl,
      radius: 32,
      onTap: () => editProfile(),
    ),
    SizedBox(width: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.name),
        Text(user.email),
      ],
    ),
  ],
)
```

### Chat Message Avatars

```dart
SafeNetworkImage(
  url: message.senderAvatarUrl,
  width: 40,
  height: 40,
  borderRadius: BorderRadius.circular(20),
  fallback: Icons.person,
  semanticLabel: '${message.senderName} avatar',
)
```

## States and Behaviors

### Loading State
- Shows animated shimmer effect by default
- Customizable shimmer colors and animation
- Can be disabled with `showShimmer: false`

### Error State
- Automatically retries failed loads up to `maxRetries`
- Shows retry indicator during retry attempts
- Falls back to icon or custom widget after max retries exceeded
- Displays offline indicator when no network connectivity

### Success State
- Displays cached image with smooth transition
- Stops shimmer animation automatically
- Maintains proper aspect ratio and fit settings

## Accessibility

SafeNetworkImage provides full accessibility support:

- Semantic labels for screen readers
- High contrast fallback options
- Keyboard navigation support when tappable
- Proper focus management

## Performance Considerations

- Images are cached automatically via `cached_network_image`
- Shimmer animations are hardware-accelerated
- Connectivity monitoring uses minimal resources
- Retry logic prevents excessive network requests
- Memory-efficient placeholder rendering

## Migration from CachedNetworkImage

Replace existing `CachedNetworkImage` widgets:

```dart
// Before
CachedNetworkImage(
  imageUrl: user.avatarUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  width: 100,
  height: 100,
)

// After
SafeNetworkImage(
  url: user.avatarUrl,
  fallback: Icons.person,
  width: 100,
  height: 100,
)
```

## Contributing

Contributions are welcome! Please read our [contributing guide](CONTRIBUTING.md) and submit pull requests to our [GitHub repository](https://github.com/yourusername/safe_network_image).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.

## Support

- [Documentation](https://pub.dev/packages/safe_network_image)
- [Issues](https://github.com/yourusername/safe_network_image/issues)
- [Discussions](https://github.com/yourusername/safe_network_image/discussions)