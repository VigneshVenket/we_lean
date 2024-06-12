


import 'package:we_lean/api/responses/add_variancelog_action_response.dart';

import '../api/apiData/api_provider.dart';

abstract class AddVarianceLogActionRepo {
  Future<AddVarianceLogActionResponse> addActions(int variance_log_id,String actiondata);

}

class RealAddVarianceLogActionRepo implements  AddVarianceLogActionRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<AddVarianceLogActionResponse> addActions(int variance_log_id,String actiondata){
    return _apiProvider.addActions(variance_log_id, actiondata);
  }

}