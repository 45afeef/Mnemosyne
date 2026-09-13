import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../domain/entities/learning_goal.dart';
import '../provider/goal_provider.dart';
import '../provider/syllabus_provider.dart';

class GoalListPage extends ConsumerStatefulWidget {
  const GoalListPage({super.key});

  @override
  ConsumerState<GoalListPage> createState() => _GoalListPageState();
}

class _GoalListPageState extends ConsumerState<GoalListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(goalNotifierProvider.notifier).loadGoals();
    });
  }

  Future<void> _onSelectGoal(LearningGoal goal) async {
    final goalNotifier = ref.read(goalNotifierProvider.notifier);
    final syllabusNotifier = ref.read(syllabusNotifierProvider.notifier);

    // mark selected in state
    goalNotifier.selectGoal(goal);

    // try to find existing syllabus for this goal
    final syllabusRepo = syllabusNotifier.repository;

    final existing = await syllabusRepo.getLatestSyllabusForGoal(goal.id);

    // set current goal id
    await syllabusRepo.setCurrentGoalId(goal.id);

    if (existing != null) {
      // load existing syllabus
      await syllabusNotifier.loadSyllabus(existing.id);
      context.go(Routes.home);
    } else {
      // generate new syllabus for this goal
      await syllabusNotifier.generateSyllabus(goal: goal);
      context.go(Routes.generatingRoadmap);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goalNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Learning Goals')),
      body: ListView.builder(
        itemCount: state.goals.length + 1,
        itemBuilder: (context, index) {
          if (index == state.goals.length) {
            return ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create new goal'),
              onTap: () => context.push(Routes.goalSettingPage),
            );
          }

          final goal = state.goals[index];

          return ListTile(
            title: Text(goal.name),
            subtitle: goal.description != null ? Text(goal.description!) : null,
            trailing: state.selectedGoal?.id == goal.id
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () => _onSelectGoal(goal),
          );
        },
      ),
    );
  }
}
