

import 'package:we_lean/utils/app_constants.dart';

class LogoutResponse {
  String? status;

  LogoutResponse({this.status});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  LogoutResponse.withError(String error){
    status = AppConstants.status_error;

  }
}