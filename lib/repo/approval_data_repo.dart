

import '../api/apiData/api_provider.dart';
import '../api/responses/approval_response.dart';

abstract class ApprovalDataRepo {

  Future<ApprovalResponse> changeApprovalStatus(int week_plan_id,int user_id,String status );
}

class RealApprovalDataRepo implements  ApprovalDataRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ApprovalResponse> changeApprovalStatus(int week_plan_id,int user_id,String status ) {
    return _apiProvider.changeApprovalStatus(week_plan_id, user_id, status);
  }
}