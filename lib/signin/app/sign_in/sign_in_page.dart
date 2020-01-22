import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifeplusapp/signin/app/sign_in/developer_menu.dart';
import 'package:lifeplusapp/signin/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:lifeplusapp/signin/app/sign_in/email_link/email_link_sign_in_page.dart';
import 'package:lifeplusapp/signin/app/sign_in/sign_in_manager.dart';
import 'package:lifeplusapp/signin/app/sign_in/social_sign_in_button.dart';
import 'package:lifeplusapp/signin/common_widgets/platform_exception_alert_dialog.dart';
import 'package:lifeplusapp/signin/constants/keys.dart';
import 'package:lifeplusapp/signin/constants/strings.dart';
import 'package:lifeplusapp/signin/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';

class SignInPageBuilder extends StatelessWidget {
  // P<ValueNotifier>
  //   P<SignInManager>(valueNotifier)
  //     SignInPage(value)
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, SignInManager manager, __) => SignInPage._(
              isLoading: isLoading.value,
              manager: manager,
              title: 'Firebase Auth Demo',
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.isLoading, this.manager, this.title})
      : super(key: key);
  final SignInManager manager;
  final String title;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');
  static const Key emailLinkButtonKey = Key('email-link');
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    final navigator = Navigator.of(context);
    await EmailPasswordSignInPage.show(
      context,
      onSignedIn: navigator.pop,
    );
  }

  Future<void> _signInWithEmailLink(BuildContext context) async {
    final navigator = Navigator.of(context);
    await EmailLinkSignInPage.show(
      context,
      onSignedIn: navigator.pop,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        elevation: 2.0,
//        title: Text(title),
//      ),
//      // Hide developer menu while loading in progress.
//      // This is so that it's not possible to switch auth service while a request is in progress
//      drawer: isLoading ? null : DeveloperMenu(),
//      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      '',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnnotatedRegion(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/road.jpg",
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
                scale: 50.0,
              ),
            ),
            Container(
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "WELCOME TO",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.w500),
                  ),
                  TyperAnimatedTextKit(
                    speed: Duration(
                      seconds: 1,
                    ),
                    textAlign: TextAlign.start,
                    alignment: AlignmentDirectional.bottomCenter,
                    isRepeatingAnimation: false,
                    textStyle: TextStyle(
                        color: Colors.green.shade200,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900),
                    text: <String>["Life +"],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    child: _buildHeader(),
                  ),
                  SizedBox(height: 48.0),
                  SliderButton(
                    action: () {
                      ///Do something here
                      _signInWithGoogle(context);
                    },
                    label: Text(
                      "Slide to Login with Google",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
//            icon: Text(
//              "x",
//              style: TextStyle(
//                color: Colors.white,
//                fontWeight: FontWeight.w400,
//                fontSize: 44,
//              ),
//            ),
                  ),
//          SocialSignInButton(
//            key: googleButtonKey,
//            assetName: 'assets/logo/go-logo.png',
//            text: Strings.signInWithGoogle,
//            onPressed: isLoading ? null : () => _signInWithGoogle(context),
//            color: Colors.white,
//          ),
                  SizedBox(
                    height: 5,
                  ),
                  Text.rich(
                    TextSpan(
                      text: '  By Clicking you agree to our ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms & Conditions.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            )),
                        // can add more TextSpans here...
                      ],
                    ),
                  ),
//          SizedBox(height: 8),
//          SocialSignInButton(
//            key: facebookButtonKey,
//            assetName: 'assets/fb-logo.png',
//            text: Strings.signInWithFacebook,
//            textColor: Colors.white,
//            onPressed: isLoading ? null : () => _signInWithFacebook(context),
//            color: Color(0xFF334D92),
//          ),
//          SizedBox(height: 8),
//          SignInButton(
//            key: emailPasswordButtonKey,
//            text: Strings.signInWithEmailPassword,
//            onPressed:
//                isLoading ? null : () => _signInWithEmailAndPassword(context),
//            textColor: Colors.white,
//            color: Colors.teal[700],
//          ),
//          SizedBox(height: 8),
//          SignInButton(
//            key: emailLinkButtonKey,
//            text: Strings.signInWithEmailLink,
//            onPressed: isLoading ? null : () => _signInWithEmailLink(context),
//            textColor: Colors.white,
//            color: Colors.blueGrey[700],
//          ),
//          SizedBox(height: 8),
//          Text(
//            Strings.or,
//            style: TextStyle(fontSize: 14.0, color: Colors.black87),
//            textAlign: TextAlign.center,
//          ),
//          SizedBox(height: 8),
//          SignInButton(
//            key: anonymousButtonKey,
//            text: Strings.goAnonymous,
//            color: Colors.lime[300],
//            textColor: Colors.black87,
//            onPressed: isLoading ? null : () => _signInAnonymously(context),
//          ),
                ],
              ),
            ),
          ],
        ),
      ),
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

//  Widget _buildSignIn(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(16.0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          SizedBox(
//            height: 50.0,
//            child: _buildHeader(),
//          ),
//          SizedBox(height: 48.0),
//          SliderButton(
//            action: () {
//              ///Do something here
//              _signInWithGoogle(context);
//            },
//            label: Text(
//              "Slide to Login with Google",
//              style: TextStyle(
//                  color: Colors.lightBlue,
//                  fontWeight: FontWeight.w500,
//                  fontSize: 17),
//            ),
//            icon: Icon(
//              FontAwesomeIcons.google,
//              color: Colors.red,
//            ),
////            icon: Text(
////              "x",
////              style: TextStyle(
////                color: Colors.white,
////                fontWeight: FontWeight.w400,
////                fontSize: 44,
////              ),
////            ),
//          ),
////          SocialSignInButton(
////            key: googleButtonKey,
////            assetName: 'assets/logo/go-logo.png',
////            text: Strings.signInWithGoogle,
////            onPressed: isLoading ? null : () => _signInWithGoogle(context),
////            color: Colors.white,
////          ),
//          SizedBox(
//            height: 5,
//          ),
//          Text.rich(
//            TextSpan(
//              text: '  By Clicking you agree to our ',
//              style: TextStyle(
//                fontSize: 15,
//              ),
//              children: <TextSpan>[
//                TextSpan(
//                    text: 'Terms & Conditions.',
//                    style: TextStyle(
//                      decoration: TextDecoration.underline,
//                      fontStyle: FontStyle.italic,
//                    )),
//                // can add more TextSpans here...
//              ],
//            ),
//          ),
////          SizedBox(height: 8),
////          SocialSignInButton(
////            key: facebookButtonKey,
////            assetName: 'assets/fb-logo.png',
////            text: Strings.signInWithFacebook,
////            textColor: Colors.white,
////            onPressed: isLoading ? null : () => _signInWithFacebook(context),
////            color: Color(0xFF334D92),
////          ),
////          SizedBox(height: 8),
////          SignInButton(
////            key: emailPasswordButtonKey,
////            text: Strings.signInWithEmailPassword,
////            onPressed:
////                isLoading ? null : () => _signInWithEmailAndPassword(context),
////            textColor: Colors.white,
////            color: Colors.teal[700],
////          ),
////          SizedBox(height: 8),
////          SignInButton(
////            key: emailLinkButtonKey,
////            text: Strings.signInWithEmailLink,
////            onPressed: isLoading ? null : () => _signInWithEmailLink(context),
////            textColor: Colors.white,
////            color: Colors.blueGrey[700],
////          ),
////          SizedBox(height: 8),
////          Text(
////            Strings.or,
////            style: TextStyle(fontSize: 14.0, color: Colors.black87),
////            textAlign: TextAlign.center,
////          ),
////          SizedBox(height: 8),
////          SignInButton(
////            key: anonymousButtonKey,
////            text: Strings.goAnonymous,
////            color: Colors.lime[300],
////            textColor: Colors.black87,
////            onPressed: isLoading ? null : () => _signInAnonymously(context),
////          ),
//        ],
//      ),
//    );
//  }
}
