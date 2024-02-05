part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class LoadingState extends RegisterState {}

final class ErrorState extends RegisterState {}

final class OkResponseState extends RegisterState {}

final class LocationPickedState extends RegisterState {
  final GeoPoint? location;
  LocationPickedState({required this.location});
}
