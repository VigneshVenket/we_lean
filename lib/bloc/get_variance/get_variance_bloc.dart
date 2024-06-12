


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/get_variance_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'get_variance_event.dart';
import 'get_variance_state.dart';

// BLoC Class
class VariancesBloc extends Bloc<VariancesEvent, VariancesState> {
  final GetVarianceRepo getVarianceRepo;

  VariancesBloc(this.getVarianceRepo) : super(VariancesInitial());

  @override
  Stream<VariancesState> mapEventToState(VariancesEvent event) async* {
    if (event is FetchVariances) {
      yield VariancesLoading();
      try {
        final response = await  getVarianceRepo.getVariance(event.groupId);
        if (response.status == "Variances get successfully") {
          yield VariancesLoaded(response);
        } else {
          yield VariancesError(response.status!);
        }
      } catch (e) {
        yield VariancesError('Failed to load variances: $e');
      }
    }
  }
}
