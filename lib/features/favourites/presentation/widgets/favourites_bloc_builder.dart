import 'package:cars/core/consts/assets.dart';
import 'package:cars/core/widgets/empty_widget.dart';
import 'package:cars/core/widgets/error_widget.dart';
import 'package:cars/features/home/domain/entities/car_entity.dart';
import 'package:cars/features/home/presentation/view/widgets/loading_shimmer_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/consts/enums.dart';
import '../manager/favourite_cubit.dart';
import 'favourites_grid_view.dart';

class FavouritesBlocBuilder extends StatefulWidget {
  const FavouritesBlocBuilder({super.key});

  @override
  State<FavouritesBlocBuilder> createState() => _FavouritesBlocBuilderState();
}

class _FavouritesBlocBuilderState extends State<FavouritesBlocBuilder> {
  List<CarEntity> favourites = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        if (state.getFavouritesState == RequestState.loaded ||
            state.deleteFavouritesState == RequestState.loaded) {
          favourites = context.read<FavouriteCubit>().favouritesList;
          return favourites.isEmpty
              ? const EmptyWidget(icon: Assets.favAsset)
              : FavouritesGridView(favourites: favourites);
        } else if (state.getFavouritesState == RequestState.error) {
          return SomeThingErrorWidget(
            message: state.getFavouritesFailureMessage,
          );
        } else {
          return const LoadingCarsGridViewShimmer();
        }
      },
    );
  }
}
