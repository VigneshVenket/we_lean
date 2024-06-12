


import 'package:equatable/equatable.dart';
import '../../models/save_comment_data.dart';


abstract class SaveCommentState {
  const SaveCommentState();

}

class SaveCommentInitial extends SaveCommentState {}

class SaveCommentLoading extends SaveCommentState {}

class SaveCommentSuccess extends SaveCommentState {
  final Comment comment;

  SaveCommentSuccess({required this.comment});

}

class SaveCommentFailure extends SaveCommentState {
  final String error;

  SaveCommentFailure({required this.error});


}
