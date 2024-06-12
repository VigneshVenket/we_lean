
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_event.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_state.dart';
import 'package:we_lean/repo/week_variance_graph_repo.dart';

class WeekVariancePPCBloc extends Bloc<WeekVariancePPCEvent, WeekVariancePPCState> {
  final WeekVariancePpcRepo weekVariancePpcRepo;

  WeekVariancePPCBloc(this.weekVariancePpcRepo) : super(WeekVariancePPCInitial());

  @override
  Stream<WeekVariancePPCState> mapEventToState(WeekVariancePPCEvent event) async* {
    if (event is FetchWeekVariancePPCData) {
      yield WeekVariancePPCLoading();
      try {
        final weekVaraianceResponse = await weekVariancePpcRepo.getWeekVariance(event.userId);
          yield WeekVariancePPCDataLoaded(weekVariancePPCResponse: weekVaraianceResponse);
      } catch (e) {
        yield WeekVariancePPCError(message: e.toString());
      }
    }
    else if (event is FetchWeekVariancePPCDataLocationwise ) {
      yield WeekVariancePPCLoading();
      try {
        final weekVaraianceResponse = await weekVariancePpcRepo.getWeekVarianceLocationwise(event.userId,event.proj_loc_id);
        yield WeekVariancePPCDataLoaded(weekVariancePPCResponse: weekVaraianceResponse);
      } catch (e) {
        yield WeekVariancePPCError(message: e.toString());
      }
    }
  }
}