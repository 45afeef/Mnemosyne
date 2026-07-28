import 'package:flutter/material.dart';
import 'package:mnemosyne_learn/app/theme/app_buttons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

class NewGoalPage extends StatefulWidget {
  const NewGoalPage({super.key});

  @override
  State<NewGoalPage> createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  int _selectedMinutes = 30;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryContainer,
              surface: AppColors.surfaceContainer,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      _deadlineController.text = "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  void dispose() {
    _goalController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.mobileMargin,
            12,
            AppSpacing.mobileMargin,
            20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: PrimaryCTAButton(
                  leadingIcon: Icons.bolt,
                  text: "GENERATE LEARNING PATH",
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 12),
              Text(
                "AI-powered curriculum tailoring",
                style: TextStyle(
                  color: AppColors.outline.withOpacity(.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.mobileMargin),
              children: [
                const SizedBox(height: 48),

                /// HERO
                Center(
                  child: Column(
                    children: [
                      Container(
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

                      const SizedBox(height: 20),

                      const Text(
                        "What's your next mission?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Define your objective and let Mnemosyne map out the optimal learning sequence for you.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                _sectionTitle("Learning Goal"),

                const SizedBox(height: 8),

                _textField(
                  controller: _goalController,
                  icon: Icons.psychology_outlined,
                  hint: "e.g. Learn Machine Learning",
                ),

                const SizedBox(height: 28),

                _sectionTitle("Optional Deadline"),

                const SizedBox(height: 8),

                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: _textField(
                      controller: _deadlineController,
                      icon: Icons.calendar_today,
                      hint: "Set a target date",
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                _sectionTitle("Daily Commitment"),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(child: _timeChip(15)),
                    const SizedBox(width: 12),
                    Expanded(child: _timeChip(30)),
                    const SizedBox(width: 12),
                    Expanded(child: _timeChip(60)),
                  ],
                ),

                const SizedBox(height: 48),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.outlineVariant.withOpacity(.3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.auto_awesome, color: AppColors.outline),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.outlineVariant.withOpacity(.3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

  Widget _textField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.onSurface),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.outline),
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.outlineVariant),
        filled: true,
        fillColor: AppColors.surfaceLow,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.outlineVariant,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _timeChip(int minutes) {
    final selected = _selectedMinutes == minutes;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: () {
        setState(() {
          _selectedMinutes = minutes;
        });
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
                fontWeight: FontWeight.bold,
                fontSize: 24,
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
}
