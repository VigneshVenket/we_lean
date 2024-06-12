



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/daywise_ppc_list_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'daywise_ppc_list_event.dart';
import 'daywise_ppc_list_state.dart';

class DayWisePPCBloc extends Bloc<DayWisePPCEvent, DayWisePPCState> {
  final DaywisePpcListRepo daywisePpcListRepo;


  DayWisePPCBloc({required this.daywisePpcListRepo}) : super(DayWisePPCInitial());

  @override
  Stream<DayWisePPCState> mapEventToState(DayWisePPCEvent event) async* {
    if (event is FetchDayWisePPC) {
      yield DayWisePPCLoading();
      try {
        final dayWisePPCListResponse = await daywisePpcListRepo.getDaywisePpcList(event.weekPlanId);
        if(dayWisePPCListResponse.status==AppConstants.status_success){
          yield DayWisePPCLoaded(dayWisePPCList: dayWisePPCListResponse.data!);
        }
        // yield DayWisePPCError(message: dayWisePPCListResponse.status!);
      } catch (e) {
        yield DayWisePPCError(message: e.toString());
      }
    }
    else if (event is FetchDayWisePPCListManagement) {
      yield DayWisePPCLoading();
      try {
        final _response = await daywisePpcListRepo.getDaywisePpcListMangement(event.weekPlanIds);
        if(_response.status==AppConstants.status_success){
          yield DayWisePPCLoaded(dayWisePPCList: _response.data!);
        }
        // yield DayWisePPCError(message: dayWisePPCListResponse.status!);
      } catch (e) {
        yield DayWisePPCError(message: e.toString());
      }
    }
  }
}