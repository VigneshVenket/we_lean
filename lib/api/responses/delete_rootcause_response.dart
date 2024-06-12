


import '../../models/delete_rootcause_data.dart';

class RootCauseDeleteResponse {
  String? status;
  RootCause? data;
  int? code;

  RootCauseDeleteResponse({this.status, this.data, this.code});

  RootCauseDeleteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? RootCause.fromJson(json['data']) : null;
    code = json['code'];
  }

  RootCauseDeleteResponse.withError(String error) {
    status = error;
    data = null;
    code = 0;
  }
}
