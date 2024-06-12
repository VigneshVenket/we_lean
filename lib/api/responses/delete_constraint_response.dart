

import 'package:we_lean/utils/app_constants.dart';

class DeleteConstraintLogResponse {
  String ?status;
  String ?message;
  int ?code;

  DeleteConstraintLogResponse({
    required this.status,
    required this.message,
    required this.code,
  });

  factory DeleteConstraintLogResponse.fromJson(Map<String, dynamic> json) {
    return DeleteConstraintLogResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
    );
  }

  DeleteConstraintLogResponse.withError(String error){
    status=AppConstants.status_error;
    message=error;
    code=0;
  }

}
