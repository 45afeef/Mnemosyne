import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../controller/lesson_reveal_controller.dart';
import '../models/lesson_block.dart';
import 'lesson_block_renderer.dart';

class LessonContent extends StatefulWidget {
  const LessonContent({
    super.key,
    required this.blocks,
    required this.controller,
  });

  final List<LessonBlock> blocks;
  final LessonRevealController controller;

  @override
  State<LessonContent> createState() => _LessonContentState();
}

class _LessonContentState extends State<LessonContent> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();

  int _insertedItems = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onRevealChanged);
  }

  @override
  void didUpdateWidget(covariant LessonContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onRevealChanged);
      widget.controller.addListener(_onRevealChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onRevealChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onRevealChanged() {
    while (_insertedItems < widget.controller.visibleBlocks) {
      final index = _insertedItems;

      _listKey.currentState?.insertItem(
        index,
        duration: const Duration(milliseconds: 350),
      );

      _insertedItems++;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) return;

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      padding: EdgeInsets.only(bottom: 150),
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      initialItemCount: _insertedItems,
      itemBuilder: (context, index, animation) {
        final block = widget.blocks[index];

        return SizeTransition(
          sizeFactor: animation,
          alignment: AlignmentGeometry.center,
          child: LessonBlockRenderer(block: block)
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(
                begin: .15,
                end: 0,
                curve: Curves.easeOut,
                duration: 300.ms,
              ),
        );
      },
    );
  }
}
