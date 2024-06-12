




import 'package:we_lean/api/responses/today_plan_response.dart';

import '../api/apiData/api_provider.dart';

abstract class TodayPlanRepo {
  Future<TodayPlanResponse> getTodatPlan(int user_id);
  Future<TodayPlanResponse> getTodatPlanLocationwise(int user_id,int proj_loc_id);

}

class RealTodayPlanRepo implements TodayPlanRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<TodayPlanResponse> getTodatPlan(int user_id){
    return _apiProvider.getTodayPlan(user_id);
  }

  Future<TodayPlanResponse> getTodatPlanLocationwise(int user_id,int proj_loc_id){
    return _apiProvider.getTodayPlanLocationwise(user_id, proj_loc_id);
  }

}