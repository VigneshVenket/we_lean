

import 'package:we_lean/utils/app_constants.dart';

import '../../models/weekly_plan.dart';

class WeeklyPlanResponse {
  String? status;
  WeeklyPlanData? data;

  WeeklyPlanResponse({
    required this.status,
    required this.data,
  });

  factory WeeklyPlanResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyPlanResponse(
      status: json['status'],
      data: WeeklyPlanData.fromJson(json['data']),
    );
  }

  WeeklyPlanResponse.withError(String error){
     status=AppConstants.status_error;
     data=null;
  }
}

class WeeklyPlanData {
  final WeeklyPlan weekplan;

  WeeklyPlanData({
    required this.weekplan,
  });

  factory WeeklyPlanData.fromJson(Map<String, dynamic> json) {
    return WeeklyPlanData(
      weekplan: WeeklyPlan.fromJson(json['weekplan']),
    );
  }
}
