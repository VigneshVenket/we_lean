
import 'dart:io';

abstract class PostEvent {
  const PostEvent();
}

class SavePost extends PostEvent {
  final int userId;
  final String description;
  final File postImgUrl;

  const SavePost(this.userId,this.description,this.postImgUrl);

}