


import 'package:we_lean/api/responses/daily_variance_response.dart';

import '../api/apiData/api_provider.dart';

abstract class DailyVarianceDataRepo {
  Future<VarianceApiResponse> getDailyVarianceData(int week_activity_id);

}

class RealDailyVarianceDataRepo implements  DailyVarianceDataRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<VarianceApiResponse> getDailyVarianceData(int week_activity_id) {
    return _apiProvider.getDailyVarianceData(week_activity_id);
  }

}