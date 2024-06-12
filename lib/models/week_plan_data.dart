
// class WeekPlanData {
//   final Map<String, String> activities;
//   final Map<String, String> categories;
//   final Map<String, String> uoms;
//   final Map<String, String> constraints;
//
//   WeekPlanData({
//     required this.activities,
//     required this.categories,
//     required this.uoms,
//     required this.constraints,
//   });
//
//   factory WeekPlanData.fromJson(Map<String, dynamic> json) {
//     return WeekPlanData(
//       activities: (json['activities'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
//       categories: (json['categories'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
//       uoms: (json['uoms'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
//       constraints: (json['constraints'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
//     );
//   }
// }



class WeekPlanData {
  final List<Activity> activities;
  final Map<String, String> categories;
  final Map<String, String> uoms;
  final Map<String, String> constraints;

  WeekPlanData({
    required this.activities,
    required this.categories,
    required this.uoms,
    required this.constraints,
  });

  factory WeekPlanData.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonActivities = json['activities'];
    List<Activity> activities = jsonActivities.map((activity) => Activity.fromJson(activity)).toList();

    return WeekPlanData(
      activities: activities,
      categories: (json['workareas'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
      uoms: (json['uoms'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
      constraints: (json['constraints'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
    );
  }
}

class Activity {
  final int id;
  final String name;
  final int uomId;
  final String uomName;

  Activity({
    required this.id,
    required this.name,
    required this.uomId,
    required this.uomName,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      uomId: json['uom_id'],
      uomName: json['uom_name'],
    );
  }
}
