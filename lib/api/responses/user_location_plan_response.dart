
import '../../models/user_location_plan.dart';
import '../../utils/app_constants.dart';

class UserLocationPlanResponse {
  String? status;
  List<UserLocationPlan>? data;
  int? code;
  String? message;

  UserLocationPlanResponse({
    required this.status,
    this.data,
    required this.code,
    this.message,
  });

  factory UserLocationPlanResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == AppConstants.status_success) {
      return UserLocationPlanResponse(
        status: json['status'],
        data: json['data'] != null
            ? (json['data'] as List).map((e) => UserLocationPlan.fromJson(e)).toList()
            : [],
        code: json['code'],
      );
    } else {
      // Handle the case where data is null
      return UserLocationPlanResponse(
        status: json['status'],
        message: json['message'],
        code: json['code'],
      );
    }
  }

  UserLocationPlanResponse.withError(String error) {
    status = AppConstants.status_error;
    data = null;
    code = 0;
  }
}

