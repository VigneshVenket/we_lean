


import 'package:we_lean/utils/app_constants.dart';

class VariancesResponse {
  String ?status;
  Map<String, String> ?data;
  int? code;

  VariancesResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory VariancesResponse.fromJson(Map<String, dynamic> json) {
    return VariancesResponse(
      status: json['status'] ?? '',
      data: (json['data'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String)),
      code: json['code'] ?? 0,
    );
  }

  VariancesResponse.withError(String error){
    status=AppConstants.status_success;
    data={};
    code=0;
  }
}
