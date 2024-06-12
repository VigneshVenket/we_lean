import '../../api/responses/overall_ppc_data_response.dart';

abstract class OverallPPCState {}

class OverallPPCInitialState extends OverallPPCState {}

class OverallPPCLoadingState extends OverallPPCState {}

class OverallPPCLoadedState extends OverallPPCState {
  final OverallPPCResponse overallPPCResponse;

  OverallPPCLoadedState({required this.overallPPCResponse});
}

class OverallPPCErrorState extends OverallPPCState {
  final String error;

  OverallPPCErrorState({required this.error});
}

