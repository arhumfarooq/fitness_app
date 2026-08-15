import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) context.go(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageSize = constraints.maxWidth.clamp(260.0, 420.0);

            return Stack(
              children: [
                Center(
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    tween: Tween(begin: 0.92, end: 1),
                    builder: (context, scale, child) {
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Image.asset(
                      'assets/images/splash.png',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                      semanticLabel: 'Gymora AI fitness logo',
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: AppSizes.majorSectionSpacing,
                  child: const SpinKitChasingDots(
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
