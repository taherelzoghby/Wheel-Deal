import 'package:cars/core/consts/style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'load_widget.dart';

class ShimmerLoadingHome extends StatelessWidget {
  const ShimmerLoadingHome({
    super.key,
    this.widthComponent,
  });

  final double? widthComponent;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: AppConsts.neutral800.withOpacity(.7),
      highlightColor: AppConsts.black,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          5,
          (c) => LoadWidget(width: widthComponent),
        ),
      ),
    );
  }
}
