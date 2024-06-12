
import 'package:equatable/equatable.dart';
import 'package:we_lean/utils/app_constants.dart';

import '../../models/average_ppc_data.dart';

class AveragePPCDataResponse {
  String? status;
  AveragePPCDataDetail? data;
  int? code;

  AveragePPCDataResponse({
    required this.status,
    this.data,
    required this.code,
  });

  factory AveragePPCDataResponse.fromJson(Map<String, dynamic> json) {
    return AveragePPCDataResponse(
      status: json['status'],
      data: json['data'] != null ? AveragePPCDataDetail.fromJson(json['data']) : null,
      code: json['code'],
    );
  }

  AveragePPCDataResponse.withError(String error) {
    status = AppConstants.status_error;
    data = null;
    code = 0;
  }
}


