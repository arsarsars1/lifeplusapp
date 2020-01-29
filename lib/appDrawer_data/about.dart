import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifeplusapp/appDrawer_data/openSourceLicenses.dart';
import 'package:lifeplusapp/appDrawer_data/privacypolicy.dart';
import 'package:lifeplusapp/appDrawer_data/termsOfservices.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(FontAwesomeIcons.home),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/road.jpg"), // <-- BACKGROUND IMAGE
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Life Plus",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Source-Sans-Pro',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "version 1.0",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: MediaQuery.of(context).size.width * 0.107,
                      child: ClipOval(
                        child: Image.asset("assets/images/playstore.png"),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.3,
                    ),
                    RaisedButton(
                        color: Color(0xffffffff),
                        child: Text(
                          'Terms Of Services',
                          style: TextStyle(
                            color: Color(0xff6200ee),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) =>
                                      TermsOfServicePolicy()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    RaisedButton(
                        color: Color(0xffffffff),
                        child: Text(
                          'Open Source License',
                          style: TextStyle(
                            color: Color(0xff6200ee),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) => PrivacyPolicy()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    RaisedButton(
                        color: Color(0xffffffff),
                        child: Text(
                          'Third Party Libraries Used',
                          style: TextStyle(
                            color: Color(0xff6200ee),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) => LibrariesUsed()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    RaisedButton(
                        color: Color(0xffffffff),
                        child: Text(
                          'Check out Source Code',
                          style: TextStyle(
                            color: Color(0xff6200ee),
                          ),
                        ),
                        onPressed: () {
                          launchUrl(
                              'https://github.com/shivamkapasia0/lifeplusapp');
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
