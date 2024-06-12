

class BarChartDataModel {
  final Map<String, String> data;

  BarChartDataModel({required this.data});

  factory BarChartDataModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> jsonData = json;
    print(json);
    final Map<String, String> data = jsonData.map((key, value) => MapEntry(key, value.toString())) ;
    print("Hello  -- $data");
    return BarChartDataModel(data: data);
  }

}
