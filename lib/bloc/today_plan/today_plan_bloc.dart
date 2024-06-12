


import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:we_lean/bloc/today_plan/toay_plan_event.dart';
import 'package:we_lean/bloc/today_plan/today_plan_state.dart';
import 'package:we_lean/repo/today_plan_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

class TodayPlanBloc extends Bloc<TodayPlanEvent, TodayPlanState> {
  final TodayPlanRepo todayPlanRepo;

  TodayPlanBloc({required this.todayPlanRepo}) : super(TodayPlanInitial());

  @override
  Stream<TodayPlanState> mapEventToState(TodayPlanEvent event,) async* {
    if (event is FetchTodayPlan) {
      yield TodayPlanLoading();
      try {
        final todayPlanResponse = await todayPlanRepo.getTodatPlan(event.userId);
        if(todayPlanResponse.status==AppConstants.status_success){
          yield TodayPlanLoaded(todayPlanResponse: todayPlanResponse);
        }
        else{
          yield TodayPlanError(error:todayPlanResponse.status!);
        }
        }
       catch (e) {
        yield TodayPlanError(error: e.toString());
      }
    }
    else if (event is FetchTodayPlanLocationwise) {
      yield TodayPlanLoading();
      try {
        final todayPlanResponse = await todayPlanRepo.getTodatPlanLocationwise(event.userId,event.proj_loc_id);
        if(todayPlanResponse.status==AppConstants.status_success){
          yield TodayPlanLoaded(todayPlanResponse: todayPlanResponse);
        }
        else{
          yield TodayPlanError(error:todayPlanResponse.status!);
        }
      }
      catch (e) {
        yield TodayPlanError(error: e.toString());
      }
    }
  }
}
