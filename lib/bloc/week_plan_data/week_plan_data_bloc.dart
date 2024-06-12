

import 'package:we_lean/bloc/week_plan_data/week_plan_data_event.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/week_plan_data_repo.dart';

import '../../models/week_plan_data.dart';

class WeekPlanDataBloc extends Bloc<WeekPlanDataEvent, WeekPlanDataState> {
 final WeekPlanDataRepo weekPlanDataRepo;

  WeekPlanDataBloc(this.weekPlanDataRepo) : super(WeekPlanDataInitial());

  @override
  Stream<WeekPlanDataState> mapEventToState(WeekPlanDataEvent event) async* {
    if (event is FetchWeekPlanData) {
      yield WeekPlanDataInitial(); // Optional: You can add loading state here if needed
      try {
        final weekPlanDataResponse = await weekPlanDataRepo.getWeekPlanData();
        yield WeekPlanDataLoaded(weekPlanDataResponse.data);
      } catch (e) {
        yield WeekPlanDataError('Failed to fetch week plan data: $e');
      }
    }
  }
}