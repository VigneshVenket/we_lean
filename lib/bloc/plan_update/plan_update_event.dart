
import 'package:we_lean/models/update_plan_data.dart';

abstract class PlanUpdateEvent {}

class UpdatePlanEvent extends PlanUpdateEvent {
  final int weekActivityId;
  final UpdatePlanData updatePlanData;


  UpdatePlanEvent({
    required this.weekActivityId,
    required this.updatePlanData,
  });
}