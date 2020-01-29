import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifeplusapp/appDrawer_data/openSourceLicenses.dart';
import 'package:lifeplusapp/appDrawer_data/privacypolicy.dart';
import 'package:lifeplusapp/appDrawer_data/termsOfservices.dart';
import 'package:lifeplusapp/signin/common_widgets/platform_alert_dialog.dart';
import 'package:lifeplusapp/signin/common_widgets/platform_exception_alert_dialog.dart';
import 'package:lifeplusapp/signin/constants/strings.dart';
import 'package:lifeplusapp/signin/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthService auth = Provider.of<AuthService>(context);
      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  @override
  void initState() {
    showData();
  }

  String num;
  void showData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    String number = myPrefs.getString('number');
    if (number == '') {
      num = "No Number Found";
    } else {
      print(number);
      num = '+' + number;
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: <Widget>[
            Container(
//              decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight,
//                      colors: [
//                    Colors.orange,
//                    Colors.blue,
//                    Colors.yellow,
//                    Colors.green,
//                    Colors.teal
//                  ])
////                image: DecorationImage(
////                  image: AssetImage(
////                      'assets/images/road.jpg'), // <-- BACKGROUND IMAGE
////                  fit: BoxFit.cover,
////                ),
//                  ),
                ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: MediaQuery.of(context).size.width * 0.107,
                      child: ClipOval(
                        child: Image.network(user.photoUrl),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Name : ' + user.displayName,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Email id : ' + user.email,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'UserId: ' + user.uid,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    RaisedButton(
                        color: Color(0xffffffff),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Color(0xff6200ee),
                          ),
                        ),
                        onPressed: () {
                          _confirmSignOut(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    RaisedButton(
                        color: Color(0xffffffff),
                        child: Icon(
                          FontAwesomeIcons.home,
                          color: Color(0xff6200ee),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
