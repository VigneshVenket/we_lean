

import 'package:we_lean/utils/app_constants.dart';

import '../../models/bar_chart_ppc.dart';

class BarChartResponse {
  String? status;
  BarChartDataModel? data;
  int? code;

  BarChartResponse({required this.status, required this.data, required this.code});

  factory BarChartResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    final BarChartDataModel? data = dataJson != null ? BarChartDataModel.fromJson(dataJson) : null;
    print("response -- ${data!.data}");

    return BarChartResponse(
      status: json['status'],
      data: data,
      code: json['code'],
    );
  }


  BarChartResponse.withError(String error){
       status=AppConstants.status_success;
       data=null;
       code=0;
  }
}
