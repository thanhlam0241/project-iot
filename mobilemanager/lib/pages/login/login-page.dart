import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilemanager/animations/shake_animation.dart';
import 'package:mobilemanager/pages/login/login-page-state-controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  LoginPageState() {
    controller = LoginPageStateController(state: this);
  }

  late GlobalKey<ShakeAnimationState> shakeAnimationKey;

  late LoginPageStateController controller;

  @override
  void initState() {
    super.initState();
    shakeAnimationKey = GlobalKey<ShakeAnimationState>();
    controller.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    shakeAnimationKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/photo-1514924013411-cbf25faa35bb.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    bottom: controller.isLoaded ? 0 : -440,
                    left: 0,
                    right: 0,
                    height: 440,
                    duration: const Duration(milliseconds: 500),
                    child: loginPanel(),
                  ),
                ],
              ))),
    );
  }

  Widget loginPanel() {
    return Container(
      // margin: const EdgeInsets.only(left: 30, right: 30),
      padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
      decoration: const BoxDecoration(
        color: Color(0xfff6f6f6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Đăng nhập',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          controller.loginErrorMessage.isNotEmpty
              ? errorAlert()
              : const SizedBox(
                  height: 10,
                ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color(0xffffffff), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffd9d9d9),
                    style: BorderStyle.solid),
              ),
              labelText: 'Tên đăng nhập',
              contentPadding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 1, style: BorderStyle.solid),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffd9d9d9),
                    style: BorderStyle.solid),
              ),
              labelText: 'Mật khẩu',
              contentPadding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: () {
              controller.login();
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 40, right: 40),
            ),
            child: const Text('Đăng nhập', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget errorAlert() {
    return ShakeAnimation(
      shakeOffset: 16,
      shakeCount: 4,
      duration: const Duration(milliseconds: 700),
      key: shakeAnimationKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  controller.loginErrorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
