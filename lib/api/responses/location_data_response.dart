


import 'package:we_lean/utils/app_constants.dart';

import '../../models/location_data.dart';

class LocationsResponse {
   String ?status;
   List<Location> ?data;
   int ?code;

  LocationsResponse({required this.status, required this.data, required this.code});

  factory LocationsResponse.fromJson(Map<String, dynamic> json) {
    return LocationsResponse(
      status: json['status'] as String,
      data: (json['data'] as List).map((e) => Location.fromJson(e)).toList(),
      code: json['code'] as int,
    );
  }

  LocationsResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;

  }
}
