
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys{

  SharedPrefKeys._();

  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String userEmpId = 'user_emp_id';
  static const String userRole='user_role';
  static const String userEmail = 'user_email';
  static const String userToken = 'user_token';
  static const String startWeek='start_week';

  static const String projectLocationName='location_name';
  static const String projectLocationId='location_id';


}

class SharedPreferencesService{

  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {

    _instance ??= SharedPreferencesService._internal();
    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<void> setUserID(int userId) async =>
      await _preferences?.setInt(SharedPrefKeys.userId, userId);

  int ? get userId => _preferences?.getInt(SharedPrefKeys.userId);

  Future<void> setUserName(String userName) async =>
      await _preferences?.setString(SharedPrefKeys.userName, userName);

  String ? get userName =>
      _preferences?.getString(SharedPrefKeys.userName);

  Future<void> setUserRole(String role) async =>
      await _preferences?.setString(SharedPrefKeys.userRole, role);

  String ? get userRole =>
      _preferences?.getString(SharedPrefKeys.userRole);

  Future<void> setUserEmpId(String empId) async =>
      await _preferences?.setString(SharedPrefKeys.userEmpId, empId);

  String ? get userEmpId =>
      _preferences?.getString(SharedPrefKeys.userEmpId);

  Future<void> setUserEmail(String userEmail) async =>
      await _preferences?.setString(SharedPrefKeys.userEmail, userEmail);

  String ? get userEmail => _preferences?.getString(SharedPrefKeys.userEmail);

  Future<void> setUserToken(String userToken) async =>
      await _preferences?.setString(SharedPrefKeys.userToken, userToken);

  String ? get userToken => _preferences?.getString(SharedPrefKeys.userToken);

  Future<void> setStartWeek(String startWeek) async =>
      await _preferences?.setString(SharedPrefKeys.startWeek, startWeek);

  String ? get startWeek => _preferences?.getString(SharedPrefKeys.startWeek);


  Future<void> setProjectLocationName(String projectLocationName) async =>
      await _preferences?.setString(SharedPrefKeys.projectLocationName, projectLocationName);

  String ? get projectLocationName => _preferences?.getString(SharedPrefKeys.projectLocationName);

  Future<void> setProjectLocationId(int projectLocationId) async =>
      await _preferences?.setInt(SharedPrefKeys.projectLocationId, projectLocationId);

  int ? get projectLocationId => _preferences?.getInt(SharedPrefKeys.projectLocationId);


  Future<void> logoutUser() async {
    _preferences?.remove(SharedPrefKeys.userId);
    _preferences?.remove(SharedPrefKeys.userName);
    _preferences?.remove(SharedPrefKeys.userEmpId);
    _preferences?.remove(SharedPrefKeys.userEmail);
    _preferences?.remove(SharedPrefKeys.userToken);
    _preferences?.remove(SharedPrefKeys.startWeek);

    _preferences?.remove(SharedPrefKeys.projectLocationId);
    _preferences?.remove(SharedPrefKeys.projectLocationId);
  }


}