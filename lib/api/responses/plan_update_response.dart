

import 'package:we_lean/utils/app_constants.dart';

import '../../models/plan_upadate.dart';

class PlanUpdateResponse {
  String? status;
  String? message;
  PlanUpdate? data;
  int ?code;

  PlanUpdateResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory PlanUpdateResponse.fromJson(Map<String, dynamic> json) {
    return PlanUpdateResponse(
      status: json['status'],
      message: json['message'],
      data: PlanUpdate.fromJson(json['data']),
      code: json['code'],
    );
  }

  PlanUpdateResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    message=error;
    code=0;
  }
}
