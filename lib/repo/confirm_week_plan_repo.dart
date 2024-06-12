

import 'package:we_lean/api/responses/confirm_week_plan_response.dart';

import '../api/apiData/api_provider.dart';

abstract class ConfirmWeekPlanRepo {
  Future<ConfirmWeekPlanResponse> postConfirmWeekPlan(int weekId);

}

class RealConfirmWeekPlanRepo implements  ConfirmWeekPlanRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ConfirmWeekPlanResponse> postConfirmWeekPlan(int weekId){
    return _apiProvider.confirmWeekPlan(weekId);
  }


}