



import 'package:we_lean/api/responses/daywise_ppc_list_management_response.dart';

import '../api/apiData/api_provider.dart';

abstract class DaywisePpcListManagementRepo {
  Future<DayWisePPCManagementResponse> getDaywisePpcList(String weekPlanIds);

}

class RealDaywisePpcListManagementRepo implements DaywisePpcListManagementRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DayWisePPCManagementResponse> getDaywisePpcList(String weekPlanIds){
    return _apiProvider.getDaywisePPCMangementData(weekPlanIds);
  }

}