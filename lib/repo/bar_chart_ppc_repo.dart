

import 'package:we_lean/api/responses/bar_chart_ppc_response.dart';

import '../api/apiData/api_provider.dart';

abstract class BarChartPpcRepo {
  Future<BarChartResponse> getBarchartPpc(int user_id);
  Future<BarChartResponse> getBarchartPpcLocationwise(int user_id,int proj_loc_id);

}

class RealBarChartPpcRepo implements BarChartPpcRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<BarChartResponse> getBarchartPpc(int user_id){
    return _apiProvider.getBarChartPpc(user_id);
  }

  Future<BarChartResponse> getBarchartPpcLocationwise(int user_id,int proj_loc_id){
     return _apiProvider.getBarChartPpcLocationwise(user_id, proj_loc_id);
  }

}