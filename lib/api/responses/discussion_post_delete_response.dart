

class DiscussionPostDeleteResponse{
  String ?status;

  DiscussionPostDeleteResponse({this.status});

  factory DiscussionPostDeleteResponse.fromJson(Map<String,dynamic> json){
    return DiscussionPostDeleteResponse(
      status: json['status']
    );
  }

  DiscussionPostDeleteResponse.withError(String error){
    status=error;
  }
}