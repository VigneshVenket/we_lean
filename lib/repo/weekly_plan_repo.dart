
import '../api/apiData/api_provider.dart';
import '../api/responses/weekly_plan_response.dart';

abstract class WeeklyPlanRepo {
  Future<WeeklyPlanResponse> getWeeklyPlan(int week_activity_id);

}

class RealWeeklyPlanRepo implements  WeeklyPlanRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WeeklyPlanResponse> getWeeklyPlan(int week_activity_id) {
    return _apiProvider.getWeeklyPlan(week_activity_id);
  }

}