
import 'package:we_lean/utils/app_constants.dart';

import '../../models/update_plan_screen_data.dart';

class UpdatePlanScreenResponse {
   String ?status;
   UpdatePlanScreenData? data;
   int ?code;

  UpdatePlanScreenResponse({required this.status, required this.data, required this.code});

  factory UpdatePlanScreenResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePlanScreenResponse(
      status: json['status'] ?? "",
      data: UpdatePlanScreenData.fromJson(json['data'] ?? {}),
      code: json['code'] ?? 0,
    );
  }

  UpdatePlanScreenResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;
  }
}

// Model class for the data within the response displayed in the update plan screen
class UpdatePlanScreenData {
  final List<UpdatePlanScreenActivity> updatedActivities;
  final Map<String, String> variances;

  UpdatePlanScreenData({required this.updatedActivities, required this.variances});

  factory UpdatePlanScreenData.fromJson(Map<String, dynamic> json) {
    List<UpdatePlanScreenActivity> activitiesList = [];
    if (json['WeekActivities'] != null) {
      activitiesList = List<UpdatePlanScreenActivity>.from(json['WeekActivities'].map((x) => UpdatePlanScreenActivity.fromJson(x)));
    }
    return UpdatePlanScreenData(
      updatedActivities: activitiesList,
      variances: Map<String, String>.from(json['groups'] ?? {}),
    );
  }
}