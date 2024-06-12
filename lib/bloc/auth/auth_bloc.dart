import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/utils/app_constants.dart';

import '../../models/user.dart';
import '../../repo/auth_repo.dart';
import '../../utils/app_data.dart';
import '../../utils/shared_pref_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if (event is PerformLogin) {
      String? errorMessage;
      try {
        final loginResponse = await authRepo.loginUser(event.empId, event.password);
        if (loginResponse.status == AppConstants.status_success && loginResponse.data != null)
          yield AuthLogin(loginResponse.data!, loginResponse.status);
        else {
          print(loginResponse.message);
          errorMessage = loginResponse.message;
          yield AuthLoginFailed(errorMessage);
        }
      }catch(e){
        yield AuthLoginFailed(e.toString());
      }
    }

    else if (event is PerformLogout) {
      try {
        final logoutResponse = await authRepo.logoutUser();
        if (logoutResponse.status == AppConstants.status_success) {
          AppData.user = null;
          final sharedPrefService = await SharedPreferencesService.instance;
          sharedPrefService.logoutUser();
          yield UnAuthenticated();
        } else
          yield AuthFailed(logoutResponse.status);
      } catch(e) {
        yield AuthFailed(e.toString());
      }
    }

    else if (event is PerformAutoLogin) {
      yield Authenticated(event.user);
    }

  }


}