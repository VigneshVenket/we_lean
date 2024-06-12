


import 'package:we_lean/api/responses/delete_constraint_response.dart';

import '../api/apiData/api_provider.dart';

abstract class DeleteConstraintRepo {
  Future<DeleteConstraintLogResponse> deleteConstraint(int constraintId);

}

class RealDeleteConstraintRepo  implements  DeleteConstraintRepo  {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DeleteConstraintLogResponse> deleteConstraint(int constraintId){
    return _apiProvider.deleteConstraint(constraintId);
  }


}