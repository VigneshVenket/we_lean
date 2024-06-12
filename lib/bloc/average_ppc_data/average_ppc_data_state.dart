

import '../../models/average_ppc_data.dart';

abstract class AveragePPCDataState {}

class AveragePPCDataInitial extends AveragePPCDataState {}

class AveragePPCDataLoaded extends AveragePPCDataState {
  final AveragePPCDataDetail data;

  AveragePPCDataLoaded(this.data);
}

class AveragePPCDataError extends AveragePPCDataState {
  final String errorMessage;

  AveragePPCDataError(this.errorMessage);
}