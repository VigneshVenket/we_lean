



import 'package:we_lean/api/responses/average_ppc_bargraph_response.dart';

import '../api/apiData/api_provider.dart';

abstract class AveragePPCBargraphRepo {
  Future<AveragePPCBargraphResponse> getAveragePPCBargraph();

}

class RealAveragePPCBargraphRepo implements  AveragePPCBargraphRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<AveragePPCBargraphResponse> getAveragePPCBargraph(){
    return _apiProvider.getAveragePPCBargraph();
  }


}