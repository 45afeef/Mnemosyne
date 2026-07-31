import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {

  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,

      backgroundColor: AppColors.surfaceContainer,

      destinations: const [
        NavigationDestination(icon: Icon(Icons.school), label: "Learn"),

        NavigationDestination(icon: Icon(Icons.history), label: "Review"),

        NavigationDestination(icon: Icon(Icons.analytics), label: "Stats"),

        NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
