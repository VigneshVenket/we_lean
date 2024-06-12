

import 'package:we_lean/api/responses/week_variance_graph_response.dart';

import '../api/apiData/api_provider.dart';

abstract class WeekVariancePpcRepo {
  Future<WeekVariancePPCResponse> getWeekVariance(int userId);
  Future<WeekVariancePPCResponse> getWeekVarianceLocationwise(int userId,int proj_loc_id);

}

class RealWeekVariancePpcRepo implements  WeekVariancePpcRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WeekVariancePPCResponse> getWeekVariance(int userId) {
    return _apiProvider.getWeekVariance(userId);
  }

  Future<WeekVariancePPCResponse> getWeekVarianceLocationwise(int userId,int proj_loc_id){
    return _apiProvider.getWeekVarianceLocationwise(userId, proj_loc_id);
  }

}

