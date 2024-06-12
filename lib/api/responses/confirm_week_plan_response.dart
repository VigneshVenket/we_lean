



import 'package:we_lean/utils/app_constants.dart';

import '../../models/confirm_week_plan.dart';

class ConfirmWeekPlanResponse {
   String? status;
   String? message;
   ConfirmWeekPlan? data;
   int? code;

  ConfirmWeekPlanResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory ConfirmWeekPlanResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmWeekPlanResponse(
      status: json['status'],
      message: json['message'],
      data: ConfirmWeekPlan.fromJson(json['data']),
      code: json['code'],
    );
  }

  ConfirmWeekPlanResponse.withError(String error){
     status=AppConstants.status_error;
     message=error;
     data=null;
     code=0;
  }

}
