import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../widgets/entry_card.dart';

class SessionEnrtyPage extends StatefulWidget {
  const SessionEnrtyPage({super.key});

  @override
  State<SessionEnrtyPage> createState() => _SessionEnrtyPageState();
}

class _SessionEnrtyPageState extends State<SessionEnrtyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.mobileMargin,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Python Basics",
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.account_circle, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const _AmbientGlow(),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.mobileMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "How do you want to learn?",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Select a cognitive path for your session.",
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    LearningEntryCard(
                      title: "🧠 Intuition",
                      subtitle: "Conceptual overview & mental models",
                      icon: Icons.psychology,
                      accent: AppColors.primary,
                      container: AppColors.primaryContainer,
                      onTap: () {},
                    ),

                    const SizedBox(height: AppSpacing.md),

                    LearningEntryCard(
                      title: "🏛 Structure",
                      subtitle: "Detailed breakdown & logical flow",
                      icon: Icons.account_tree,
                      accent: AppColors.secondary,
                      container: AppColors.secondary,
                      onTap: () {
                        context.push(Routes.lessonSession);
                      },
                    ),

                    const SizedBox(height: AppSpacing.md),

                    LearningEntryCard(
                      title: "⚡ Drill",
                      subtitle: "Rapid-fire recall & core facts",
                      icon: Icons.bolt,
                      accent: AppColors.tertiary,
                      container: AppColors.tertiary,
                      onTap: () {},
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    Divider(color: AppColors.surfaceHigh),

                    const SizedBox(height: AppSpacing.md),

                    const Center(
                      child: Opacity(
                        opacity: .65,
                        child: Text(
                          "\"The art of memory is the art of attention.\"",
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            center: Alignment(-0.2, -0.6),
            colors: [Color(0x18C0C1FF), Colors.transparent],
          ),
        ),
      ),
    );
  }
}
