


import 'package:we_lean/api/responses/draft_week_plan_response.dart';

import '../api/apiData/api_provider.dart';

abstract class DraftWeekPlanRepo {
  Future<DraftWeekPlanResponse> getUserLocationPlanDrafts(int userId,int proj_loc_id);

}

class RealDraftWeekPlanRepo implements  DraftWeekPlanRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DraftWeekPlanResponse> getUserLocationPlanDrafts(int userId,int proj_loc_id){
    return _apiProvider.getUserLocationPlanDrafts(userId, proj_loc_id);
  }


}