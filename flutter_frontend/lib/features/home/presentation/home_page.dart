import 'package:flutter/material.dart';

import '../../../app/theme/app_buttons.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../lesson/presentation/pages/debug_lesson_page.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/current_topic_card.dart';
import 'widgets/daily_goal_card.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/recent_activity.dart';
import 'widgets/review_due_card.dart';
import 'widgets/upcoming_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const HomeAppBar(),

      bottomNavigationBar: const HomeBottomNavigation(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - AppSpacing.mobileMargin * 2,
        child: PrimaryCTAButton(
          text: "Continue",
          icon: Icons.play_arrow,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const DebugLessonPage(),
              ),
            );

            // context.push(Routes.learnEntry);
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.mobileMargin,
            AppSpacing.md,
            AppSpacing.mobileMargin,
            120,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DailyGoalCard(),
              SizedBox(height: AppSpacing.lg),

              CurrentTopicCard(),
              SizedBox(height: AppSpacing.lg),

              ReviewDueCard(),
              SizedBox(height: AppSpacing.md),

              UpcomingCard(),
              SizedBox(height: AppSpacing.lg),

              RecentActivity(),
            ],
          ),
        ),
      ),
    );
  }
}
