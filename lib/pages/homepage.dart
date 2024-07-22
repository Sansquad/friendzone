// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  ///
  final String title;
  const HomePageWidget({super.key, required this.title}); // Add const here

  ///
  /// const HomePageWidget({super.key});
  

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFBD3E),
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/40054.png',
                    width: 274,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Friend',
                        style:
                            FlutterFlowTheme.of(context).displayLarge.override(
                                  fontFamily: 'Turret Road',
                                  color: Colors.black,
                                  letterSpacing: 0,
                                ),
                      ),
                      Text(
                        'Zone',
                        style:
                            FlutterFlowTheme.of(context).displayLarge.override(
                                  fontFamily: 'Turret Road',
                                  letterSpacing: 0,
                                ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        // context.pushNamed('Getstarted');
                        Navigator.pushNamed(context, 'Getstarted');
                      },
                      text: 'Create Account',
                      options: FFButtonOptions(
                        width: 288,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Colors.white,
                        textStyle:
                            FlutterFlowTheme.of(context).displayMedium.override(
                                  fontFamily: 'Overlock',
                                  color: Colors.black,
                                  letterSpacing: 0,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        // context.pushNamed('Signin');
                      Navigator.pushNamed(context, 'Signin');

                      },
                      text: 'Sign In',
                      options: FFButtonOptions(
                        width: 288,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsets.all(0),
                        color: Colors.white,
                        textStyle:
                            FlutterFlowTheme.of(context).displayMedium.override(
                                  fontFamily: 'Overlock',
                                  color: Colors.black,
                                  letterSpacing: 0,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ]
                      .divide(SizedBox(height: 20))
                      .addToStart(SizedBox(height: 50)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
