import 'package:flutter/material.dart';
import 'safe_network_image.dart';

/// Extension providing convenient builder methods for common [SafeNetworkImage] use cases.
///
/// This class provides static methods to create pre-configured [SafeNetworkImage] widgets
/// for common patterns like avatars, cards, and banners.
class SafeNetworkImageBuilder {
  /// Creates a circular avatar image.
  ///
  /// This is ideal for user profile pictures and contact avatars.
  ///
  /// Example:
  /// ```dart
  /// SafeNetworkImageBuilder.avatar(
  ///   url: user.avatarUrl,
  ///   radius: 24,
  ///   fallback: Icons.person,
  ///   onTap: () => navigateToProfile(),
  /// )
  /// ```
  ///
  /// Parameters:
  /// - [url]: The image URL to load
  /// - [radius]: The radius of the circular avatar (default: 24)
  /// - [fallback]: Icon to show on error (default: Icons.person)
  /// - [onTap]: Optional tap callback
  /// - [semanticLabel]: Accessibility label (default: 'User avatar')
  static Widget avatar({
    required String? url,
    double radius = 24,
    IconData fallback = Icons.person,
    VoidCallback? onTap,
    String? semanticLabel,
  }) {
    return SafeNetworkImage(
      url: url,
      width: radius * 2,
      height: radius * 2,
      fallback: fallback,
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      semanticLabel: semanticLabel ?? 'User avatar',
    );
  }

  /// Creates a card image with rounded corners.
  ///
  /// This is perfect for product images, thumbnails, and content cards.
  ///
  /// Example:
  /// ```dart
  /// SafeNetworkImageBuilder.card(
  ///   url: product.imageUrl,
  ///   width: 200,
  ///   height: 150,
  ///   borderRadius: 12,
  ///   onTap: () => viewProduct(),
  /// )
  /// ```
  ///
  /// Parameters:
  /// - [url]: The image URL to load
  /// - [width]: The width of the card
  /// - [height]: The height of the card
  /// - [borderRadius]: Corner radius (default: 8)
  /// - [fallback]: Icon to show on error (default: Icons.image)
  /// - [onTap]: Optional tap callback
  /// - [semanticLabel]: Accessibility label
  static Widget card({
    required String? url,
    double? width,
    double? height,
    double borderRadius = 8,
    IconData fallback = Icons.image,
    VoidCallback? onTap,
    String? semanticLabel,
  }) {
    return SafeNetworkImage(
      url: url,
      width: width,
      height: height,
      fallback: fallback,
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      semanticLabel: semanticLabel,
    );
  }

  /// Creates a full-width banner image.
  ///
  /// This is ideal for hero images, article headers, and promotional banners.
  ///
  /// Example:
  /// ```dart
  /// SafeNetworkImageBuilder.banner(
  ///   url: article.heroImageUrl,
  ///   height: 200,
  ///   fallback: Icons.landscape,
  ///   onTap: () => readArticle(),
  /// )
  /// ```
  ///
  /// Parameters:
  /// - [url]: The image URL to load
  /// - [height]: The height of the banner (default: 200)
  /// - [fallback]: Icon to show on error (default: Icons.landscape)
  /// - [onTap]: Optional tap callback
  /// - [semanticLabel]: Accessibility label
  static Widget banner({
    required String? url,
    double height = 200,
    IconData fallback = Icons.landscape,
    VoidCallback? onTap,
    String? semanticLabel,
  }) {
    return SafeNetworkImage(
      url: url,
      width: double.infinity,
      height: height,
      fallback: fallback,
      fit: BoxFit.cover,
      onTap: onTap,
      semanticLabel: semanticLabel,
    );
  }

  /// Creates a square thumbnail image.
  ///
  /// This is perfect for gallery thumbnails and grid layouts.
  ///
  /// Example:
  /// ```dart
  /// SafeNetworkImageBuilder.thumbnail(
  ///   url: photo.thumbnailUrl,
  ///   size: 80,
  ///   onTap: () => viewPhoto(),
  /// )
  /// ```
  ///
  /// Parameters:
  /// - [url]: The image URL to load
  /// - [size]: The size of the square thumbnail (default: 80)
  /// - [borderRadius]: Corner radius (default: 8)
  /// - [fallback]: Icon to show on error (default: Icons.photo)
  /// - [onTap]: Optional tap callback
  /// - [semanticLabel]: Accessibility label
  static Widget thumbnail({
    required String? url,
    double size = 80,
    double borderRadius = 8,
    IconData fallback = Icons.photo,
    VoidCallback? onTap,
    String? semanticLabel,
  }) {
    return SafeNetworkImage(
      url: url,
      width: size,
      height: size,
      fallback: fallback,
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      semanticLabel: semanticLabel,
      maxRetries: 2,
      retryDelay: const Duration(milliseconds: 500),
    );
  }

  /// Creates a profile header image.
  ///
  /// This combines a large avatar with a background banner for profile pages.
  ///
  /// Example:
  /// ```dart
  /// SafeNetworkImageBuilder.profileHeader(
  ///   avatarUrl: user.avatarUrl,
  ///   bannerUrl: user.bannerUrl,
  ///   avatarRadius: 40,
  ///   bannerHeight: 150,
  /// )
  /// ```
  ///
  /// Parameters:
  /// - [avatarUrl]: The avatar image URL
  /// - [bannerUrl]: The banner image URL
  /// - [avatarRadius]: The radius of the avatar (default: 40)
  /// - [bannerHeight]: The height of the banner (default: 150)
  /// - [onAvatarTap]: Optional avatar tap callback
  /// - [onBannerTap]: Optional banner tap callback
  static Widget profileHeader({
    required String? avatarUrl,
    String? bannerUrl,
    double avatarRadius = 40,
    double bannerHeight = 150,
    VoidCallback? onAvatarTap,
    VoidCallback? onBannerTap,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Banner image
        banner(
          url: bannerUrl,
          height: bannerHeight,
          fallback: Icons.landscape,
          onTap: onBannerTap,
          semanticLabel: 'Profile banner',
        ),
        // Avatar image positioned at bottom of banner
        Positioned(
          bottom: -avatarRadius / 2,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: avatar(
              url: avatarUrl,
              radius: avatarRadius,
              onTap: onAvatarTap,
              semanticLabel: 'Profile avatar',
            ),
          ),
        ),
      ],
    );
  }
}