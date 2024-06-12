

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:we_lean/bloc/plan_update/plan_update_event.dart';
import 'package:we_lean/bloc/plan_update/plan_update_state.dart';
import 'package:we_lean/repo/plan_update_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

class PlanUpdateBloc extends Bloc<PlanUpdateEvent, PlanUpdateState> {
  final PlanUpdateRepo planUpdateRepo;

  PlanUpdateBloc(this.planUpdateRepo) : super(PlanUpdateInitial());

  @override
  Stream<PlanUpdateState> mapEventToState(PlanUpdateEvent event) async* {
    if (event is UpdatePlanEvent) {
      yield PlanUpdateLoading();

      try {
        final response = await planUpdateRepo.planUpdate(event.weekActivityId,event.updatePlanData);

        if (response.status == AppConstants.status_success) {
          yield PlanUpdateLoaded(planUpdate: response);
        } else {
          yield PlanUpdateError(errorMessage: response.status!);
        }
      } catch (e) {
        yield PlanUpdateError(errorMessage: e.toString());
      }
    }
  }
}
