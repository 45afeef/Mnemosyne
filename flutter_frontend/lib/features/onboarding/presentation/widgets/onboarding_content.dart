import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../home/presentation/stagger_animation.dart';
import 'footer_tags.dart';
import 'onboarding_description.dart';
import 'onboarding_logo.dart';
import 'onboarding_title.dart';
import 'primary_cta_button.dart';
import 'secondary_action.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.mobileMargin,
          vertical: 48,
        ),
        child: Column(
          children: [
            const OnboardingLogo().stagger(0),

            const SizedBox(height: 56),

            const OnboardingTitle().stagger(1),

            const SizedBox(height: 20),

            const OnboardingDescription().stagger(2),

            const Spacer(),

            const PrimaryCTAButton().stagger(3),

            const SizedBox(height: 28),

            const SecondaryAction().stagger(4),

            const SizedBox(height: 28),

            const FooterTags().stagger(5),
          ],
        ),
      ),
    );
  }
}
