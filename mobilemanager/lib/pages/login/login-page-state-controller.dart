import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilemanager/models/api-response.dart';
import 'package:mobilemanager/pages/routes.dart';
import 'package:mobilemanager/services/authentication-service.dart';

import 'login-page.dart';

class LoginPageStateController {
  LoginPageStateController({required this.state});

  LoginPageState state;

  //<editor-fold desc="Private Properties">

  //<end editor-fold>

  //<editor-fold desc="Public Properties">
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String loginErrorMessage = "";
  bool isLoaded = false;
  //</editor-fold>

  //<editor-fold desc="Private Methods">

  //</editor-fold>

  //<editor-fold desc="Public Methods">
  Future<void> initState() async {
    var authResult = await AuthenticationService.instance.isAuthenticated();
    if(authResult) {
      if(state.mounted) {
        state.setState(() {
          GoRouter.of(state.context).go(RouteUrls.MACHINE_URL);
        });
      }
      return;
    }
    if(state.mounted) {
      state.setState(() {
        isLoaded = true;
      });
    }
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  void login() async {
    var username = usernameController.text.trim();
    var password = passwordController.text;
    if(username.isEmpty || password.isEmpty) {
      if(state.mounted) {
        state.setState(() {
          loginErrorMessage = "Cần nhập đầy đủ Tên đăng nhập và Mật khẩu";
          var shakeAnimationState = state.shakeAnimationKey.currentState;
          shakeAnimationState?.shake();
        });
      }
      return;
    }
    var result = await AuthenticationService.instance.login(usernameController.text, passwordController.text);
    if(result.status == Status.SUCCESS) {
      if(state.mounted) {
        state.setState(() {
          GoRouter.of(state.context).go(RouteUrls.MACHINE_URL);
        });
      }
    }
    else {
      if(state.mounted) {
        state.setState(() {
          loginErrorMessage = result.message;
          state.shakeAnimationKey.currentState?.shake();
        });
      }
    }
  }

}