



import 'package:we_lean/api/responses/location_data_response.dart';
import 'package:we_lean/api/responses/overall_ppc_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class LocationRepo {
  Future<LocationsResponse> getLocation();

}

class RealLocationRepo implements  LocationRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<LocationsResponse> getLocation() {
    return _apiProvider.getLocation();
  }

}