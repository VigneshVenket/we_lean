

import 'dart:convert';
import 'dart:io';

import 'package:we_lean/api/responses/add_variancelog_action_response.dart';
import 'package:we_lean/api/responses/approval_response.dart';
import 'package:we_lean/api/responses/average_ppc_bargraph_response.dart';
import 'package:we_lean/api/responses/average_ppc_data_response.dart';
import 'package:we_lean/api/responses/bar_chart_ppc_response.dart';
import 'package:we_lean/api/responses/confirm_week_plan_response.dart';
import 'package:we_lean/api/responses/current_week_plan_activity_response.dart';
import 'package:we_lean/api/responses/daily_variance_response.dart';
import 'package:we_lean/api/responses/day_ppc_week_activity_response.dart';
import 'package:we_lean/api/responses/day_wise_ppc_list_response.dart';
import 'package:we_lean/api/responses/delete_constraint_response.dart';
import 'package:we_lean/api/responses/discussion_post_delete_response.dart';
import 'package:we_lean/api/responses/draft_week_plan_response.dart';
import 'package:we_lean/api/responses/feed_posts_response.dart';
import 'package:we_lean/api/responses/get_variances_response.dart';
import 'package:we_lean/api/responses/is_like_post_response.dart';
import 'package:we_lean/api/responses/line_chart_variance_data_response.dart';
import 'package:we_lean/api/responses/location_data_response.dart';
import 'package:we_lean/api/responses/overall_ppc_data_response.dart';
import 'package:we_lean/api/responses/plan_update_response.dart';
import 'package:we_lean/api/responses/posts_response.dart';
import 'package:we_lean/api/responses/root_cause_update_data_response.dart';
import 'package:we_lean/api/responses/save_comment_reply.dart';
import 'package:we_lean/api/responses/save_comment_response.dart';
import 'package:we_lean/api/responses/today_plan_response.dart';
import 'package:we_lean/api/responses/update_plan_screen_data_response.dart';
import 'package:we_lean/api/responses/user_location_plan_response.dart';
import 'package:we_lean/api/responses/week_plan_data_response.dart';
import 'package:we_lean/api/responses/week_plan_response.dart';
import 'package:we_lean/api/responses/week_variance_graph_response.dart';
import 'package:we_lean/models/overall_ppc_data.dart';
import 'package:we_lean/models/update_plan_data.dart';
import 'package:we_lean/models/week_activity.dart';

import '../../utils/app_config.dart';
import 'package:dio/dio.dart';

import '../../utils/app_data.dart';
import '../responses/daywise_ppc_list_management_response.dart';
import '../responses/delete_rootcause_response.dart';
import '../responses/delete_weekactivity_response.dart';
import '../responses/login_response.dart';
import '../responses/logout_response.dart';
import '../responses/weekly_plan_response.dart';
import 'logging_interceptor.dart';

class ApiProvider{

  final String _baseUrl = "${AppConfig.plan_url}/api/";

  Dio? _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: Duration(milliseconds: 3000),
        connectTimeout: Duration(milliseconds: 3000),
        validateStatus: (status) => true,
        followRedirects: false);
    _dio = Dio(options);
    _dio?.options.headers.addAll({
      'content-type': 'application/json',
      'authorization': AppData.accessToken == null ? "" : 'Bearer ${AppData.accessToken}',
    });
    _dio?.interceptors.add(LoggingInterceptor());
  }


  String _handleError(error) {
    String errorDescription = "";
    if (error is DioException) {
      if (error is DioExceptionType) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            errorDescription = "Connection timeout with API server";
            break;
          case DioExceptionType.sendTimeout:
            errorDescription = "Send timeout in connection with API server";
            break;
          case DioExceptionType.receiveTimeout:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioExceptionType.badResponse:
            errorDescription =
            "Received invalid status code: ${error.response?.statusCode}";
            break;
          case DioExceptionType.cancel:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioExceptionType.badCertificate:
            errorDescription="SSL certificate validation failed : ${error.response?.statusMessage}";
          case DioExceptionType.connectionError:
            errorDescription="Connection timeout: ${error.response?.statusMessage}";
          case DioExceptionType.unknown:
            errorDescription="Unknown error occured";
        }
      }
      else {
        errorDescription = "Unexpected Error Occurred";
      }
    } else {
      errorDescription = error.toString();
      print(error);
      print(error.stackTrace);
    }
    return errorDescription;
  }

  Future<LoginResponse> loginUser(String empId, String password) async {
    try {
      Response response = await _dio!.post("${_baseUrl}login?emp_id=$empId&password=$password");
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        return LoginResponse.fromErrorJson(response.data);
      }
    } on DioError catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<WeekPlanDataResponse> getWeekPlanData() async {
    Response response = await _dio!.get("${_baseUrl}week-plans/create");
    return WeekPlanDataResponse.fromJson(response.data);
  }


  Future<WeekPlanResponse> weekPlanCreation(WeekPlan weekPlan) async {
    try{
      Response response =  await _dio!.post("${_baseUrl}week-plans",
       data:jsonEncode(weekPlan.toJson()));
      return WeekPlanResponse.fromJson(response.data);
    }catch(error){
       return WeekPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<UserLocationPlanResponse> getUserLocationPlan(int userId) async {
    try{
      Response response = await _dio!.get('${_baseUrl}userlocationplans/$userId');
      return UserLocationPlanResponse.fromJson(response.data);
    }catch(error){
      return UserLocationPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<WeeklyPlanResponse> getWeeklyPlan(int week_activity_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}week-plans/$week_activity_id/edit');
      return WeeklyPlanResponse.fromJson(response.data);
    }catch(error){
      return WeeklyPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<ApprovalResponse> changeApprovalStatus(int week_plan_id,int user_id,String status) async {
    try{
      Response response = await _dio!.put('${_baseUrl}week-plans/$week_plan_id?user_id=$user_id&status=$status');
      return ApprovalResponse.fromJson(response.data);
    }catch(error){
      return ApprovalResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<CurrentWeekPlanResponse> getCurrentWeekPlan(int user_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}currentweekplan/$user_id');
      return CurrentWeekPlanResponse.fromJson(response.data);
    }catch(error){
      return CurrentWeekPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<CurrentWeekPlanResponse> getPriviousWeekPlan(int user_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}previousweekplan/$user_id');
      return CurrentWeekPlanResponse.fromJson(response.data);
    }catch(error){
      return CurrentWeekPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<UpdatePlanScreenResponse> getCurrentWeekDayPlan(int week_activity_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}week-activities/$week_activity_id/edit');
      return UpdatePlanScreenResponse.fromJson(response.data);
    }catch(error){
      return UpdatePlanScreenResponse.withError(_handleError(error as TypeError)) ;
    }
  }



  Future<PlanUpdateResponse> planUpdate(int week_activity_id,UpdatePlanData updatePlanData) async {
    try{
      Response response =  await _dio!.put("${_baseUrl}week-activities/$week_activity_id",
          data:updatePlanData.toJson());
      return PlanUpdateResponse.fromJson(response.data);
    }catch(error){
      return PlanUpdateResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<DayPpcWeekActivityResponse> getDayPpc(int week_activity_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}day-ppc/$week_activity_id');
      return DayPpcWeekActivityResponse.fromJson(response.data);
    }catch(error){
      return DayPpcWeekActivityResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<WeekVariancePPCResponse> getWeekVariance(int user_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}week-variance-ppc/$user_id');
      return WeekVariancePPCResponse.fromJson(response.data);
    }catch(error){
      return WeekVariancePPCResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<LineChartVarianceResponse> getLineChartVarianceData(String variance_ids) async {
    try{
      Response response = await _dio!.get('${_baseUrl}view-variances?ids=$variance_ids');
      return LineChartVarianceResponse.fromJson(response.data);
    }catch(error){
      return LineChartVarianceResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<TodayPlanResponse> getTodayPlan(int user_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}day-activity/$user_id');
      return TodayPlanResponse.fromJson(response.data);
    }catch(error){
      return TodayPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<BarChartResponse> getBarChartPpc(int user_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-week-ppc-graph/$user_id');
      print(response.data);
      return BarChartResponse.fromJson(response.data);
    }catch(error){
      return BarChartResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<OverallPPCResponse> getOverallPpcData(int user_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-week-ppc/$user_id');
      return OverallPPCResponse.fromJson(response.data);
    }catch(error){
      return OverallPPCResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<DayWisePPCResponse> getDaywisePpcList(int week_plan_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-activity-ppc/$week_plan_id');
      return DayWisePPCResponse.fromJson(response.data);
    }catch(error){
      return DayWisePPCResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<VarianceApiResponse> getDailyVarianceData(int week_plan_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}wa-variance/$week_plan_id');
      return VarianceApiResponse.fromJson(response.data);
    }catch(error){
      return VarianceApiResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<LogoutResponse> doLogout() async {
    try {
      Response response = await _dio!.post("${_baseUrl}logout");
      print(response);
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      return LogoutResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<AddVarianceLogActionResponse> addActions(int variance_log_id,String actiondata) async {
    try {
      Response response = await _dio!.put("${_baseUrl}variance-logs/$variance_log_id?action=$actiondata");
      print(response);
      return AddVarianceLogActionResponse.fromJson(response.data);
    } catch (error) {
      return AddVarianceLogActionResponse.withError(_handleError(error as TypeError));
    }
  }


  Future<DraftWeekPlanResponse> getUserLocationPlanDrafts(int userId,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}userlocationplansdraft/$userId?proj_loc_id=$proj_loc_id');
      return DraftWeekPlanResponse.fromJson(response.data);
    }catch(error){
      return DraftWeekPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<ConfirmWeekPlanResponse> confirmWeekPlan(int weekId) async {
    try{
      Response response = await _dio!.post('${_baseUrl}week-plans-submit/$weekId');
      return ConfirmWeekPlanResponse.fromJson(response.data);
    }catch(error){
      return ConfirmWeekPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<AveragePPCBargraphResponse> getAveragePPCBargraph() async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-week-ppc-graph-overall');
      return AveragePPCBargraphResponse.fromJson(response.data);
    }catch(error){
      return AveragePPCBargraphResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<AveragePPCDataResponse> getAveragePPCData() async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-week-ppc-overall');
      return AveragePPCDataResponse.fromJson(response.data);
    }catch(error){
      return AveragePPCDataResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<DayWisePPCManagementResponse> getDaywisePPCMangementData(String weekPlanIds) async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-activity-ppc-overall/$weekPlanIds');
      return DayWisePPCManagementResponse.fromJson(response.data);
    }catch(error){
      return DayWisePPCManagementResponse.withError(_handleError(error as TypeError)) ;
    }
  }




  Future<LocationsResponse> getLocation() async {
    try {
      Response response = await _dio!.get("${_baseUrl}project-locations");
      return LocationsResponse.fromJson(response.data);
    } catch (error) {
      return LocationsResponse.withError(_handleError(error as TypeError));
    }
  }



  Future<OverallPPCResponse> getOverallPpcDataLocationwise(int user_id,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-week-ppc/$user_id?proj_loc_id=$proj_loc_id');
      return OverallPPCResponse.fromJson(response.data);
    }catch(error){
      return OverallPPCResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<BarChartResponse> getBarChartPpcLocationwise(int user_id,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}current-week-ppc-graph/$user_id?proj_loc_id=$proj_loc_id');
      print(response.data);
      return BarChartResponse.fromJson(response.data);
    }catch(error){
      return BarChartResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<TodayPlanResponse> getTodayPlanLocationwise(int user_id,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}day-activity/$user_id?proj_loc_id=$proj_loc_id');
      return TodayPlanResponse.fromJson(response.data);
    }catch(error){
      return TodayPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<WeekVariancePPCResponse> getWeekVarianceLocationwise(int user_id,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}week-variance-ppc/$user_id?proj_loc_id=$proj_loc_id');
      return WeekVariancePPCResponse.fromJson(response.data);
    }catch(error){
      return WeekVariancePPCResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<UserLocationPlanResponse> getUserLocationPlanLocationwise(int userId,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}userlocationplans/$userId?proj_loc_id=$proj_loc_id');
      return UserLocationPlanResponse.fromJson(response.data);
    }catch(error){
      return UserLocationPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<CurrentWeekPlanResponse> getCurrentWeekPlanLocationwise(int user_id,int proj_loc_id) async {
    try{
      Response response = await _dio!.get('${_baseUrl}currentweekplan/$user_id?proj_loc_id=$proj_loc_id');
      return CurrentWeekPlanResponse.fromJson(response.data);
    }catch(error){
      return CurrentWeekPlanResponse.withError(_handleError(error as TypeError)) ;
    }
  }



  Future<RootCauseUpdateResponse> updateRootCause(int varianceId,String why1,String why2,String why3,String why4,String why5,String groupId1,String groupId2,String groupId3,String groupId4,String groupId5) async {
    try{
      Response response = await _dio!.post('${_baseUrl}root-cause-update/$varianceId?why1=$why1&why2=$why2&why3=$why4&why4=$why4&why5=$why5&'
          'group_id_1=$groupId1&group_id_2=$groupId2&group_id_3=$groupId3&group_id_4=$groupId4&group_id_1=$groupId5'

      );
      return RootCauseUpdateResponse.fromJson(response.data);
    }catch(error){
      return RootCauseUpdateResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<PostResponse> addPost(int userId,String description,File postImgUrl) async {
    try{
      // Response response = await _dio!.post('${_baseUrl}posts?user_id=$userId&description=$description&post_images=$postImgUrl');

      final uri = '${_baseUrl}posts';

        // Prepare the file
        // File file = File(filePath);

        // Create form data
        FormData formData = FormData.fromMap({
          'user_id': userId,
          'description': description,
          'post_images': await MultipartFile.fromFile(
            postImgUrl.path,
            filename: postImgUrl.path.split('/').last,
            // contentType: MediaType('image','jpeg'),
          ),
        });

        // Send the POST request

        Response response = await _dio!.post(uri,data:formData);
        return PostResponse.fromJson(response.data);
    }catch(error){
      return PostResponse.withError(_handleError(error as TypeError)) ;
    }
  }



  Future<FeedPostsResponse> getFeedPosts() async {
    try{
      Response response = await _dio!.get('${_baseUrl}posts');
      return FeedPostsResponse.fromJson(response.data);
    }catch(error){
      return FeedPostsResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<SaveCommentResponse> addComment(int userId,int postId,String comment) async {
    try{
      Response response = await _dio!.post('${_baseUrl}save-comment?user_id=$userId&post_id=$postId&comments=$comment');
      return SaveCommentResponse.fromJson(response.data);
    }catch(error){
      return SaveCommentResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<SaveCommentReplyResponse> addCommentReply(int userId,int commentId,String comment) async {
    try{
      Response response = await _dio!.post('${_baseUrl}save-comment-reply?user_id=$userId&comment_id=$commentId&comments=$comment');
      return SaveCommentReplyResponse.fromJson(response.data);
    }catch(error){
      return SaveCommentReplyResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<LikePostResponse> addlikePost(int postId) async {
    try{
      Response response = await _dio!.put('${_baseUrl}posts/$postId?is_like=1');
      print(response.statusMessage);
      return LikePostResponse.fromJson(response.data);
    }catch(error){
      return LikePostResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<VariancesResponse> getVariances(int groupId) async {
    try{
      Response response = await _dio!.get('${_baseUrl}get-variances/$groupId');
      return VariancesResponse.fromJson(response.data);
    }catch(error){
      return VariancesResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<DeleteConstraintLogResponse> deleteConstraint(int constraintId) async {
    try{
      Response response = await _dio!.delete( '${_baseUrl}constraint-logs/$constraintId');
      return DeleteConstraintLogResponse.fromJson(response.data);
    }catch(error){
      return DeleteConstraintLogResponse.withError(_handleError(error as TypeError)) ;
    }
  }


  Future<DeleteWeekActivityResponse> deleteWeekActivity(int weekActivityId) async {
    try{
      Response response = await _dio!.delete( '${_baseUrl}week-activities/$weekActivityId');
      return DeleteWeekActivityResponse.fromJson(response.data);
    }catch(error){
      return DeleteWeekActivityResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<RootCauseDeleteResponse> deleteRootCause(int variancelogId,String why) async {
    try{
      Response response = await _dio!.put( '${_baseUrl}root-cause-delete/$variancelogId?delete=$why');
      return RootCauseDeleteResponse.fromJson(response.data);
    }catch(error){
      return RootCauseDeleteResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<DiscussionPostDeleteResponse> deletePost(int postId,int userId) async {
    try{
      Response response = await _dio!.delete( '${_baseUrl}posts/$postId?user_id=$userId');
      return DiscussionPostDeleteResponse.fromJson(response.data);
    }catch(error){
      return DiscussionPostDeleteResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<DiscussionPostDeleteResponse> deleteComment(int commentId,int userId) async {
    try{
      Response response = await _dio!.delete( '${_baseUrl}delete-comment/$commentId?user_id=$userId');
      return DiscussionPostDeleteResponse.fromJson(response.data);
    }catch(error){
      return DiscussionPostDeleteResponse.withError(_handleError(error as TypeError)) ;
    }
  }

  Future<DiscussionPostDeleteResponse> deleteCommentReply(int commentReplyId,int userId) async {
    try{
      Response response = await _dio!.delete( '${_baseUrl}delete-comment-reply/$commentReplyId?user_id=$userId');
      return DiscussionPostDeleteResponse.fromJson(response.data);
    }catch(error){
      return DiscussionPostDeleteResponse.withError(_handleError(error as TypeError)) ;
    }
  }




}