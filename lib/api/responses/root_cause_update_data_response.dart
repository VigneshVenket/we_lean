


import 'package:we_lean/utils/app_constants.dart';

import '../../models/root_cause_update_data.dart';

class RootCauseUpdateResponse {
  String? status;
  RootCauseUpdateData? data;
  int? code;

  RootCauseUpdateResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory RootCauseUpdateResponse.fromJson(Map<String, dynamic> json) {
    return RootCauseUpdateResponse(
      status: json['status'],
      data: RootCauseUpdateData.fromJson(json['data']),
      code: json['code'],
    );
  }

  RootCauseUpdateResponse.withError(String error){
    status=error;
    data=null;
    code=0;
  }

}