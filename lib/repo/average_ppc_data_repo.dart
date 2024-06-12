




import 'package:we_lean/api/responses/average_ppc_data_response.dart';

import '../api/apiData/api_provider.dart';

abstract class AveragePPCDataRepo {
  Future<AveragePPCDataResponse> getAveragePPCData();

}

class RealAveragePPCDataRepo implements  AveragePPCDataRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<AveragePPCDataResponse> getAveragePPCData(){
    return _apiProvider.getAveragePPCData();
  }


}