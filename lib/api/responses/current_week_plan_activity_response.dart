

import 'package:we_lean/utils/app_constants.dart';

import '../../models/current_week_plan_activity.dart';

// class CurrentWeekPlanResponse {
//   String? status;
//   CurrentWeekPlanActivity? data;
//   int? code;
//
//   CurrentWeekPlanResponse({
//     required this.status,
//     required this.data,
//     required this.code,
//   });
//
//   // factory CurrentWeekPlanResponse.fromJson(Map<String, dynamic> json) {
//   //   return CurrentWeekPlanResponse(
//   //     status: json['status'],
//   //     data: json['data'] != null ? CurrentWeekPlanActivity.fromJson(json['data']) : null,
//   //     code: json['code'],
//   //   );
//   // }
//
//   factory CurrentWeekPlanResponse.fromJson(dynamic json) {
//     if (json is Map<String, dynamic>) {
//       return CurrentWeekPlanResponse(
//         status: json['status'],
//         data: json['data'] != null ? CurrentWeekPlanActivity.fromJson(json['data']) : null,
//         code: json['code'],
//       );
//     } else {
//       // Handle the case when json is a List<dynamic>
//       // You may choose to return an error response or handle it differently based on your requirements
//       return CurrentWeekPlanResponse.withError('Invalid JSON data');
//     }
//   }
//
//
//
//   CurrentWeekPlanResponse.withError(String error){
//     status=AppConstants.status_error;
//     data=null;
//     code=0;
//   }
// }



class CurrentWeekPlanResponse {
  String? status;
  Map<int, List<WeekActivity>>? data;
  int? code;

  CurrentWeekPlanResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory CurrentWeekPlanResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeekPlanResponse(
      status: json['status'],
      data: json['data'] != null ? (json['data'] as Map<String, dynamic>).map((key, value) => MapEntry(int.parse(key), List<WeekActivity>.from(value.map((x) => WeekActivity.fromJson(x))))) : null,
      code: json['code'],
    );
  }

  CurrentWeekPlanResponse.withError(String error) {
    status = 'error';
    data = null;
    code = 0;
  }
}