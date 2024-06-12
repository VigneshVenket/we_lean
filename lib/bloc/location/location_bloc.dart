
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/location_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationRepo locationRepo;

  LocationsBloc({required this.locationRepo}) : super(LocationsInitial());

  @override
  Stream<LocationsState> mapEventToState(LocationsEvent event) async* {
    if (event is FetchLocations) {
      yield LocationsLoading();
      try {
        final locationResponse = await locationRepo.getLocation();
        if(locationResponse.status==AppConstants.status_success){
          yield LocationsLoaded(locations: locationResponse.data!);
        }else{
          yield LocationsError(message: locationResponse.status!);
        }

      } catch (e) {
        yield LocationsError(message: e.toString());
      }
    }
  }
}