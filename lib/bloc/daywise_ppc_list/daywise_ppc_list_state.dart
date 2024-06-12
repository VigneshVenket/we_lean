


import '../../models/day_wise_ppc_list.dart';

abstract class DayWisePPCState {}

class DayWisePPCInitial extends DayWisePPCState {}

class DayWisePPCLoading extends DayWisePPCState {}

class DayWisePPCError extends DayWisePPCState {
  final String message;

  DayWisePPCError({required this.message});
}

class DayWisePPCLoaded extends DayWisePPCState {
  final DayWisePPCList dayWisePPCList;

  DayWisePPCLoaded({required this.dayWisePPCList});
}