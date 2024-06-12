
import 'package:we_lean/api/responses/week_plan_response.dart';
import 'package:we_lean/models/week_activity.dart';
import '../api/apiData/api_provider.dart';

abstract class WeekPlanCreationRepo {

  Future<WeekPlanResponse> weekPlanCreation(WeekPlan weekPlanCreateData);
}

class RealWeekPlanCreationRepo implements WeekPlanCreationRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WeekPlanResponse> weekPlanCreation(WeekPlan weekPlanCreateData) {
    return _apiProvider.weekPlanCreation(weekPlanCreateData);
  }
}