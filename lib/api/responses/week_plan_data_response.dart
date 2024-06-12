

import '../../models/week_plan_data.dart';

class WeekPlanDataResponse {
  final String status;
  final WeekPlanData data;
  final int code;

  WeekPlanDataResponse({required this.status, required this.data, required this.code});

  factory WeekPlanDataResponse.fromJson(Map<String, dynamic> json) {
    return WeekPlanDataResponse(
      status: json['status'],
      data: WeekPlanData.fromJson(json['data']),
      code: json['code'],
    );
  }

}