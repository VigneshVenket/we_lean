

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/day_ppc_weekk_activity_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'day_ppc_event.dart';
import 'day_ppc_state.dart';

class DayPpcBloc extends Bloc<DayPpcEvent, DayPpcState> {
  final DayPpcWeekActivityRepo  dayPpcWeekActivityRepo;

  DayPpcBloc({required this.dayPpcWeekActivityRepo}) : super(DayPpcInitial());

  @override
  Stream<DayPpcState> mapEventToState(DayPpcEvent event) async* {
    if (event is FetchDayPpcWeekActivities) {
      yield DayPpcLoading();

      try {
        final dayPpcResponse = await dayPpcWeekActivityRepo.getDayPpc(event.weekActivityId);
        if (dayPpcResponse.status == AppConstants.status_success) {
          yield DayPpcLoaded(weekActivities: dayPpcResponse.data!);
        } else {
          yield DayPpcError(errorMessage: dayPpcResponse.status!);
        }
      } catch (e) {
        yield DayPpcError(errorMessage: e.toString());
      }
    }
  }
}
