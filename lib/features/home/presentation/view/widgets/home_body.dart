import 'package:cars/core/consts/assets.dart';
import 'package:cars/core/consts/routesPage.dart';
import 'package:cars/core/consts/strings.dart';
import 'package:cars/core/consts/style.dart';
import 'package:cars/core/widgets/custom_app_bar.dart';
import 'package:cars/features/home/presentation/view/widgets/categories_section.dart';
import 'package:cars/features/home/presentation/view/widgets/search_location_section.dart';
import 'package:cars/features/home/presentation/view/widgets/special_offer_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        //custom appBar
        CustomAppBar(
          image: Assets.imagesLogo,
          title: StringsEn.logo,
          trailingOnTap: () => GoRouter.of(context).push(favouritesPath),
          trailingWidget: const Icon(
            Icons.favorite,
            color: AppConsts.primary300,
          ),
        ),

        //search section
        const SearchLocationSection(),
        const AspectRatio(aspectRatio:  AppConsts.aspectRatioTopSpace),
        //special offer section
        const SpecialOfferSection(),
        const AspectRatio(aspectRatio:  AppConsts.aspectRatioTopSpace),
        //categories section
        const CategoriesSection(),
      ],
    );
  }
}
