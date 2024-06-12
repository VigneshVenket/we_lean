

import '../../models/week_variance_graph.dart';

class WeekVariancePPCResponse {
   Map<String, WeekVariancePPCDay> ?data;

  WeekVariancePPCResponse({
    required this.data,
  });

  factory WeekVariancePPCResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataJson = json['data'];
    final Map<String, WeekVariancePPCDay> data = dataJson.map(
          (key, value) => MapEntry(
        key,
        WeekVariancePPCDay.fromJson(value),
      ),
    );

    return WeekVariancePPCResponse(
      data: data,
    );
  }

  WeekVariancePPCResponse.withError(String error){
    data=null;
  }

}