

import 'package:we_lean/utils/app_constants.dart';

import '../../models/day_wise_ppc_list.dart';

class DayWisePPCResponse {
  String ?status;
  DayWisePPCList ?data;
  int ?code;

  DayWisePPCResponse({required this.status, required this.data, required this.code});

  factory DayWisePPCResponse.fromJson(Map<String, dynamic> json) {
    return DayWisePPCResponse(
      status: json['status'],
      data: DayWisePPCList.fromJson(json['data']),
      code: json['code'],
    );
  }

  DayWisePPCResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;

  }
}
