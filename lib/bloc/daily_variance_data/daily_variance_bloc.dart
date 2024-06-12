



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/daily_variance_data/daily_variance_event.dart';
import 'package:we_lean/repo/daily_variance_data_repo.dart';
import 'package:we_lean/utils/app_constants.dart';
import 'daily_variance_state.dart';

class DailyVarianceBloc extends Bloc<DailyVarianceEvent, DailyVarianceState> {
  final DailyVarianceDataRepo dailyVarianceDataRepo;

  DailyVarianceBloc({required this.dailyVarianceDataRepo}) : super(DailyVarianceInitial());

  @override
  Stream<DailyVarianceState> mapEventToState(event) async* {
    if (event is FetchDailyVarianceData) {
      yield DailyVarianceLoading();
      try {
        final varianceDataResponse = await dailyVarianceDataRepo.getDailyVarianceData(event.week_plan_id);
        if(varianceDataResponse.status==AppConstants.status_success){
          yield DailyVarianceLoaded(varianceData: varianceDataResponse.data!);
        }else{
          yield DailyVarianceError(errorMessage: varianceDataResponse.status!);
        }

      } catch (e) {
        yield DailyVarianceError(errorMessage: e.toString());
      }
    }
  }
}
