import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastHelper {
  static void show(
    BuildContext context,
    String message, {
    String? description,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onUndo,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            if (description != null)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 12.sp, color: Colors.white70),
                ),
              ),
          ],
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        margin: EdgeInsets.all(16.w),
        backgroundColor: const Color(0xFF18181B),
        action: onUndo != null
            ? SnackBarAction(
                label: 'Undo',
                textColor: Colors.amber,
                onPressed: onUndo,
              )
            : null,
      ),
    );
  }

  static void success(BuildContext context, String message, {String? description}) {
    show(context, '✅ $message', description: description);
  }

  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }
}
