

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:we_lean/repo/bar_chart_ppc_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'bar_chart_ppc_event.dart';
import 'bar_chart_ppc_state.dart';


class BarChartBloc extends Bloc<BarChartEvent, BarChartState> {
final BarChartPpcRepo barChartPpcRepo;

  BarChartBloc({required this.barChartPpcRepo}) : super(BarChartInitialState());

  @override
  Stream<BarChartState> mapEventToState(BarChartEvent event) async* {
    if (event is FetchBarChartDataEvent) {
      yield BarChartLoadingState();
      try {
        final barChartPpcresponse = await barChartPpcRepo.getBarchartPpc(event.userId);
        if(barChartPpcresponse.status==AppConstants.status_success){
          yield BarChartLoadedState(barChartResponse: barChartPpcresponse);
        }else{
          yield BarChartErrorState(error: barChartPpcresponse.status!);
        }

      } catch (e) {
        yield BarChartErrorState(error: e.toString());
        print(e.toString());
      }
    }
    else if (event is FetchBarChartDataLocationwiseEvent) {
      yield BarChartLoadingState();
      try {
        final barChartPpcresponse = await barChartPpcRepo.getBarchartPpcLocationwise(event.userId,event.proj_loc_id);
        if(barChartPpcresponse.status==AppConstants.status_success){
          yield BarChartLoadedState(barChartResponse: barChartPpcresponse);
        }else{
          yield BarChartErrorState(error: barChartPpcresponse.status!);
        }

      } catch (e) {
        yield BarChartErrorState(error: e.toString());
        print(e.toString());
      }
    }
  }
}
