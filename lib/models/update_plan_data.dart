

import 'package:we_lean/models/update_plan_data.dart';

class UpdatePlanData{

  String ?actualQty;
  String ?status;
  int ?varianceId;
  String description=" ";

  UpdatePlanData({
   this.actualQty,
   this.status,
   this.varianceId
  });

  Map<String, dynamic> toJson() {
    return {
      'actual_qty': actualQty,
      'status': status,
      'variance_id': varianceId,
      'description': description,
    };
  }

}
