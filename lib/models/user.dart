

class User {
  int? id;
  String? name;
  String? emp_id;
  String? email;
  int? role_id;
  int? location_id;
  int? status;
  int? is_approved;
  String? email_verified_at;
  String? createdAt;
  String? updatedAt;
  String? role_name;
  String? token;
  ProjectLocation? projectLocation;
  String ?startweek;

  User(
      {this.id,
        this.name,
        this.emp_id,
        this.email,
        this.role_id,
        this.location_id,
        this.status,
        this.is_approved,
        this.email_verified_at,
        this.createdAt,
        this.updatedAt,
        this.role_name,
        this.token,
        this.projectLocation,
        this.startweek
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emp_id = json['emp_id'];
    email = json['email'];
    role_id = json['role_id'];
    location_id = json['location_id'];
    status = json['status'];
    is_approved = json['is_approved'];
    email_verified_at = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role_name = json['role_name'];
    token = json['token'];
    if (json['project_location'] != null) {
      projectLocation = ProjectLocation.fromJson(json['project_location']);
    }
   startweek=json['startWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emp_id'] = emp_id;
    data['email'] = email;
    data['role_id'] = role_id;
    data['location_id'] = location_id;
    data['status'] = status;
    data['is_approved'] =is_approved;
    data[' email_verified_at'] =  email_verified_at;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['role_name'] =role_name;
    data['token'] = token;
    return data;
  }


}


class ProjectLocation {
  final int id;
  final String description;

  ProjectLocation({
    required this.id,
    required this.description,
  });

  factory ProjectLocation.fromJson(Map<String, dynamic> json) {
    return ProjectLocation(
      id: json['id'],
      description: json['description'],
    );
  }
}