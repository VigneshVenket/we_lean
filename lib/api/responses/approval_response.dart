

import '../../models/approval_data.dart';
import '../../utils/app_constants.dart';

class ApprovalResponse {
  String? status;
  String? message;
  ApprovalData? data;
  int? code;

  ApprovalResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory ApprovalResponse.fromJson(Map<String, dynamic> json) {
    return ApprovalResponse(
      status: json['status'],
      message: json['message'],
      data: ApprovalData.fromJson(json['data']),
      code: json['code'],
    );
  }

  ApprovalResponse.withError(String error) {
    status = AppConstants.status_error;
    data = null;
    message = error ;
  }
}