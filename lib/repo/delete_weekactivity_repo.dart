



import 'package:we_lean/api/responses/delete_weekactivity_response.dart';

import '../api/apiData/api_provider.dart';

abstract class DeleteWeekActivityRepo {
  Future<DeleteWeekActivityResponse> deleteWeekActivity(int weekActivityId);

}

class RealDeleteWeekActivityRepo  implements  DeleteWeekActivityRepo  {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DeleteWeekActivityResponse> deleteWeekActivity(int weekActivityId){
    return _apiProvider.deleteWeekActivity(weekActivityId);
  }


}