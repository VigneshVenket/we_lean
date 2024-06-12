

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_event.dart';
import 'package:we_lean/repo/overall_ppc_data_repo.dart';

import 'overall_ppc_data_state.dart';


class OverallPPCBloc extends Bloc<OverallPPCEvent, OverallPPCState> {
  final OverallPpcDataRepo overallPpcDataRepo;

  OverallPPCBloc({required this.overallPpcDataRepo}) : super(OverallPPCInitialState());

  @override
  Stream<OverallPPCState> mapEventToState(OverallPPCEvent event,) async* {
    if (event is FetchOverallPPCDataEvent) {
      yield OverallPPCLoadingState();
      try {
        final overallPpcDataResponse = await overallPpcDataRepo.getOverallPpcData(event.userId);
        yield OverallPPCLoadedState(overallPPCResponse: overallPpcDataResponse);
      } catch (e) {
        yield OverallPPCErrorState(error: e.toString());
      }
    }
    else if (event is FetchOverallPPCDataLocationwiseEvent) {
      yield OverallPPCLoadingState();
      try {
        final overallPpcDataResponse = await overallPpcDataRepo.getOverallPpcDataLocationwise(event.userId,event.projLocId);
        yield OverallPPCLoadedState(overallPPCResponse: overallPpcDataResponse);
      } catch (e) {
        yield OverallPPCErrorState(error: e.toString());
      }
    }
  }
}
