
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/average_ppc_data_repo.dart';

import 'average_ppc_data_event.dart';
import 'average_ppc_data_state.dart';

class AveragePPCDataBloc extends Bloc<AveragePPCDataEvent, AveragePPCDataState> {
  final AveragePPCDataRepo _averagePPCDataRepo;

  AveragePPCDataBloc(this._averagePPCDataRepo) : super(AveragePPCDataInitial());

  @override
  Stream<AveragePPCDataState> mapEventToState(AveragePPCDataEvent event) async* {
    if (event is FetchAveragePPCDataEvent) {
      yield AveragePPCDataInitial();
      try {
        final _response = await _averagePPCDataRepo.getAveragePPCData();
        yield AveragePPCDataLoaded(_response.data!);
      } catch (e) {
        yield AveragePPCDataError(e.toString());
      }
    }
  }
}