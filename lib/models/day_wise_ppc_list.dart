

class DayWisePPCList {
  final Map<String, DayActivity> weekActivitiesPPC;
  final TotalPPC totalPPC;

  DayWisePPCList({required this.weekActivitiesPPC, required this.totalPPC});

  factory DayWisePPCList.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> weekActivitiesJson = json['weekActivitiesPPC'];
    Map<String, DayActivity> weekActivitiesPPC = {};
    weekActivitiesJson.forEach((key, value) {
      weekActivitiesPPC[key] = DayActivity.fromJson(value);
    });

    return DayWisePPCList(
      weekActivitiesPPC: weekActivitiesPPC,
      totalPPC: TotalPPC.fromJson(json['totalPPC']),
    );
  }
}

class DayActivity {
  final int planned;
  final int actual;
  final int ppc;

  DayActivity({required this.planned, required this.actual, required this.ppc});

  factory DayActivity.fromJson(Map<String, dynamic> json) {
    return DayActivity(
      planned: json['planned'],
      actual: json['actual'],
      ppc: json['ppc'],
    );
  }
}

class TotalPPC {
  final int totalPlanned;
  final int totalActual;
  final int totalPPC;

  TotalPPC({required this.totalPlanned, required this.totalActual, required this.totalPPC});

  factory TotalPPC.fromJson(Map<String, dynamic> json) {
    return TotalPPC(
      totalPlanned: json['total_planned'],
      totalActual: json['total_actual'],
      totalPPC: json['total_ppc'],
    );
  }
}