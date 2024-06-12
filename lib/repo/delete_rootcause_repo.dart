



import '../api/apiData/api_provider.dart';
import '../api/responses/delete_rootcause_response.dart';

abstract class DeleteRootCauseRepo {
  Future<RootCauseDeleteResponse> deleteRootcause(int constraintLogId,String why);

}

class RealDeleteRootCauseRepo  implements  DeleteRootCauseRepo  {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<RootCauseDeleteResponse> deleteRootcause(int constraintLogId,String why){
    return _apiProvider.deleteRootCause(constraintLogId, why);
  }


}