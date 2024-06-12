
import 'package:we_lean/api/responses/update_plan_screen_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class UpdatePlanScreenRepo {
  Future<UpdatePlanScreenResponse> getCurrentWeekDayPlan(int week_activity_id);

}

class RealUpdatePlanScreenRepo implements  UpdatePlanScreenRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<UpdatePlanScreenResponse> getCurrentWeekDayPlan(int week_activity_id) {
    return _apiProvider.getCurrentWeekDayPlan(week_activity_id);
  }

}