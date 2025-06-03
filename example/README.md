# SafeNetworkImage Example

This example app demonstrates all the features and capabilities of the SafeNetworkImage package.

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Features Demonstrated

### Avatar Images
- Small, medium, and large circular avatars
- Fallback handling for missing URLs
- Tap gesture handling

### Card Images
- Square product-style cards
- Rectangular content cards
- Custom border radius

### Banner Images
- Full-width hero banners
- Profile header layouts with overlaid avatars

### Error Handling
- Invalid URL handling
- Network error simulation
- Retry mechanism demonstration

### Custom Configuration
- Custom shimmer colors
- Disabled shimmer effects
- Custom fallback widgets
- Connectivity awareness

## Code Structure

- `main.dart` - Main app entry point and example implementations
- Comprehensive examples for each SafeNetworkImage variant
- Interactive demonstrations with tap feedback
- Real-world usage patterns

## Testing Different Scenarios

The example includes URLs that will:
- Load successfully (Picsum photos)
- Fail with 404 errors (httpstat.us)
- Fail with invalid domains
- Show fallback behaviors

## Platform Support

This example works on:
- iOS
- Android
- Web
- Desktop (Windows, macOS, Linux)