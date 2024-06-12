

import 'package:we_lean/api/responses/overall_ppc_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class OverallPpcDataRepo {
  Future<OverallPPCResponse> getOverallPpcData(int user_id);
  Future<OverallPPCResponse> getOverallPpcDataLocationwise(int user_id,int proj_loc_id);

}

class RealOverallPpcDataRepo implements  OverallPpcDataRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OverallPPCResponse> getOverallPpcData(int user_id) {
    return _apiProvider.getOverallPpcData(user_id);
  }

  Future<OverallPPCResponse> getOverallPpcDataLocationwise(int user_id,int proj_loc_id){
    return _apiProvider.getOverallPpcDataLocationwise(user_id, proj_loc_id);
  }

}