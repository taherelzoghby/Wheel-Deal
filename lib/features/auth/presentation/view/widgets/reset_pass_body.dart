import 'package:cars/core/consts/style.dart';
import 'package:cars/features/auth/presentation/view/widgets/reset_pass_body_info.dart';
import 'package:flutter/material.dart';

class ResetPassBody extends StatelessWidget {
  const ResetPassBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 13,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppConsts.radiusTop15,
              color: Theme.of(context).splashColor,
            ),
            child: const ResetPassBodyInfo(),
          ),
        ),
      ],
    );
  }
}
