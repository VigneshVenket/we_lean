
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/line_chart_variance_data_repo.dart';
import 'package:we_lean/utils/app_constants.dart';
import 'line_chart_variance_data_event.dart';
import 'line_chart_variance_data_state.dart';

class LineChartVarianceBloc extends Bloc<LineChartVarianceEvent, LineChartVarianceState> {
  final LineChartVarianceDataRepo lineChartVarianceDataRepo;

  LineChartVarianceBloc(this.lineChartVarianceDataRepo) : super(LineChartVarianceInitialState());

  @override
  Stream<LineChartVarianceState> mapEventToState(LineChartVarianceEvent event) async* {
    if (event is FetchLineChartVarianceData) {
      yield LineChartVarianceLoadingState();
      try {
        final lineChartVarianceDataResponse = await lineChartVarianceDataRepo.getLineChartVarianceData(event.varianceId);

        if(lineChartVarianceDataResponse.status==AppConstants.status_success){
          yield LineChartVarianceLoadedState(lineChartVarianceDataResponse);
        }else{
          yield LineChartVarianceErrorState(lineChartVarianceDataResponse.status!);
        }

      } catch (e) {
        yield LineChartVarianceErrorState('Failed to fetch line chart variance data: $e');
      }
    }
  }
}