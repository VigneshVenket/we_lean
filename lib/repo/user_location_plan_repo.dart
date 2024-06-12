

import 'package:we_lean/api/responses/user_location_plan_response.dart';

import '../api/apiData/api_provider.dart';

abstract class UserLocationPlanRepo {
  Future<UserLocationPlanResponse> getUserLocationPlan(int userId);
  Future<UserLocationPlanResponse> getUserLocationPlanLocationwise(int userId,int proj_loc_id);

}

class RealUserLocationPlanRepo implements  UserLocationPlanRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<UserLocationPlanResponse> getUserLocationPlan(int userId) {
    return _apiProvider.getUserLocationPlan(userId);
  }

  Future<UserLocationPlanResponse> getUserLocationPlanLocationwise(int userId,int proj_loc_id){
    return _apiProvider.getUserLocationPlanLocationwise(userId, proj_loc_id);
  }
}