

import 'package:we_lean/utils/app_constants.dart';

class DeleteWeekActivityResponse {
  String? status;
  String? message;
  int? code;

  DeleteWeekActivityResponse({required this.status, required this.message, required this.code});

  factory DeleteWeekActivityResponse.fromJson(Map<String, dynamic> json) {
    return DeleteWeekActivityResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
    );
  }

  DeleteWeekActivityResponse.withError(String error){
    status=AppConstants.status_error;
    message=error;
    code=0;
  }

}
