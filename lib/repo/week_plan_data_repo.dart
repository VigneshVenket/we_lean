

import 'package:we_lean/api/responses/week_plan_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class WeekPlanDataRepo {
  Future<WeekPlanDataResponse> getWeekPlanData();

}

class RealWeekPlanDataRepo implements  WeekPlanDataRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WeekPlanDataResponse> getWeekPlanData() {
    return _apiProvider.getWeekPlanData();
  }

}