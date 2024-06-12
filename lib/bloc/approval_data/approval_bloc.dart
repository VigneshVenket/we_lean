
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/approval_data_repo.dart';
import 'package:we_lean/utils/app_constants.dart';
import 'approval_event.dart';
import 'approval_state.dart';


class ApprovalBloc extends Bloc<ApprovalEvent, ApprovalState> {
  final ApprovalDataRepo approvalDataRepo;

  ApprovalBloc(this.approvalDataRepo) : super(ApprovalInitial());

  @override
  Stream<ApprovalState> mapEventToState(ApprovalEvent event) async* {
    if (event is SubmitApprovalEvent) {
      try {
        final approvalResponse = await approvalDataRepo.changeApprovalStatus(event.weekPlanId, event.userId, event.status);
        if(approvalResponse.status==AppConstants.status_success){
          yield ApprovalLoaded(approvalResponse: approvalResponse.data!);
        }else{
          yield ApprovalError(errorMessage: approvalResponse.status!);
        }

      } catch (e) {
        yield ApprovalError(errorMessage: e.toString());
      }
    }
  }
}