


import 'package:we_lean/api/responses/plan_update_response.dart';
import 'package:we_lean/api/responses/week_plan_response.dart';
import 'package:we_lean/models/plan_upadate.dart';
import 'package:we_lean/models/update_plan_data.dart';
import 'package:we_lean/models/week_activity.dart';
import '../api/apiData/api_provider.dart';

abstract class PlanUpdateRepo {

  Future<PlanUpdateResponse> planUpdate(int week_activity_id,UpdatePlanData upadtePlanData);
}

class RealPlanUpdateRepo implements PlanUpdateRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<PlanUpdateResponse> planUpdate(int week_activity_id,UpdatePlanData updatePlanData){
    return _apiProvider.planUpdate(week_activity_id, updatePlanData);
  }
}