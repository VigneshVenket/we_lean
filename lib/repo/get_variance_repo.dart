



import 'package:we_lean/api/responses/get_variances_response.dart';

import '../api/apiData/api_provider.dart';

abstract class GetVarianceRepo {
  Future<VariancesResponse> getVariance(int groupId);

}

class RealGetVarianceRepo implements  GetVarianceRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<VariancesResponse> getVariance(int groupId){
    return _apiProvider.getVariances(groupId);
  }

}