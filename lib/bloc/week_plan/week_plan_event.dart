

import 'package:we_lean/models/week_activity.dart';

abstract class WeekPlanCreateEvent {}

class PostWeekPlanCreateEvent extends WeekPlanCreateEvent {

  final WeekPlan weekPlan;

  PostWeekPlanCreateEvent({required this.weekPlan});
}