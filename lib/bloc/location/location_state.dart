


import '../../models/location_data.dart';

abstract class LocationsState {}

class LocationsInitial extends LocationsState {}

class LocationsLoading extends LocationsState {}

class LocationsLoaded extends LocationsState {
  final List<Location> locations;

  LocationsLoaded({required this.locations});
}

class LocationsError extends LocationsState {
  final String message;

  LocationsError({required this.message});
}
