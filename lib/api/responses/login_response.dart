

import 'package:we_lean/utils/app_constants.dart';

import '../../models/user.dart';

class LoginResponse {
  String? status;
  User? data;
  String? message;
  Map<String, List<String>> ?errors;

  LoginResponse({this.status, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
    message = json['message'];
  }

  LoginResponse.fromErrorJson(Map<String, dynamic> json) {
    status = AppConstants.status_error;
    data = null;
    message = json['message'] ;
  }

  LoginResponse.withError(String error) {
    status = AppConstants.status_error;
    data = null;
    message = error ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = message;
    return data;
  }

}