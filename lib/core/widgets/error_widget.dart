import 'package:cars/core/consts/strings.dart';
import 'package:cars/core/consts/style.dart';
import 'package:flutter/material.dart';

class SomeThingErrorWidget extends StatelessWidget {
  const SomeThingErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringsEn.someThingError,
            style: AppConsts.style24,
          ),
        ],
      ),
    );
  }
}
