import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../controller/lesson_reveal_controller.dart';
import '../models/lesson_block.dart';
import 'lesson_block_renderer.dart';

class ProgressiveReveal extends StatefulWidget {
  const ProgressiveReveal({
    super.key,
    required this.blocks,
    required this.controller,
  });

  final List<LessonBlock> blocks;
  final LessonRevealController controller;

  @override
  State<ProgressiveReveal> createState() => _ProgressiveRevealState();
}

class _ProgressiveRevealState extends State<ProgressiveReveal> {
  final ScrollController _scrollController = ScrollController();

  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onReveal);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onReveal);

    _scrollController.dispose();

    super.dispose();
  }

  void _onReveal() {
    if (_visibleCount >= widget.controller.visibleBlocks) {
      return;
    }

    setState(() {
      _visibleCount = widget.controller.visibleBlocks;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToLatest();
    });
  }

  void _scrollToLatest() {
    if (!_scrollController.hasClients) {
      return;
    }

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: 450.ms,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: _visibleCount,
      itemBuilder: (context, index) {
        return LessonBlockRenderer(block: widget.blocks[index])
            .animate()
            .fadeIn(duration: 350.ms)
            .slideY(
              begin: 0.15,
              end: 0,
              duration: 350.ms,
              curve: Curves.easeOut,
            );
      },
    );
  }
}
