

import 'package:we_lean/api/responses/day_ppc_week_activity_response.dart';

import '../api/apiData/api_provider.dart';
import '../api/responses/daywise_ppc_list_management_response.dart';

abstract class DayPpcWeekActivityRepo {
  Future<DayPpcWeekActivityResponse> getDayPpc(int week_activity_id);

}

class RealDayPpcWeekActivityRepo implements  DayPpcWeekActivityRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DayPpcWeekActivityResponse> getDayPpc(int week_activity_id) {
    return _apiProvider.getDayPpc(week_activity_id);
  }

}