import 'package:cars/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'two_step_method.dart';
import 'two_step_verification_widget.dart';

class TwoStepVerificationBody extends StatelessWidget {
  const TwoStepVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConsts.mainPadding,
      child: const Column(
        children: [
          AspectRatio(aspectRatio: AppConsts.aspectRatioTopSpace),
          TwoStepVerificationWidget(),
          AspectRatio(aspectRatio: AppConsts.aspectRatio20on1),
          TwoStepMethod(),
        ],
      ),
    );
  }
}
