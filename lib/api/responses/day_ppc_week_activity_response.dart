

import 'package:we_lean/utils/app_constants.dart';

import '../../models/day_ppc_week_activity.dart';

class DayPpcWeekActivityResponse {
  String ?status;
  List<DayPpcWeekActivity> ?data;
  int ?code;

  DayPpcWeekActivityResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory DayPpcWeekActivityResponse.fromJson(Map<String, dynamic> json) {
    return DayPpcWeekActivityResponse(
      status: json['status'],
      data: (json['data']['WeekActivities'] as List)
          .map((activityJson) => DayPpcWeekActivity.fromJson(activityJson))
          .toList(),
      code: json['code'],
    );
  }

  DayPpcWeekActivityResponse.withError(String error){

    status=AppConstants.status_error;
    data=null;
    code=0;
  }
}
