import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../widgets/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _logoScale;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _logoScale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fadeIn = CurvedAnimation(parent: _ctrl, curve: const Interval(0.4, 1.0));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.headerStart, Color(0xFF27272A), AppColors.headerStart],
          ),
        ),
        child: Stack(
          children: [
            // Background blobs
            Positioned(
              top: 80,
              left: 30,
              child: _blob(120, AppColors.overlay10),
            ),
            Positioned(
              bottom: 80,
              right: 30,
              child: _blob(160, AppColors.overlay10),
            ),

            // Content
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.overlay10,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: AppColors.border20),
                      ),
                      child: const Center(
                        child: Icon(Icons.bolt_rounded,
                            color: Colors.white, size: 60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // App name
                  FadeTransition(
                    opacity: _fadeIn,
                    child: Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 52, fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: 'Fit', style: TextStyle(color: Colors.white)),
                              TextSpan(text: 'AI', style: TextStyle(color: Color(0xFFFDE047))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.appTagline,
                          style: TextStyle(color: Colors.grey[400], fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            AppStrings.appSub,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[500], fontSize: 13, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Get Started button
                  FadeTransition(
                    opacity: _fadeIn,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: AppButton(
                        label: AppStrings.getStarted,
                        color: Colors.white,
                        textColor: AppColors.primary,
                        onPressed: () => context.go(AppRoutes.login),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeIn,
                child: Text(
                  AppStrings.journeyBegins,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blob(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
}
