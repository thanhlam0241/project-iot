import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '/http_command/http_request.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  /// Initialization and disposal methods.

  String fullName = "";
  String identityCard = "";
  String role = "";

  @override
  void initState(BuildContext context){
  }

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}


