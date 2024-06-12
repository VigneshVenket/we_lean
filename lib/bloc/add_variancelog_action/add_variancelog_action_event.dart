


abstract class AddVarianceLogActionEvent {}

class PerformAddVarianceLogAction extends AddVarianceLogActionEvent {
  final int variancelogid;
  final String actiondata;

  PerformAddVarianceLogAction({required this.variancelogid,required this.actiondata});

}