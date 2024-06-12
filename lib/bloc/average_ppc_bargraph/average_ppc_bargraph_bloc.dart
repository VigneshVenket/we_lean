import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/average_ppc_bargraph_repo.dart';

import 'average_ppc_bargraph_event.dart';
import 'average_ppc_bargraph_state.dart';


class AveragePPCBargraphBloc extends Bloc<AveragePPCBargraphEvent, AveragePPCBargraphState> {

  AveragePPCBargraphRepo _averagePPCBargraphRepo;

  AveragePPCBargraphBloc(this._averagePPCBargraphRepo) : super(AveragePPCBargraphInitial());

  @override
  Stream<AveragePPCBargraphState> mapEventToState(AveragePPCBargraphEvent event) async* {
    if (event is FetchAveragePPCBargraphEvent) {
      yield AveragePPCBargraphInitial();
      try {
        // Replace this with your actual API call to fetch data
        final _response = await _averagePPCBargraphRepo.getAveragePPCBargraph();
        yield AveragePPCBargraphLoaded(_response.data!);
      } catch (e) {
        yield AveragePPCBargraphError(e.toString());
      }
    }
  }
}