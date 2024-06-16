import 'package:bloc/bloc.dart';
import 'package:cars/core/consts/enums.dart';
import 'package:cars/features/home/domain/entities/car_entity.dart';
import 'package:cars/features/search/data/models/recent_search_model.dart';
import 'package:cars/features/search/domain/use_cases/delete_recent_search_use_case.dart';
import 'package:cars/features/search/domain/use_cases/recent_search_use_case.dart';
import 'package:cars/features/search/domain/use_cases/search_use_case.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetRecentSearchUseCase _getRecentSearchUseCase;
  final SearchUseCase _searchUseCase;
  final DeleteRecentSearchUseCase _deleteRecentSearchUseCase;

  SearchCubit(
    this._getRecentSearchUseCase,
    this._searchUseCase,
    this._deleteRecentSearchUseCase,
  ) : super(const SearchState());
  bool initial = true;

  changeFieldSearch(String value) async {
    initial = false;
    await search(searchWord: value);
  }

  search({required String searchWord}) async {
    emit(state.copyWith(searchState: RequestState.loading));
    await _searchUseCase.call(searchWord).then(
          (value) => value.fold(
            (failure) {
              emit(
                state.copyWith(
                  searchState: RequestState.error,
                  failureMessageSearch: failure.message,
                ),
              );
            },
            (cars) {
              emit(
                state.copyWith(
                  searchState: RequestState.loaded,
                  searchList: cars,
                ),
              );
            },
          ),
        );
  }

//get recent search cars
  recentSearch() async {
    await _getRecentSearchUseCase.call().then(
          (value) => value.fold(
            (failure) {
              emit(
                state.copyWith(
                  recentSearchState: RequestState.error,
                  failureMessageRecentSearch: failure.message,
                ),
              );
            },
            (recentSearchCars) {
              emit(
                state.copyWith(
                  recentSearchState: RequestState.loaded,
                  recentSearchList: recentSearchCars,
                ),
              );
            },
          ),
        );
  }

//delete recent search by search word
  deleteRecentSearch({required String searchWord}) async {
    emit(
      state.copyWith(deleteRecentSearchState: RequestState.loading),
    );
    await _deleteRecentSearchUseCase.call(searchWord).then(
      (value) {
        value.fold(
          (failure) {
            emit(
              state.copyWith(
                deleteRecentSearchState: RequestState.error,
                failureMessageDeleteRecentSearch: failure.message,
              ),
            );
          },
          (success) {
            emit(
              state.copyWith(deleteRecentSearchState: RequestState.loaded),
            );
          },
        );
      },
    );
  }
}