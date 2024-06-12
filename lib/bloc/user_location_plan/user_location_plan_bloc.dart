

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_event.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_state.dart';
import 'package:we_lean/repo/user_location_plan_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

class UserLocationPlanBloc extends Bloc<UserLocationPlanEvent, UserLocationPlanState> {
  final UserLocationPlanRepo userLocationPlanRepo;

  UserLocationPlanBloc(this.userLocationPlanRepo) : super(UserLocationPlanInitialState());

  @override
  Stream<UserLocationPlanState> mapEventToState(UserLocationPlanEvent event) async* {
    if (event is FetchUserLocationPlanEvent) {
      yield UserLocationPlanLoadingState();
      try {
        final userLocationPlansResponse = await userLocationPlanRepo.getUserLocationPlan(event.userId);
        if(userLocationPlansResponse.status==AppConstants.status_success){
          yield UserLocationPlanLoadedState(userLocationPlansResponse.data!);
        }else{
          yield UserLocationPlanErrorState(userLocationPlansResponse.status!);
        }
      } catch (e) {
        yield UserLocationPlanErrorState(e.toString());
      }
    }
    if (event is FetchUserLocationPlanLocationwiseEvent) {
      yield UserLocationPlanLoadingState();
      try {
        final userLocationPlansResponse = await userLocationPlanRepo.getUserLocationPlanLocationwise(event.userId,event.proj_loc_id);
        if(userLocationPlansResponse.status==AppConstants.status_success){
          yield UserLocationPlanLoadedState(userLocationPlansResponse.data!);
        }else{
          yield UserLocationPlanErrorState(userLocationPlansResponse.message!);
        }
      } catch (e) {
        yield UserLocationPlanErrorState(e.toString());
      }
    }
  }
}