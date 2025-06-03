import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

/// A robust Flutter widget that extends [CachedNetworkImage] with enhanced
/// error handling, connectivity awareness, shimmer effects, and automatic retry functionality.
///
/// This widget provides a comprehensive solution for loading network images with:
/// - Shimmer loading animations
/// - Automatic retry on failure
/// - Network connectivity awareness
/// - Flexible fallback options
/// - Accessibility support
/// - Touch gesture handling
///
/// Example usage:
/// ```dart
/// SafeNetworkImage(
///   url: 'https://example.com/image.jpg',
///   fallback: Icons.person,
///   width: 100,
///   height: 100,
/// )
/// ```
class SafeNetworkImage extends StatefulWidget {
  /// The URL of the image to load.
  final String? url;

  /// The icon to display when the image fails to load or is null.
  final IconData? fallback;

  /// A custom widget to display when the image fails to load.
  /// Takes precedence over [fallback] if provided.
  final Widget? fallbackWidget;

  /// The width of the image container.
  final double? width;

  /// The height of the image container.
  final double? height;

  /// How the image should be inscribed into the container.
  final BoxFit fit;

  /// The border radius to apply to the image container.
  final BorderRadius? borderRadius;

  /// The maximum number of retry attempts when image loading fails.
  final int maxRetries;

  /// The delay between retry attempts.
  final Duration retryDelay;

  /// Whether to show the shimmer loading animation.
  final bool showShimmer;

  /// The base color for the shimmer animation.
  final Color? shimmerBaseColor;

  /// The highlight color for the shimmer animation.
  final Color? shimmerHighlightColor;

  /// The semantic label for accessibility.
  final String? semanticLabel;

  /// Callback function when the image is tapped.
  final VoidCallback? onTap;

  /// Whether to monitor network connectivity and handle offline scenarios.
  final bool enableConnectivityCheck;

  /// Creates a [SafeNetworkImage] widget.
  ///
  /// The [url] parameter specifies the image URL to load.
  /// The [fallback] parameter provides an icon to show on error.
  /// The [maxRetries] parameter controls how many times to retry failed loads.
  const SafeNetworkImage({
    Key? key,
    required this.url,
    this.fallback,
    this.fallbackWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
    this.showShimmer = true,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.semanticLabel,
    this.onTap,
    this.enableConnectivityCheck = true,
  }) : super(key: key);

  @override
  State<SafeNetworkImage> createState() => _SafeNetworkImageState();
}

class _SafeNetworkImageState extends State<SafeNetworkImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;
  int _retryCount = 0;
  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  String? _currentImageKey;

  @override
  void initState() {
    super.initState();
    _setupShimmerAnimation();
    _checkConnectivity();
    _setupConnectivityListener();
  }

  @override
  void didUpdateWidget(SafeNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _retryCount = 0;
      _currentImageKey = widget.url;
    }
  }

  void _setupShimmerAnimation() {
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
    _shimmerController.repeat();
  }

  void _checkConnectivity() async {
    if (!widget.enableConnectivityCheck) return;

    final connectivity = Connectivity();
    final results = await connectivity.checkConnectivity();
    setState(() {
      _isConnected = !results.contains(ConnectivityResult.none);
    });
  }

  void _setupConnectivityListener() {
    if (!widget.enableConnectivityCheck) return;

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          (List<ConnectivityResult> results) {
        final wasConnected = _isConnected;
        final isNowConnected = !results.contains(ConnectivityResult.none);

        setState(() {
          _isConnected = isNowConnected;
        });

        // If we just got connected and had a failed image, retry
        if (!wasConnected && isNowConnected && _retryCount > 0) {
          _retryImageLoad();
        }
      },
    );
  }

  void _retryImageLoad() {
    if (_retryCount < widget.maxRetries) {
      setState(() {
        _retryCount++;
        _currentImageKey = '${widget.url}_retry_$_retryCount';
      });
    }
  }

  void _handleImageError() {
    if (_retryCount < widget.maxRetries) {
      Future.delayed(widget.retryDelay, () {
        if (mounted) {
          _retryImageLoad();
        }
      });
    }
  }

  Widget _buildShimmerPlaceholder() {
    if (!widget.showShimmer) {
      return _buildFallback();
    }

    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                (_shimmerAnimation.value - 1).clamp(0.0, 1.0),
                _shimmerAnimation.value.clamp(0.0, 1.0),
                (_shimmerAnimation.value + 1).clamp(0.0, 1.0),
              ],
              colors: [
                widget.shimmerBaseColor ?? Colors.grey[300]!,
                widget.shimmerHighlightColor ?? Colors.grey[100]!,
                widget.shimmerBaseColor ?? Colors.grey[300]!,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFallback() {
    if (widget.fallbackWidget != null) {
      return widget.fallbackWidget!;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: widget.borderRadius,
      ),
      child: Icon(
        widget.fallback ?? Icons.image,
        size: (widget.width != null && widget.height != null)
            ? (widget.width! + widget.height!) / 6
            : 32,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildNoConnectionIndicator() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: widget.borderRadius,
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.orange[600],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            'No Connection',
            style: TextStyle(
              color: Colors.orange[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetryIndicator() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: widget.borderRadius,
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Retry ${_retryCount}/${widget.maxRetries}',
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (widget.url == null || widget.url!.isEmpty) {
      return _buildFallback();
    }

    if (!_isConnected && widget.enableConnectivityCheck) {
      return _buildNoConnectionIndicator();
    }

    return CachedNetworkImage(
      key: ValueKey(_currentImageKey ?? widget.url),
      imageUrl: widget.url!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      placeholder: (context, url) => _buildShimmerPlaceholder(),
      errorWidget: (context, url, error) {
        if (_retryCount < widget.maxRetries) {
          _handleImageError();
          return _buildRetryIndicator();
        }
        return _buildFallback();
      },
      imageBuilder: (context, imageProvider) {
        _shimmerController.stop();
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            image: DecorationImage(
              image: imageProvider,
              fit: widget.fit,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = _buildImage();

    if (widget.semanticLabel != null) {
      imageWidget = Semantics(
        label: widget.semanticLabel,
        child: imageWidget,
      );
    }

    if (widget.onTap != null) {
      imageWidget = GestureDetector(
        onTap: widget.onTap,
        child: imageWidget,
      );
    }

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: imageWidget,
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}