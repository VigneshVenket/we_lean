


abstract class AveragePPCBargraphState {}

class AveragePPCBargraphInitial extends AveragePPCBargraphState {}

class AveragePPCBargraphLoaded extends AveragePPCBargraphState {
  final Map<String, int> data;

  AveragePPCBargraphLoaded(this.data);
}

class AveragePPCBargraphError extends AveragePPCBargraphState {
  final String errorMessage;

  AveragePPCBargraphError(this.errorMessage);
}