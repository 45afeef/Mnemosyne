import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mnemosyne_learn/app/router/routes.dart';
import 'package:mnemosyne_learn/features/syllabus/presentation/pages/generating_roadmap_page.dart';

import '../../../../app/theme/app_buttons.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../provider/goal_provider.dart';
import '../provider/syllabus_provider.dart';

class NewGoalPage extends ConsumerStatefulWidget {
  const NewGoalPage({super.key});

  @override
  ConsumerState<NewGoalPage> createState() => _NewGoalPageState();
}

class _NewGoalPageState extends ConsumerState<NewGoalPage> {
  final TextEditingController _goalController = TextEditingController();

  final TextEditingController _deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(goalNotifierProvider.notifier).startCreatingGoal();
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      _deadlineController.text = "${date.day}/${date.month}/${date.year}";

      ref.read(goalNotifierProvider.notifier).updateEndDate(date);
    }
  }

  void _saveGoal() {
    ref.read(goalNotifierProvider.notifier).saveGoal();

    final goal = ref.read(goalNotifierProvider).selectedGoal;

    if (goal == null) return;

    ref
        .read(syllabusNotifierProvider.notifier)
        .generateSyllabus(goalId: goal.id);

    context.push(Routes.generatingRoadmap);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goalNotifierProvider);

    final draft = state.draftGoal;

    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.mobileMargin),
          child: PrimaryCTAButton(
            leadingIcon: Icons.bolt,
            text: "GENERATE LEARNING PATH",

            onPressed: _saveGoal,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.mobileMargin),

          children: [
            const SizedBox(height: 48),
            Center(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withOpacity(.08),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: AppColors.primary,
                  size: 48,
                ),
              ),
            ),

            const Text(
              "What's your next mission?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.onSurface,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 48),

            _sectionTitle("Learning Goal"),

            const SizedBox(height: 8),

            TextField(
              controller: _goalController,

              onChanged: (value) {
                ref.read(goalNotifierProvider.notifier).updateName(value);
              },

              style: const TextStyle(color: AppColors.onSurface),

              decoration: _inputDecoration(
                Icons.psychology_outlined,
                "e.g. Learn Machine Learning",
              ),
            ),

            const SizedBox(height: 28),

            _sectionTitle("Optional Deadline"),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: _pickDate,

              child: AbsorbPointer(
                child: TextField(
                  controller: _deadlineController,

                  decoration: _inputDecoration(
                    Icons.calendar_today,
                    "Set a target date",
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            _sectionTitle("Daily Commitment"),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: _timeChip(15, draft?.dailyCommitment)),

                const SizedBox(width: 12),

                Expanded(child: _timeChip(30, draft?.dailyCommitment)),

                const SizedBox(width: 12),

                Expanded(child: _timeChip(60, draft?.dailyCommitment)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeChip(int minutes, Duration? commitment) {
    final selected = commitment == Duration(minutes: minutes);

    return InkWell(
      onTap: () {
        ref
            .read(goalNotifierProvider.notifier)
            .updateDailyCommitment(Duration(minutes: minutes));
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(vertical: 18),

        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryContainer.withOpacity(.15)
              : AppColors.surfaceLow,

          borderRadius: BorderRadius.circular(AppRadius.lg),

          border: Border.all(
            color: selected ? AppColors.primary : AppColors.outlineVariant,

            width: 2,
          ),
        ),

        child: Column(
          children: [
            Text(
              "$minutes",
              style: TextStyle(
                color: selected ? AppColors.primary : AppColors.onSurface,

                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "mins/day",
              style: TextStyle(
                color: selected
                    ? AppColors.primary
                    : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text.toUpperCase(),

      style: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        fontSize: 12,
      ),
    );
  }

  InputDecoration _inputDecoration(IconData icon, String hint) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.outline),

      hintText: hint,

      filled: true,

      fillColor: AppColors.surfaceLow,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }
}
