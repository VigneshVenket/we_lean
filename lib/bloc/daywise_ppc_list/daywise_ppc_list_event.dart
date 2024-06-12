


abstract class DayWisePPCEvent {}

class FetchDayWisePPC extends DayWisePPCEvent {
  final int weekPlanId;

  FetchDayWisePPC({required this.weekPlanId});
}


class FetchDayWisePPCListManagement extends DayWisePPCEvent {
  final String weekPlanIds;

  FetchDayWisePPCListManagement({required this.weekPlanIds});
}