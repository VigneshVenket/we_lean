

import 'package:equatable/equatable.dart';
import 'package:we_lean/utils/app_constants.dart';

class AveragePPCBargraphResponse {
  String ?status;
  Map<String, int>? data;
  int? code;

  AveragePPCBargraphResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory AveragePPCBargraphResponse.fromJson(Map<String, dynamic> json) {
    return AveragePPCBargraphResponse(
      status: json['status'],
      data: Map<String, int>.from(json['data']),
      code: json['code'],
    );
  }

  AveragePPCBargraphResponse.withError(String error){
     status =AppConstants.status_error;
     data=null;
     code=0;
  }

}
