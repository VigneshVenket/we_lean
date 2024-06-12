

import 'package:we_lean/utils/app_constants.dart';

import '../../models/line_chart_variance_data.dart';

class LineChartVarianceResponse {
  String? status;
  List<LineChartVarianceData> ?data;
  Map<int, String>? whyGroups; // New field for why groups
  int ?code;

  LineChartVarianceResponse({this.status, this.data, this.code,this.whyGroups});

  LineChartVarianceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data']['variancelogs']!= null) {
      data = <LineChartVarianceData>[];
      json['data']['variancelogs'].forEach((v) {
        data?.add(LineChartVarianceData.fromJson(v));
      });
    }
    if (json['data']['why_groups'] != null) {
      whyGroups = (json['data']['why_groups'] as Map<String, dynamic>).map((key, value) => MapEntry(int.parse(key), value));
    }
    code = json['code'];
  }

  LineChartVarianceResponse.withError(String error){
    status=AppConstants.status_success;
    data=null;
    code=0;
  }
}