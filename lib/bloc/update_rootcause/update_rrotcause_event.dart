

abstract class RootCauseUpdateEvent {}

class RootCauseUpdated extends RootCauseUpdateEvent {
  final int varianceId;
  final String why1;
  final String why2;
  final String why3;
  final String why4;
  final String why5;
  final String groupId1;
  final String groupId2;
  final String groupId3;
  final String groupId4;
  final String groupId5;


  RootCauseUpdated({required this.varianceId,required this.why1,required this.why2,required this.why3,required this.why4,required this.why5,
    required this.groupId1,required this.groupId2,required this.groupId3,required this.groupId4,required this.groupId5
  });

}