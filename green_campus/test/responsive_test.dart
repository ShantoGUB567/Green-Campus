import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_campus/splash_screen.dart';
import 'package:green_campus/home_screen.dart';

void main() {
  group('Responsive Design Tests', () {
    testWidgets('Splash screen should be responsive on different screen sizes',
        (WidgetTester tester) async {
      // Test on small screen (mobile)
      await tester.binding.setSurfaceSize(const Size(375, 812)); // iPhone X
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      await tester.pumpAndSettle();

      // Verify elements are present and properly sized
      expect(find.text('Green Campus'), findsOneWidget);
      expect(find.text('Smart Solutions for GUB Campus Life'), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);

      // Test on medium screen (tablet)
      await tester.binding.setSurfaceSize(const Size(768, 1024)); // iPad
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      await tester.pumpAndSettle();

      // Verify elements are still present
      expect(find.text('Green Campus'), findsOneWidget);
      expect(find.text('Smart Solutions for GUB Campus Life'), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);

      // Test on large screen (desktop)
      await tester.binding.setSurfaceSize(const Size(1920, 1080)); // Desktop
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      await tester.pumpAndSettle();

      // Verify elements are still present
      expect(find.text('Green Campus'), findsOneWidget);
      expect(find.text('Smart Solutions for GUB Campus Life'), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('Home screen should be responsive on different screen sizes',
        (WidgetTester tester) async {
      // Test on small screen (mobile)
      await tester.binding.setSurfaceSize(const Size(375, 812)); // iPhone X
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      // Verify elements are present
      expect(find.text('Green Campus'), findsOneWidget);
      expect(find.text('Welcome to Green Campus!'), findsOneWidget);
      expect(find.text('Your smart campus companion'), findsOneWidget);

      // Test on medium screen (tablet)
      await tester.binding.setSurfaceSize(const Size(768, 1024)); // iPad
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      // Verify elements are still present
      expect(find.text('Green Campus'), findsOneWidget);
      expect(find.text('Welcome to Green Campus!'), findsOneWidget);
      expect(find.text('Your smart campus companion'), findsOneWidget);

      // Test on large screen (desktop)
      await tester.binding.setSurfaceSize(const Size(1920, 1080)); // Desktop
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      // Verify elements are still present
      expect(find.text('Green Campus'), findsOneWidget);
      expect(find.text('Welcome to Green Campus!'), findsOneWidget);
      expect(find.text('Your smart campus companion'), findsOneWidget);
    });
  });
} 