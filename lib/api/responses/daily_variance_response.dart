

import 'dart:convert';

import 'package:we_lean/utils/app_constants.dart';

import '../../models/daily_variance.dart';

class VarianceApiResponse {
  String ?status;
  List<DailyVariance> ?data;
  int ?code;

  VarianceApiResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory VarianceApiResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonDataList = json['data'];
    List<DailyVariance> dailyVarianceList = jsonDataList.map((data) => DailyVariance.fromJson(data)).toList();

    return VarianceApiResponse(
      status: json['status'],
      data: dailyVarianceList,
      code: json['code'],
    );
  }

  VarianceApiResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;
  }
}
