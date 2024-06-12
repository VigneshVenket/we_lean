


import 'package:we_lean/api/responses/root_cause_update_data_response.dart';

abstract class RootCauseUpdateState {}

class RootCauseUpdateInitial extends RootCauseUpdateState {}

class RootCauseUpdateSuccess extends RootCauseUpdateState {
  final RootCauseUpdateResponse rootCauseUpdateResponse;

  RootCauseUpdateSuccess({required this.rootCauseUpdateResponse});

}

class RootCauseUpdateFailure extends RootCauseUpdateState {
  final String error;

  RootCauseUpdateFailure({required this.error});
}