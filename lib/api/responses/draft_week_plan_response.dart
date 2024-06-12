
import 'package:we_lean/utils/app_constants.dart';

import '../../models/draft_week_plan.dart';

class DraftWeekPlanResponse {
  String ?status;
  List<DraftWeekPlan> ?data;
  int ?code;

  DraftWeekPlanResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory DraftWeekPlanResponse.fromJson(Map<String, dynamic> json) {
    return DraftWeekPlanResponse(
      status: json['status'],
      data: json['data'] != null ? (json['data'] as List).map((e) => DraftWeekPlan.fromJson(e)).toList() : null,
      code: json['code'],
    );
  }


  DraftWeekPlanResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;
  }
}
