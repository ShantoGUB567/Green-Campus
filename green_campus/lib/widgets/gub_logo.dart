import 'package:flutter/material.dart';

class GUBLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const GUBLogo({
    super.key,
    this.size = 120,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    
    // Responsive sizing calculations
    final double responsiveSize = size.clamp(
      screenWidth * 0.15, // Minimum 15% of screen width
      screenWidth * 0.3,  // Maximum 30% of screen width
    );
    
    // Responsive constraints
    final double minSize = 60.0;
    final double maxSize = 200.0;
    final double finalSize = responsiveSize.clamp(minSize, maxSize);
    
    // Responsive border radius and shadow
    final double borderRadius = finalSize * 0.15;
    final double shadowBlur = finalSize * 0.08;
    final double shadowOffset = finalSize * 0.04;
    
    // Responsive icon and text sizes
    final double iconSize = finalSize * 0.4;
    final double textSize = finalSize * 0.2;

    return Container(
      width: finalSize,
      height: finalSize,
      decoration: BoxDecoration(
        color: color ?? Colors.green,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: shadowBlur,
            offset: Offset(0, shadowOffset),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background pattern
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade400,
                  Colors.green.shade600,
                ],
              ),
            ),
          ),
          // Logo content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school,
                size: iconSize,
                color: Colors.white,
              ),
              SizedBox(height: finalSize * 0.06),
              Text(
                'GUB',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: textSize * 0.06,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 