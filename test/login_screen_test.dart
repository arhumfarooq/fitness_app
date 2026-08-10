import 'package:fitness_app/presentation/screens/auth/login_screen.dart';
import 'package:fitness_app/presentation/screens/viewmodels/login_viewmodel.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(Get.reset);
  tearDown(Get.reset);

  testWidgets('renders login form and existing loading state', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    final vm = Get.put(LoginViewModel());

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
              GoRoute(
                path: AppRoutes.home,
                builder: (_, __) => const SizedBox.shrink(),
              ),
              GoRoute(
                path: AppRoutes.signup,
                builder: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);

    vm.isLoading.value = true;
    await tester.pump();

    expect(find.text('Signing In...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
