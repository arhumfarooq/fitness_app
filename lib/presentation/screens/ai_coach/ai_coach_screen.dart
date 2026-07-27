import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/exports.dart';
import '../../theme/exports.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class AICoachScreen extends StatefulWidget {
  const AICoachScreen({super.key});

  @override
  State<AICoachScreen> createState() => _AICoachScreenState();
}

class _AICoachScreenState extends State<AICoachScreen> {
  final _scrollCtrl = ScrollController();
  late final AICoachViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = Get.find<AICoachViewModel>();
    _vm.messages.listen((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Obx(() => Row(
                  children: [
                    const DarkBackButton(),
                    const SizedBox(width: 14),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.overlay10,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        border: Border.all(color: AppColors.border20),
                      ),
                      child: Icon(Icons.auto_awesome_rounded,
                          color: Colors.white, size: AppSizes.iconLg),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('AI Fitness Coach',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          Text(
                              '${_vm.messages.length - 1} messages · Always here to help',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 11)),
                        ],
                      ),
                    ),
                    if (_vm.messages.length > 1)
                      IconButton(
                        onPressed: () {
                          _vm.clearChat();
                          ToastHelper.show(
                              context, AppStrings.conversationCleared,
                              onUndo: () => ToastHelper.show(
                                  context, AppStrings.conversationRestored));
                        },
                        icon: Icon(Icons.delete_outline_rounded,
                           color: Colors.grey, size: AppSizes.iconLg),
                      ),
                  ],
                )),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  itemCount:
                      _vm.messages.length + (_vm.isTyping.value ? 1 : 0),
                  itemBuilder: (ctx, i) {
                    if (_vm.isTyping.value && i == _vm.messages.length) {
                      return const _TypingIndicator();
                    }
                    final msg = _vm.messages[i];
                    return _MessageBubble(
                      message: msg.text,
                      isAI: msg.isAI,
                      timestamp: msg.timestamp,
                      onCopy: msg.isAI
                          ? () {
                              Clipboard.setData(
                                  ClipboardData(text: msg.text));
                              ToastHelper.show(
                                  context, AppStrings.copiedToClipboard);
                            }
                          : null,
                    );
                  },
                )),
          ),

          Obx(() => Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.cardDark
                    : AppColors.white,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 34,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: AICoachViewModel.quickPrompts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (ctx, i) {
                          final p = AICoachViewModel.quickPrompts[i];
                          return GestureDetector(
                            onTap: _vm.isTyping.value
                                ? null
                                : () => _vm.send(text: p),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF1F2937)
                                    : const Color(0xFFF4F4F5),
                                borderRadius: BorderRadius.circular(
                                    AppSizes.radiusFull),
                              ),
                              child: Text(p,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.grey[300]
                                          : Colors.grey[700])),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _vm.inputCtrl,
                            maxLines: 4,
                            minLines: 1,
                            onSubmitted: (_) => _vm.send(),
                            decoration: InputDecoration(
                              hintText: AppStrings.messagePlaceholder,
                              suffixIcon: const Icon(Icons.mic_rounded),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppSizes.radiusXl),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap:
                              _vm.isTyping.value ? null : () => _vm.send(),
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: _vm.isTyping.value
                                  ? Colors.grey
                                  : AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                  AppSizes.radiusXl),
                            ),
                            child: Icon(Icons.send_rounded,
                                color: Colors.white, size: AppSizes.iconMd),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(AppStrings.enterHint,
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey[500])),
                  ],
                ))),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isAI;
  final DateTime timestamp;
  final VoidCallback? onCopy;

  const _MessageBubble({
    required this.message,
    required this.isAI,
    required this.timestamp,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isAI ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAI) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  color: Color(0xFF7C3AED), size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isAI ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isAI
                        ? (isDark ? AppColors.cardDark : AppColors.white)
                        : AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isAI ? 4 : 18),
                      bottomRight: Radius.circular(isAI ? 18 : 4),
                    ),
                    border: isAI
                        ? Border.all(
                            color: isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isAI
                          ? (isDark ? Colors.grey[200] : Colors.grey[800])
                          : Colors.white,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                    if (onCopy != null) ...[
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: onCopy,
                        child: Icon(Icons.copy_rounded,
                            size: 12, color: Colors.grey[400]),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _ctrls;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      )..repeat(reverse: true, period: Duration(milliseconds: 600 + i * 150)),
    );
  }

  @override
  void dispose() {
    for (final c in _ctrls) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Color(0xFF7C3AED), size: 16),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
              border: Border.all(
                  color:
                      isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedBuilder(
                  animation: _ctrls[i],
                  builder: (_, __) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 8,
                    height: 8 + _ctrls[i].value * 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
