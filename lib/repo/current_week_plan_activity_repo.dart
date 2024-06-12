

import 'package:we_lean/api/responses/current_week_plan_activity_response.dart';

import '../api/apiData/api_provider.dart';

abstract class CurrentWeekPlanRepo {
  Future<CurrentWeekPlanResponse> getCurrentWekPlan(int user_id);
  Future<CurrentWeekPlanResponse> getPreviousWekPlan(int user_id);
  Future<CurrentWeekPlanResponse> getCurrentWekPlanLocationwise(int user_id,int proj_loc_id);

}

class RealCurrentWeekPlanRepo implements  CurrentWeekPlanRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CurrentWeekPlanResponse> getCurrentWekPlan(int user_id) {
    return _apiProvider.getCurrentWeekPlan(user_id);
  }

  Future<CurrentWeekPlanResponse> getCurrentWekPlanLocationwise(int user_id,int proj_loc_id){
    return _apiProvider.getCurrentWeekPlanLocationwise(user_id, proj_loc_id);
  }

  Future<CurrentWeekPlanResponse> getPreviousWekPlan(int user_id){
    return _apiProvider.getPriviousWeekPlan(user_id);
  }

}