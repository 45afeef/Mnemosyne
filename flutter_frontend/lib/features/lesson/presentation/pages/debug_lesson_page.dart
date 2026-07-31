import 'package:flutter/material.dart';

import '../pages/lesson_page.dart';
import '../models/lesson_block.dart';
import '../widgets/assistant_chip_bar.dart';

class DebugLessonPage extends StatelessWidget {
  const DebugLessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonPage(
      title: "Neural Networks",

      progress: 0.25,

      blocks: const [
        HeadingBlock(text: "What is a Neuron?"),

        ParagraphBlock(
          markdown: """
Think of a **biological neuron** in your brain.

It receives signals, processes them, and decides whether to pass them on.
""",
        ),

        ParagraphBlock(
          markdown: """
An **artificial neuron** is a mathematical function.

It takes inputs, applies weights, combines them and produces an output.
""",
        ),

        ImageBlock(
          imageUrl: "https://dummyimage.com/800x400/122131/c0c1ff",
          caption: "Single Node Architecture",
        ),

        QuoteBlock(
          markdown: """
The neuron is the fundamental building block of neural networks.
""",
        ),
      ],

      assistantActions: [
        AssistantAction(label: "Explain differently", onTap: _noop),

        AssistantAction(label: "Need example", onTap: _noop),

        AssistantAction(label: "Ask question", onTap: _noop),
      ],

      onNext: _noop,
    );
  }

  static void _noop() {}
}
