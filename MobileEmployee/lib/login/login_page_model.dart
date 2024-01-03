import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 100.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 60),
          end: Offset(0, 0),
        ),
      ],
    ),
    'tabBarOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 200.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0, 30),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.emailAddressCreateController ??= TextEditingController();
    _model.emailAddressCreateFocusNode ??= FocusNode();

    _model.passwordCreateController ??= TextEditingController();
    _model.passwordCreateFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional(0, 1),
            children: [
              Align(
                alignment: AlignmentDirectional(1, -1.4),
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Align(
                  alignment: AlignmentDirectional(-2, -1.5),
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Align(
                  alignment: AlignmentDirectional(-1.25, -1.5),
                  child: Container(
                    width: 600,
                    height: 600,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Align(
                  alignment: AlignmentDirectional(2.5, -1.2),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Align(
                  alignment: AlignmentDirectional(1, -0.95),
                  child: Container(
                    width: 700,
                    height: 700,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 40,
                      sigmaY: 40,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).overlay,
                        ),
                        alignment: AlignmentDirectional(0, 1),
                        child: Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 64, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        if (Theme.of(context).brightness ==
                                            Brightness.light)
                                          Image.asset(
                                            'assets/images/noCode_UI_onLight@3x.png',
                                            width: 170,
                                            height: 50,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        if (Theme.of(context).brightness ==
                                            Brightness.dark)
                                          Image.asset(
                                            'assets/images/noCode_UI_onDark@3x.png',
                                            width: 170,
                                            height: 50,
                                            fit: BoxFit.fitWidth,
                                          ),
                                      ],
                                    ),
                                  ],
                                ).animateOnPageLoad(
                                    animationsMap['rowOnPageLoadAnimation']!),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Container(
                                    width: double.infinity,
                                    height: 500,
                                    constraints: BoxConstraints(
                                      maxWidth: 570,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment(0, 0),
                                                child: TabBar(
                                                  isScrollable: true,
                                                  labelColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  unselectedLabelColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  labelPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      24, 0, 24, 0),
                                                  labelStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleMedium,
                                                  unselectedLabelStyle:
                                                  TextStyle(),
                                                  indicatorColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondary,
                                                  indicatorWeight: 2,
                                                  tabs: [
                                                    Tab(
                                                      text: 'Sign In',
                                                    ),
                                                    Tab(
                                                      text: 'Sign Up',
                                                    ),
                                                  ],
                                                  controller:
                                                  _model.tabBarController,
                                                ),
                                              ),
                                              Expanded(
                                                child: TabBarView(
                                                  controller:
                                                  _model.tabBarController,
                                                  children: [
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                24,
                                                                20,
                                                                24,
                                                                0),
                                                            child:
                                                            TextFormField(
                                                              controller: _model
                                                                  .emailAddressController,
                                                              focusNode: _model
                                                                  .emailAddressFocusNode,
                                                              obscureText:
                                                              false,
                                                              decoration:
                                                              InputDecoration(
                                                                labelText:
                                                                'Email Address',
                                                                labelStyle:
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                hintText:
                                                                'Enter your email...',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .lineColor,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                errorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedErrorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                                contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    20,
                                                                    24,
                                                                    20,
                                                                    24),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium,
                                                              validator: _model
                                                                  .emailAddressControllerValidator
                                                                  .asValidator(
                                                                  context),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                24,
                                                                12,
                                                                24,
                                                                0),
                                                            child:
                                                            TextFormField(
                                                              controller: _model
                                                                  .passwordController,
                                                              focusNode: _model
                                                                  .passwordFocusNode,
                                                              obscureText: !_model
                                                                  .passwordVisibility,
                                                              decoration:
                                                              InputDecoration(
                                                                labelText:
                                                                'Password',
                                                                labelStyle:
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                hintText:
                                                                'Enter your password...',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .lineColor,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                errorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedErrorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                                contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    20,
                                                                    24,
                                                                    20,
                                                                    24),
                                                                suffixIcon:
                                                                InkWell(
                                                                  onTap: () =>
                                                                      setState(
                                                                            () => _model
                                                                            .passwordVisibility =
                                                                        !_model
                                                                            .passwordVisibility,
                                                                      ),
                                                                  focusNode: FocusNode(
                                                                      skipTraversal:
                                                                      true),
                                                                  child: Icon(
                                                                    _model.passwordVisibility
                                                                        ? Icons
                                                                        .visibility_outlined
                                                                        : Icons
                                                                        .visibility_off_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondaryText,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium,
                                                              validator: _model
                                                                  .passwordControllerValidator
                                                                  .asValidator(
                                                                  context),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                24,
                                                                16,
                                                                24,
                                                                0),
                                                            child: Wrap(
                                                              spacing: 24,
                                                              runSpacing: 8,
                                                              alignment:
                                                              WrapAlignment
                                                                  .center,
                                                              crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                              direction: Axis
                                                                  .horizontal,
                                                              runAlignment:
                                                              WrapAlignment
                                                                  .center,
                                                              verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                              clipBehavior:
                                                              Clip.none,
                                                              children: [
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    context.pushNamed(
                                                                        'null');
                                                                  },
                                                                  text:
                                                                  'Forgot Password?',
                                                                  options:
                                                                  FFButtonOptions(
                                                                    width: 140,
                                                                    height: 40,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    iconPadding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodySmall
                                                                        .override(
                                                                      fontFamily:
                                                                      'Readex Pro',
                                                                      fontSize:
                                                                      12,
                                                                    ),
                                                                    elevation:
                                                                    0,
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        50),
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    GoRouter.of(
                                                                        context)
                                                                        .prepareAuthEvent();

                                                                    final user =
                                                                    await authManager
                                                                        .signInWithEmail(
                                                                      context,
                                                                      _model
                                                                          .emailAddressController
                                                                          .text,
                                                                      _model
                                                                          .passwordController
                                                                          .text,
                                                                    );
                                                                    if (user ==
                                                                        null) {
                                                                      return;
                                                                    }

                                                                    context.goNamedAuth(
                                                                        'null',
                                                                        context
                                                                            .mounted);
                                                                  },
                                                                  text:
                                                                  'Sign In',
                                                                  options:
                                                                  FFButtonOptions(
                                                                    width: 130,
                                                                    height: 50,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    iconPadding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondary,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                        .titleSmall
                                                                        .override(
                                                                      fontFamily:
                                                                      'Readex Pro',
                                                                      color:
                                                                      FlutterFlowTheme.of(context).primaryBtnText,
                                                                    ),
                                                                    elevation:
                                                                    3,
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        60),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                20,
                                                                0,
                                                                20,
                                                                0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      12,
                                                                      0,
                                                                      0),
                                                                  child: Text(
                                                                    'Or use a social account to login',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodySmall,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                4,
                                                                0,
                                                                0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  child:
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .lineColor,
                                                                    borderRadius:
                                                                    12,
                                                                    borderWidth:
                                                                    1,
                                                                    buttonSize:
                                                                    44,
                                                                    icon:
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .google,
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryText,
                                                                      size: 16,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      GoRouter.of(
                                                                          context)
                                                                          .prepareAuthEvent();
                                                                      final user =
                                                                      await authManager
                                                                          .signInWithGoogle(context);
                                                                      if (user ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      context.goNamedAuth(
                                                                          'null',
                                                                          context
                                                                              .mounted);
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  child:
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .lineColor,
                                                                    borderRadius:
                                                                    12,
                                                                    borderWidth:
                                                                    1,
                                                                    buttonSize:
                                                                    44,
                                                                    icon:
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .apple,
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryText,
                                                                      size: 16,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      GoRouter.of(
                                                                          context)
                                                                          .prepareAuthEvent();
                                                                      final user =
                                                                      await authManager
                                                                          .signInWithApple(context);
                                                                      if (user ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      context.goNamedAuth(
                                                                          'null',
                                                                          context
                                                                              .mounted);
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  child:
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .lineColor,
                                                                    borderRadius:
                                                                    12,
                                                                    borderWidth:
                                                                    1,
                                                                    buttonSize:
                                                                    44,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .supervisor_account_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryText,
                                                                      size: 20,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      GoRouter.of(
                                                                          context)
                                                                          .prepareAuthEvent();
                                                                      final user =
                                                                      await authManager
                                                                          .signInAnonymously(context);
                                                                      if (user ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      context.goNamedAuth(
                                                                          'null',
                                                                          context
                                                                              .mounted);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                24,
                                                                20,
                                                                24,
                                                                0),
                                                            child:
                                                            TextFormField(
                                                              controller: _model
                                                                  .emailAddressCreateController,
                                                              focusNode: _model
                                                                  .emailAddressCreateFocusNode,
                                                              obscureText:
                                                              false,
                                                              decoration:
                                                              InputDecoration(
                                                                labelText:
                                                                'Email Address',
                                                                labelStyle:
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                hintText:
                                                                'Enter your email...',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .lineColor,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                errorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedErrorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                                contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    20,
                                                                    24,
                                                                    20,
                                                                    24),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium,
                                                              validator: _model
                                                                  .emailAddressCreateControllerValidator
                                                                  .asValidator(
                                                                  context),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                24,
                                                                12,
                                                                24,
                                                                0),
                                                            child:
                                                            TextFormField(
                                                              controller: _model
                                                                  .passwordCreateController,
                                                              focusNode: _model
                                                                  .passwordCreateFocusNode,
                                                              obscureText: !_model
                                                                  .passwordCreateVisibility,
                                                              decoration:
                                                              InputDecoration(
                                                                labelText:
                                                                'Password',
                                                                labelStyle:
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                hintText:
                                                                'Enter your password...',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodySmall,
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .lineColor,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                errorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                focusedErrorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryBackground,
                                                                contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    20,
                                                                    24,
                                                                    20,
                                                                    24),
                                                                suffixIcon:
                                                                InkWell(
                                                                  onTap: () =>
                                                                      setState(
                                                                            () => _model
                                                                            .passwordCreateVisibility =
                                                                        !_model
                                                                            .passwordCreateVisibility,
                                                                      ),
                                                                  focusNode: FocusNode(
                                                                      skipTraversal:
                                                                      true),
                                                                  child: Icon(
                                                                    _model.passwordCreateVisibility
                                                                        ? Icons
                                                                        .visibility_outlined
                                                                        : Icons
                                                                        .visibility_off_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondaryText,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium,
                                                              validator: _model
                                                                  .passwordCreateControllerValidator
                                                                  .asValidator(
                                                                  context),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                16,
                                                                0,
                                                                0),
                                                            child:
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                GoRouter.of(
                                                                    context)
                                                                    .prepareAuthEvent();

                                                                final user =
                                                                await authManager
                                                                    .createAccountWithEmail(
                                                                  context,
                                                                  _model
                                                                      .emailAddressCreateController
                                                                      .text,
                                                                  _model
                                                                      .passwordCreateController
                                                                      .text,
                                                                );
                                                                if (user ==
                                                                    null) {
                                                                  return;
                                                                }

                                                                context.goNamedAuth(
                                                                    'null',
                                                                    context
                                                                        .mounted);
                                                              },
                                                              text:
                                                              'Create Account',
                                                              options:
                                                              FFButtonOptions(
                                                                width: 190,
                                                                height: 50,
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondary,
                                                                textStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primaryBtnText,
                                                                ),
                                                                elevation: 3,
                                                                borderSide:
                                                                BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    50),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                20,
                                                                0,
                                                                20,
                                                                0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      12,
                                                                      0,
                                                                      0),
                                                                  child: Text(
                                                                    'Sign up using a social account',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodySmall,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                4,
                                                                0,
                                                                0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  child:
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .lineColor,
                                                                    borderRadius:
                                                                    12,
                                                                    borderWidth:
                                                                    1,
                                                                    buttonSize:
                                                                    44,
                                                                    icon:
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .google,
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryText,
                                                                      size: 16,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      GoRouter.of(
                                                                          context)
                                                                          .prepareAuthEvent();
                                                                      final user =
                                                                      await authManager
                                                                          .signInWithGoogle(context);
                                                                      if (user ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      context.goNamedAuth(
                                                                          'null',
                                                                          context
                                                                              .mounted);
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  child:
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .lineColor,
                                                                    borderRadius:
                                                                    12,
                                                                    borderWidth:
                                                                    1,
                                                                    buttonSize:
                                                                    44,
                                                                    icon:
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .apple,
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryText,
                                                                      size: 16,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      GoRouter.of(
                                                                          context)
                                                                          .prepareAuthEvent();
                                                                      final user =
                                                                      await authManager
                                                                          .signInWithApple(context);
                                                                      if (user ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      context.goNamedAuth(
                                                                          'null',
                                                                          context
                                                                              .mounted);
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  child:
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .lineColor,
                                                                    borderRadius:
                                                                    12,
                                                                    borderWidth:
                                                                    1,
                                                                    buttonSize:
                                                                    44,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .supervisor_account_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .primaryText,
                                                                      size: 20,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      GoRouter.of(
                                                                          context)
                                                                          .prepareAuthEvent();
                                                                      final user =
                                                                      await authManager
                                                                          .signInAnonymously(context);
                                                                      if (user ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      context.goNamedAuth(
                                                                          'null',
                                                                          context
                                                                              .mounted);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ).animateOnPageLoad(animationsMap[
                                          'tabBarOnPageLoadAnimation']!),
                                        ),
                                      ],
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
                                ),
                              ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                              ))
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
