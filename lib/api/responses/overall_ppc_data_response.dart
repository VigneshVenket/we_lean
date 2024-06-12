

import 'package:we_lean/utils/app_constants.dart';

import '../../models/overall_ppc_data.dart';

class OverallPPCResponse {
  String? status;
  OverallPPCData? data;
  int? code;

  OverallPPCResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory OverallPPCResponse.fromJson(Map<String, dynamic> json) {
    return OverallPPCResponse(
      status: json['status'],
      data: json['data'] != null ? OverallPPCData.fromJson(json['data']) : null,
      code: json['code'],
    );
  }


  OverallPPCResponse.withError(String error){
     status=AppConstants.status_error;
     data=null;
     code=0;
  }
}
