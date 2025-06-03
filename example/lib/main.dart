import 'package:flutter/material.dart';
import 'package:safe_network_image/safe_network_image.dart';

void main() {
  runApp(const SafeNetworkImageExampleApp());
}

class SafeNetworkImageExampleApp extends StatelessWidget {
  const SafeNetworkImageExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeNetworkImage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeNetworkImage Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Avatar Examples',
            _buildAvatarExamples(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Card Examples',
            _buildCardExamples(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Banner Examples',
            _buildBannerExamples(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Error Handling',
            _buildErrorExamples(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Custom Configuration',
            _buildCustomExamples(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildAvatarExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Different sizes and states:'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SafeNetworkImageBuilder.avatar(
                  url: 'https://picsum.photos/80/80?random=1',
                  radius: 20,
                  onTap: () => _showSnackBar(context, 'Small avatar tapped'),
                ),
                const SizedBox(height: 4),
                const Text('Small (20px)', style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImageBuilder.avatar(
                  url: 'https://picsum.photos/100/100?random=2',
                  radius: 30,
                  onTap: () => _showSnackBar(context, 'Medium avatar tapped'),
                ),
                const SizedBox(height: 4),
                const Text('Medium (30px)', style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImageBuilder.avatar(
                  url: 'https://picsum.photos/120/120?random=3',
                  radius: 40,
                  onTap: () => _showSnackBar(context, 'Large avatar tapped'),
                ),
                const SizedBox(height: 4),
                const Text('Large (40px)', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SafeNetworkImageBuilder.avatar(
                  url: null,
                  radius: 30,
                  fallback: Icons.person,
                ),
                const SizedBox(height: 4),
                const Text('No URL', style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImageBuilder.avatar(
                  url: 'https://invalid-url.com/avatar.jpg',
                  radius: 30,
                  fallback: Icons.person_outline,
                ),
                const SizedBox(height: 4),
                const Text('Invalid URL', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Product-style cards:'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SafeNetworkImageBuilder.card(
              url: 'https://picsum.photos/150/150?random=4',
              width: 100,
              height: 100,
              onTap: () => _showSnackBar(context, 'Card 1 tapped'),
            ),
            SafeNetworkImageBuilder.card(
              url: 'https://picsum.photos/150/150?random=5',
              width: 100,
              height: 100,
              onTap: () => _showSnackBar(context, 'Card 2 tapped'),
            ),
            SafeNetworkImageBuilder.card(
              url: 'https://picsum.photos/150/150?random=6',
              width: 100,
              height: 100,
              onTap: () => _showSnackBar(context, 'Card 3 tapped'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Rectangular card:'),
        const SizedBox(height: 8),
        SafeNetworkImageBuilder.card(
          url: 'https://picsum.photos/300/200?random=7',
          width: double.infinity,
          height: 150,
          borderRadius: 12,
          onTap: () => _showSnackBar(context, 'Rectangle card tapped'),
        ),
      ],
    );
  }

  Widget _buildBannerExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hero banner:'),
        const SizedBox(height: 8),
        SafeNetworkImageBuilder.banner(
          url: 'https://picsum.photos/400/200?random=8',
          height: 150,
          onTap: () => _showSnackBar(context, 'Banner tapped'),
        ),
        const SizedBox(height: 16),
        const Text('Profile header layout:'),
        const SizedBox(height: 8),
        SafeNetworkImageBuilder.profileHeader(
          avatarUrl: 'https://picsum.photos/120/120?random=9',
          bannerUrl: 'https://picsum.photos/400/150?random=10',
          avatarRadius: 35,
          bannerHeight: 120,
          onAvatarTap: () => _showSnackBar(context, 'Profile avatar tapped'),
          onBannerTap: () => _showSnackBar(context, 'Profile banner tapped'),
        ),
        const SizedBox(height: 40), // Extra space for avatar overlap
      ],
    );
  }

  Widget _buildErrorExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Error handling demonstration:'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SafeNetworkImage(
                  url: 'https://invalid-url.com/image.jpg',
                  width: 80,
                  height: 80,
                  fallback: Icons.error,
                  borderRadius: BorderRadius.circular(8),
                  maxRetries: 1,
                ),
                const SizedBox(height: 4),
                const Text('Invalid URL', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImage(
                  url: null,
                  width: 80,
                  height: 80,
                  fallback: Icons.image_not_supported,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 4),
                const Text('Null URL', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImage(
                  url: 'https://httpstat.us/404',
                  width: 80,
                  height: 80,
                  fallback: Icons.broken_image,
                  borderRadius: BorderRadius.circular(8),
                  maxRetries: 1,
                ),
                const SizedBox(height: 4),
                const Text('404 Error', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Custom configurations:'),
        const SizedBox(height: 12),
        
        // Custom shimmer colors
        const Text('Custom shimmer colors:', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SafeNetworkImage(
                  url: 'https://picsum.photos/100/100?random=11&t=${DateTime.now().millisecondsSinceEpoch}',
                  width: 80,
                  height: 80,
                  borderRadius: BorderRadius.circular(8),
                  shimmerBaseColor: Colors.blue[100],
                  shimmerHighlightColor: Colors.blue[50],
                ),
                const SizedBox(height: 4),
                const Text('Blue shimmer', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImage(
                  url: 'https://picsum.photos/100/100?random=12&t=${DateTime.now().millisecondsSinceEpoch}',
                  width: 80,
                  height: 80,
                  borderRadius: BorderRadius.circular(8),
                  shimmerBaseColor: Colors.green[100],
                  shimmerHighlightColor: Colors.green[50],
                ),
                const SizedBox(height: 4),
                const Text('Green shimmer', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SafeNetworkImage(
                  url: 'https://picsum.photos/100/100?random=13&t=${DateTime.now().millisecondsSinceEpoch}',
                  width: 80,
                  height: 80,
                  borderRadius: BorderRadius.circular(8),
                  showShimmer: false,
                ),
                const SizedBox(height: 4),
                const Text('No shimmer', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Custom fallback widget
        const Text('Custom fallback widget:', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        SafeNetworkImage(
          url: null,
          width: double.infinity,
          height: 100,
          fallbackWidget: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[100]!, Colors.purple[300]!],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.purple, size: 32),
                  SizedBox(height: 8),
                  Text('Custom Fallback', style: TextStyle(color: Colors.purple)),
                ],
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        
        const SizedBox(height: 16),
        
        // Feature summary
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SafeNetworkImage Features:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '• Automatic retry on network errors\n'
                '• Beautiful shimmer loading animations\n'
                '• Network connectivity awareness\n'
                '• Customizable fallback options\n'
                '• Built-in image caching\n'
                '• Accessibility support\n'
                '• Touch gesture handling\n'
                '• Pre-built variants (avatar, card, banner)',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}