# Green Campus - Flutter Mobile App

A modern, smart campus companion app for Green University of Bangladesh (GUB).

## Features

### Splash Screen (Welcome Activity)
- **Modern Design**: Clean, minimalistic splash screen with smooth animations
- **Background**: Full-screen campus background image with overlay gradient
- **Logo**: Custom GUB logo widget (easily replaceable with actual logo)
- **App Name**: "Green Campus" with modern typography
- **Subtitle**: "Smart Solutions for GUB Campus Life"
- **Loading Animation**: Custom dots animation
- **Auto Transition**: Automatically navigates to home screen after 4 seconds

### 🎯 **Responsive Design**
- **Multi-Device Support**: Optimized for phones, tablets, and desktops
- **Adaptive Layout**: Automatically adjusts to different screen sizes
- **Flexible Typography**: Font sizes scale with screen dimensions
- **Responsive Spacing**: Padding and margins adapt to device size
- **Touch-Friendly**: Optimized touch targets for mobile devices

## Project Structure

```
lib/
├── main.dart                 # Main app entry point with responsive settings
├── splash_screen.dart        # Welcome/Splash screen (fully responsive)
├── home_screen.dart          # Main home screen (fully responsive)
├── utils/
│   └── responsive_utils.dart # Responsive design utilities
└── widgets/
    ├── gub_logo.dart         # Custom GUB logo widget (responsive)
    └── loading_animation.dart # Custom loading animation (responsive)
```

## Assets

- `assets/images/campus_background.png` - Campus background image
- `assets/images/` - Directory for additional images (logo, etc.)

## Getting Started

1. Ensure you have Flutter installed and set up
2. Clone the repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Responsive Design Features

### 📱 **Mobile Devices (320px - 600px)**
- Compact layout with optimized touch targets
- Smaller font sizes and spacing
- Vertical stacking of elements
- Touch-friendly button sizes

### 📟 **Tablets (600px - 1200px)**
- Balanced layout with medium spacing
- Larger font sizes for better readability
- Optimized for both portrait and landscape
- Enhanced visual hierarchy

### 🖥️ **Desktop (1200px+)**
- Spacious layout with generous spacing
- Large font sizes for desktop viewing
- Horizontal layouts where appropriate
- Enhanced user experience for larger screens

### 🎨 **Responsive Elements**
- **Typography**: Font sizes scale from 12px to 48px based on screen width
- **Spacing**: Padding and margins adapt to screen dimensions
- **Images**: Logo and icons scale proportionally
- **Layout**: Flexible grid system that adapts to screen size
- **Touch Targets**: Minimum 44px touch targets for mobile

## Customization

### Replacing the Logo
To replace the placeholder GUB logo with the actual logo:
1. Add the logo image to `assets/images/`
2. Update the `GUBLogo` widget in `lib/widgets/gub_logo.dart`
3. Replace the placeholder with an `Image.asset()` widget

### Modifying the Splash Screen
The splash screen can be customized by editing `lib/splash_screen.dart`:
- Change animation duration in `initState()`
- Modify colors and styling
- Adjust responsive breakpoints
- Customize responsive sizing calculations

### Responsive Design Customization
Use the `ResponsiveUtils` class in `lib/utils/responsive_utils.dart`:
```dart
// Get responsive font size
double fontSize = ResponsiveUtils.getResponsiveFontSize(context, 0.04);

// Get responsive spacing
double spacing = ResponsiveUtils.getResponsiveSpacing(context, 0.02);

// Check device type
bool isMobile = ResponsiveUtils.isMobile(context);
```

## Testing

Run responsive design tests:
```bash
flutter test test/responsive_test.dart
```

## Dependencies

- Flutter SDK
- Material Design components
- No additional external dependencies required

## Design Guidelines

- **Colors**: Green theme (Colors.green)
- **Typography**: Modern sans-serif fonts with responsive scaling
- **Layout**: Clean, spacious design with adaptive padding
- **Animations**: Smooth, elegant transitions
- **Accessibility**: High contrast text with shadows for readability
- **Responsive**: All elements adapt to screen size automatically

## Device Support

- ✅ **Mobile Phones**: iPhone, Android phones (320px - 600px)
- ✅ **Tablets**: iPad, Android tablets (600px - 1200px)
- ✅ **Desktop**: Windows, macOS, Linux (1200px+)
- ✅ **Landscape Mode**: Optimized for all orientations
- ✅ **High DPI Displays**: Retina, 4K, and high-resolution screens
