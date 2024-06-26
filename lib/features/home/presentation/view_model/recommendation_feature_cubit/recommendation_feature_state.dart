part of 'recommendation_feature_cubit.dart';

@immutable
sealed class RecommendationFeatureState {}

final class RecommendationFeatureInitial extends RecommendationFeatureState {}

class UserInfoLoading extends RecommendationFeatureState {}

class UserInfoLoaded extends RecommendationFeatureState {}

class UserInfoFailure extends RecommendationFeatureState {
  final String message;

  UserInfoFailure({required this.message});
}

class PreviousCarLoading extends RecommendationFeatureState {}

class PreviousCarLoaded extends RecommendationFeatureState {}

class PreviousCarFailure extends RecommendationFeatureState {
  final String message;

  PreviousCarFailure({required this.message});
}

class GetModelBrandLoading extends RecommendationFeatureState {}

class GetModelBrandLoaded extends RecommendationFeatureState {
  final PreviousCarEntity previousCarEntity;

  GetModelBrandLoaded({required this.previousCarEntity});
}

class GetModelBrandFailure extends RecommendationFeatureState {
  final String message;

  GetModelBrandFailure({required this.message});
}