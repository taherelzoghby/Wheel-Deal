import 'package:cars/core/services/service_locator.dart';
import 'package:cars/core/widgets/custom_app_bar_scaffold.dart';
import 'package:cars/core/widgets/custom_squre_button.dart';
import 'package:cars/features/favourites/data/repos/favourites_repo_impl.dart';
import 'package:cars/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:cars/features/favourites/domain/use_cases/delete_favourite_use_case.dart';
import 'package:cars/features/favourites/domain/use_cases/get_favourites_use_case.dart';
import 'package:cars/features/favourites/presentation/manager/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/consts/strings.dart';
import '../widgets/favourites_body.dart';

class FavouritesViewBlocProvider extends StatelessWidget {
  const FavouritesViewBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarScaffold(
        leading: CustomSquareButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => GoRouter.of(context).pop(),
        ),
        title: StringsEn.favourites,
      ),
      body: BlocProvider(
        create: (_) => FavouritesBloc(
          GetFavouritesUseCase(
            favouritesRepo: getIt.get<FavouritesRepoImpl>(),
          ),
          AddFavUseCase(
            favouritesRepo: getIt.get<FavouritesRepoImpl>(),
          ),
          DeleteFavUseCase(
            favouritesRepo: getIt.get<FavouritesRepoImpl>(),
          ),
        )..add(GetFavEvent()),
        child: const SafeArea(
          child: FavouritesBody(),
        ),
      ),
    );
  }
}