

import 'package:we_lean/bloc/week_plan/week_plan_event.dart';
import 'package:we_lean/bloc/week_plan/week_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/utils/app_constants.dart';

import '../../repo/week_plan_repo.dart';

class WeekPlanCreateBloc extends Bloc<WeekPlanCreateEvent, WeekPlanCreateState> {
  final WeekPlanCreationRepo weekPlanCreationRepo;

  WeekPlanCreateBloc(this.weekPlanCreationRepo) : super(WeekPlanCreateInitialState());


  @override
  Stream<WeekPlanCreateState> mapEventToState(WeekPlanCreateEvent event) async* {
    if (event is PostWeekPlanCreateEvent) {
      yield WeekPlanCreateLoadingState();
      try {
        final weekPlanCreateResponse = await weekPlanCreationRepo.weekPlanCreation(event.weekPlan);
        if(weekPlanCreateResponse.status==AppConstants.status_success){
          yield WeekPlanCreateSuccessState(weekPlanResponse:weekPlanCreateResponse);
        }else{
          yield WeekPlanCreateErrorState(error: weekPlanCreateResponse.message!);
        }

      } catch (error) {
        yield WeekPlanCreateErrorState(error: error.toString());
      }
    }
  }

}