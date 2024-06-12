

import 'package:we_lean/api/responses/day_wise_ppc_list_response.dart';

import '../api/apiData/api_provider.dart';
import '../api/responses/daywise_ppc_list_management_response.dart';

abstract class DaywisePpcListRepo {
  Future<DayWisePPCResponse> getDaywisePpcList(int week_plan_id);
  Future<DayWisePPCManagementResponse> getDaywisePpcListMangement(String weekPlanIds);


}

class RealDaywisePpcListRepo implements DaywisePpcListRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DayWisePPCResponse> getDaywisePpcList(int week_plan_id){
    return _apiProvider.getDaywisePpcList(week_plan_id);
  }

  @override
  Future<DayWisePPCManagementResponse> getDaywisePpcListMangement(String weekPlanIds){
    return _apiProvider.getDaywisePPCMangementData(weekPlanIds);
  }

}