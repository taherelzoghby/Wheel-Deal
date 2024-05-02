import 'package:cars/core/consts/strings.dart';
import 'package:cars/core/consts/style.dart';
import 'package:cars/features/verification/presentation/view/widgets/tile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_divider.dart';

class ContentBottomSheetLanguage extends StatelessWidget {
  const ContentBottomSheetLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConsts.mainPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TileBottomSheet(
            label: StringsEn.english,
            onTap: () {},
          ),
          const CustomDivider(),
          TileBottomSheet(
            label: StringsEn.arabic,
            onTap: () {},
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
