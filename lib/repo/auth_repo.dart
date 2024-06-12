

import '../api/apiData/api_provider.dart';
import '../api/responses/login_response.dart';
import '../api/responses/logout_response.dart';

abstract class AuthRepo {
  Future<LoginResponse> loginUser(String empId, String password);
  Future<LogoutResponse> logoutUser();

}

class RealAuthRepo implements AuthRepo {
  ApiProvider apiProvider = ApiProvider();

  @override
  Future<LoginResponse> loginUser(String empId, String password) {
    return apiProvider.loginUser(empId, password);
  }

  @override
  Future<LogoutResponse> logoutUser() {
    return ApiProvider().doLogout();
  }

}

class FakeAuthRepo implements AuthRepo {

  @override
  Future<LoginResponse> loginUser(String empId, String password) {
    throw UnimplementedError();
  }

  @override
  Future<LogoutResponse> logoutUser() {
    throw UnimplementedError();
  }

}