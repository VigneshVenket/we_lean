

import 'package:we_lean/utils/app_constants.dart';

import '../../models/variance_log_action.dart';

class AddVarianceLogActionResponse {
  String? status;
  VarianceLogAction? data;
  int? code;

  AddVarianceLogActionResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory AddVarianceLogActionResponse.fromJson(Map<String, dynamic> json) {
    return AddVarianceLogActionResponse(
      status: json['status'],
      data: VarianceLogAction.fromJson(json['data']),
      code: json['code'],
    );
  }

  AddVarianceLogActionResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;
  }
}
