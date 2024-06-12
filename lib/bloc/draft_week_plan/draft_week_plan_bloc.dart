

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/draft_week_plan_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'draft_week_plan_event.dart';
import 'draft_week_plan_state.dart';


class DraftWeekPlanBloc extends Bloc<DraftWeekPlanEvent, DraftWeekPlanState> {
 final DraftWeekPlanRepo _draftWeekPlanRepo;

  DraftWeekPlanBloc(this._draftWeekPlanRepo) : super(DraftWeekPlanInitial());

  @override
  Stream<DraftWeekPlanState> mapEventToState(DraftWeekPlanEvent event) async* {
    if (event is FetchDraftWeekPlan) {
      yield DraftWeekPlanLoading();
      try {
        final draftWeekPlanresponse = await _draftWeekPlanRepo.getUserLocationPlanDrafts(event.userId, event.proj_loc_id);
        if (draftWeekPlanresponse.status == AppConstants.status_success) {
          yield DraftWeekPlanLoaded(draftWeekPlans: draftWeekPlanresponse.data!);
        } else {
          yield DraftWeekPlanError(message: "No plans found for this location");
        }
      } catch (e) {
        yield DraftWeekPlanError(message: 'An error occurred: $e');
      }
    }
  }
}
