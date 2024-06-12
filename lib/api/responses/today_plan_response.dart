

import 'package:we_lean/utils/app_constants.dart';

import '../../models/today_plan.dart';

class TodayPlanResponse {
  String? status;
  List<TodayPlan>? data;
  int? code;

  TodayPlanResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory TodayPlanResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];
    List<TodayPlan> data = dataList.map((item) => TodayPlan.fromJson(item)).toList();

    return TodayPlanResponse(
      status: json['status'],
      data: data,
      code: json['code'],
    );
  }

  TodayPlanResponse.withError(String error){
    status=AppConstants.status_success;
    data=null;
    code=0;
  }
}
