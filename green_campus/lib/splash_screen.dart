import 'package:flutter/material.dart';
import 'dart:async';
import 'widgets/loading_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Initialize scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _fadeController.forward();
    _scaleController.forward();

    // Navigate to main screen after 4 seconds
    Timer(const Duration(seconds: 4), () {
      _fadeController.reverse().then((_) {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    
    // Responsive sizing calculations
    final double logoSize = screenWidth * 0.25; // 25% of screen width
    final double titleFontSize = screenWidth * 0.08; // 8% of screen width
    final double subtitleFontSize = screenWidth * 0.04; // 4% of screen width
    final double loadingTextFontSize = screenWidth * 0.035; // 3.5% of screen width
    final double topPadding = screenHeight * 0.08; // 8% of screen height
    final double bottomPadding = screenHeight * 0.05; // 5% of screen height
    
    // Responsive constraints for different screen sizes
    final double minLogoSize = 80.0;
    final double maxLogoSize = 150.0;
    final double minTitleFontSize = 24.0;
    final double maxTitleFontSize = 48.0;
    final double minSubtitleFontSize = 12.0;
    final double maxSubtitleFontSize = 20.0;

    // Custom color for app name and subtitle
    const Color customGreen = Color(0xFF197E46);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/campus_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.3),
                Colors.green.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.4),
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    // Top spacing - responsive
                    SizedBox(height: topPadding),

                    Expanded(
                      flex: 2,
                      child: Text(" "),
                    ),

                    // GUB Logo - centered
                    Expanded(
                      flex: 3,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Center(
                            child: Image.asset(
                              'assets/images/gub_logo.png',
                              width: logoSize.clamp(minLogoSize, maxLogoSize),
                              height: logoSize.clamp(minLogoSize, maxLogoSize),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Title and Subtitle Section
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Name - responsive font size with custom color
                          Text(
                            'Green Campus',
                            style: TextStyle(
                              fontSize: titleFontSize.clamp(
                                minTitleFontSize, 
                                maxTitleFontSize
                              ),
                              fontWeight: FontWeight.bold,
                              color: customGreen,
                              shadows: const [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // SizedBox(height: screenHeight * 0.01),
                          
                          // Subtitle - responsive font size with custom color
                          Text(
                            'Smart Solutions for GUB Campus Life',
                            style: TextStyle(
                              fontSize: subtitleFontSize.clamp(
                                minSubtitleFontSize,
                                maxSubtitleFontSize,
                              ),
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: customGreen,
                              shadows: const [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 7,
                      child: Text(" "),
                    ),

                    // Loading Animation - responsive
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          LoadingAnimation(
                            color: Colors.white,
                            size: screenWidth * 0.03, // 3% of screen width
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: loadingTextFontSize.clamp(12.0, 18.0),
                              fontWeight: FontWeight.w300,
                              shadows: const [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Bottom spacing - responsive
                    SizedBox(height: bottomPadding),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
} 