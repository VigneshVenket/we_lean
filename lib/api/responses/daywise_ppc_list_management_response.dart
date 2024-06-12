



import 'package:we_lean/utils/app_constants.dart';

import '../../models/day_wise_ppc_list.dart';

class DayWisePPCManagementResponse {
  String ?status;
  DayWisePPCList ?data;
  int ?code;

  DayWisePPCManagementResponse({required this.status, required this.data, required this.code});

  factory DayWisePPCManagementResponse.fromJson(Map<String, dynamic> json) {
    return DayWisePPCManagementResponse(
      status: json['status'],
      data: DayWisePPCList.fromJson(json['data']),
      code: json['code'],
    );
  }

  DayWisePPCManagementResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;

  }
}
