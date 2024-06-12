import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_lean/bloc/posts/post_bloc.dart';
import 'package:we_lean/bloc/posts/post_event.dart';
import 'package:we_lean/bloc/posts/post_state.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/screens/posts_screen.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:image_cropper/image_cropper.dart';

import '../bloc/feed_post/feed_post_bloc.dart';
import '../bloc/is_like_post/is_like_post_bloc.dart';
import '../bloc/save_comment/save_comment_bloc.dart';
import '../repo/feed_post_repo.dart';
import '../repo/is_like_post_repo.dart';
import '../repo/save_comment_repo.dart';


class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

// class _AddPostScreenState extends State<AddPostScreen> {
//   File? _image;
//
//   final picker = ImagePicker();
//
//   Future getImage(ImageSource source) async {
//    try{
//      final pickedFile = await picker.pickImage(source: source);
//      setState(() {
//        if (pickedFile != null) {
//          _image = File(pickedFile.path);
//          print(_image);
//        } else {
//          print('No image selected.');
//        }
//      });
//    } on PlatformException catch(e){
//      print(e.toString());
//    }
//   }
//
//   TextEditingController _captionController=TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:CustomAppbar(
//         title: "New Posts",
//       ),
//       body:BlocListener<PostBloc,PostState>(
//         listener:(context,state){
//           if(state is PostSuccess){
//             // CustomNavigation.push(context,
//             //     MultiBlocProvider(
//             //         providers: [
//             //           BlocProvider(
//             //             create:(BuildContext context) {
//             //               return FeedPostsBloc(RealFeedPostsRepo());
//             //             } ,
//             //           ),
//             //           BlocProvider(
//             //             create:(BuildContext context) {
//             //               return SaveCommentBloc(RealSaveCommentRepo());
//             //             } ,
//             //           ),
//             //           BlocProvider(
//             //             create:(BuildContext context) {
//             //               return LikePostBloc(likePostRepo: RealLikePostRepo());
//             //             } ,
//             //           ),
//             //         ],
//             //         child:PostsScreen()
//             //     )
//             //
//             // );
//             Navigator.of(context).pop();
//             CustomNavigation.pushAndRemoveUntill(context, MainScreen());
//             CustomMessenger.showMessage(context, state.response.message!, Colors.green);
//           }else if(state is PostFailure){
//             CustomMessenger.showMessage(context,state.error, Colors.red);
//           }
//         } ,
//         child:Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//
//                 children: [
//                   _image != null
//                       ? Container(
//                     width: MediaQuery.of(context).size.width*0.90,
//                     height: MediaQuery.of(context).size.height*0.4,
//                     child: Image.file(
//                       _image!,fit: BoxFit.fill,
//                     ),
//                   )
//                       : GestureDetector(
//                     onTap: (){
//                       showModalBottomSheet(
//                         backgroundColor:Color.fromRGBO(240, 240, 240, 1),
//                         context: context,
//                         builder: (context) {
//                           return Container(
//                             child: Wrap(
//                               children: [
//                                 ListTile(
//                                     leading:Icon(Icons.photo_library,color: CustomColors.themeColor,),
//                                     title: Text('Photo Library',style: titilliumRegular,),
//                                     onTap: () {
//                                       getImage(ImageSource.gallery);
//                                       Navigator.of(context).pop();
//                                     }),
//                                 ListTile(
//                                   leading: Icon(Icons.photo_camera,color: CustomColors.themeColor,),
//                                   title: Text('Camera',style: titilliumRegular,),
//                                   onTap: () {
//                                     getImage(ImageSource.camera);
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                         width: MediaQuery.of(context).size.width*0.90,
//                         height: MediaQuery.of(context).size.height*0.4,
//                         color: Color.fromRGBO(240, 240, 240, 1),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.image,size: 60,color: Colors.black38),
//                             Text("Select Image",style: titilliumRegular,)
//                           ],
//                         )
//
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     width: MediaQuery.of(context).size.width*0.9,
//                     height: MediaQuery.of(context).size.width*0.3,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Color.fromRGBO(240, 240, 240, 1)
//                     ),
//                     child: TextField(
//                       controller: _captionController,
//                       cursorColor:  CustomColors.themeColor,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                             width: 0,
//                             style: BorderStyle.none,
//                           ),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 0, horizontal: 10),
//                         // fillColor:Color.fromRGBO(240, 240, 240, 1),
//                         // filled: true,
//                         hintText:"Write Caption",
//                         hintStyle: titilliumBoldRegular,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   CustomButtonSubmit(title:"Share",
//                       onPressed: (){
//                         if (_image != null) {
//                              BlocProvider.of<PostBloc>(context).add(SavePost(AppData.user!.id!, _captionController.text, _image!));
//                         } else {
//                           // Show error message if no image selected
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 backgroundColor: Color.fromRGBO(240, 240, 240, 1),
//                                 title: Text("Error",style: titilliumBoldRegular,),
//                                 content: Text("Please select image first.",style: titilliumRegular,),
//                                 actions:[
//                                   TextButton(
//                                     child: Text("Ok",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )
//
//     );
//   }
// }


class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        File? croppedFile = await cropImage(pickedFile.path);
        setState(() {
          if (croppedFile != null) {
            _image = croppedFile;
            print(_image);
          } else {
            print('No image selected.');
          }
        });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<File?> cropImage(String filePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: CustomColors.themeColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          activeControlsWidgetColor: CustomColors.themeColor
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }


  TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "New Posts",
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostSuccess) {
            Navigator.of(context).pop();
            CustomNavigation.pushAndRemoveUntill(context, MainScreen());
            CustomMessenger.showMessage(context, state.response.message!, Colors.green);
          } else if (state is PostFailure) {
            CustomMessenger.showMessage(context, state.error, Colors.red);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _image != null
                      ? Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.fill,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Wrap(
                              children: [
                                ListTile(
                                    leading: Icon(Icons.photo_library, color: CustomColors.themeColor,),
                                    title: Text('Photo Library', style: titilliumRegular,),
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    }),
                                ListTile(
                                  leading: Icon(Icons.photo_camera, color: CustomColors.themeColor,),
                                  title: Text('Camera', style: titilliumRegular,),
                                  onTap: () {
                                    getImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.4,
                        color: Color.fromRGBO(240, 240, 240, 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 60, color: Colors.black38),
                            Text("Select Image", style: titilliumRegular,)
                          ],
                        )),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(240, 240, 240, 1)),
                    child: TextField(
                      controller: _captionController,
                      cursorColor: CustomColors.themeColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        hintText: "Write Caption",
                        hintStyle: titilliumBoldRegular,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButtonSubmit(
                      title: "Share",
                      onPressed: () {
                        if (_image != null) {
                          BlocProvider.of<PostBloc>(context).add(SavePost(AppData.user!.id!, _captionController.text, _image!));
                        } else {
                          // Show error message if no image selected
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                                title: Text("Error", style: titilliumBoldRegular,),
                                content: Text("Please select image first.", style: titilliumRegular,),
                                actions: [
                                  TextButton(
                                    child: Text("Ok", style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


