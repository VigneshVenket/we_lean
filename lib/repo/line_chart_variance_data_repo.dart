

import 'package:we_lean/api/responses/line_chart_variance_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class LineChartVarianceDataRepo {
  Future<LineChartVarianceResponse> getLineChartVarianceData(String variance_ids);

}

class RealLineChartVarianceDataRepo implements LineChartVarianceDataRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<LineChartVarianceResponse> getLineChartVarianceData(String variance_ids){
    return _apiProvider.getLineChartVarianceData(variance_ids);
  }

}