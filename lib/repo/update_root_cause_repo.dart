

import 'package:we_lean/api/responses/root_cause_update_data_response.dart';
import 'package:we_lean/api/responses/update_plan_screen_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class UpdateRootCauseRepo {
  Future<RootCauseUpdateResponse> updateRootCause(int varianceId,String why1,String why2,String why3,String why4,String why5,
      String groupId1,String groupId2,String groupId3,String groupId4,String groupId5,
      );

}

class RealUpdateRootCauseRepo implements  UpdateRootCauseRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<RootCauseUpdateResponse> updateRootCause(int varianceId,String why1,String why2,String why3,String why4,String why5,
      String groupId1,String groupId2,String groupId3,String groupId4,String groupId5,
      ) {
    return _apiProvider.updateRootCause(varianceId, why1, why2, why3, why4, why5,groupId1,groupId2,groupId3,groupId4,groupId5);
  }

}