import 'package:fitness_app/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders dashboard sections and bottom navigation', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('TODAY\'S PROGRESS'), findsOneWidget);
    expect(find.text("TODAY'S WORKOUT"), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Workouts'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('AI COACH'), 300);
    expect(find.text('AI COACH'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('WEEKLY ACTIVITY'), 300);
    expect(find.text('WEEKLY ACTIVITY'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('HEALTH & RECOVERY'), 300);
    expect(find.text('HEALTH & RECOVERY'), findsOneWidget);
    expect(find.text('Hydration'), findsOneWidget);
    expect(find.text('Recovery'), findsOneWidget);
  });
}
