



abstract class VariancesEvent  {
  const VariancesEvent();

}

class FetchVariances extends VariancesEvent {
  final int groupId;

  FetchVariances({required this.groupId});

}