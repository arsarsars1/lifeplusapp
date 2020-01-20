import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  bool _isNotifications = true;
  bool _isAppUpdates = true;
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
//            Padding(
//              padding:
//                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
//              child: Text(
//                "Leave us a message, and we'll get in contact with you as soon as possible. ",
//                style: TextStyle(
//                  fontSize: 17.5,
//                  height: 1.3,
//                  fontFamily: 'RobotoSlab',
//                ),
//                textAlign: TextAlign.justify,
//              ),
//            ),
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
                      image: DecorationImage(
                          image: AssetImage("assets/images/bell.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Notifications',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Switch(
                        value: true,
                        onChanged: null,
                      ),
                    ],
                  ),
                ),
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
                      image: DecorationImage(
                          image: AssetImage("assets/images/app_updates.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'App Updates',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Switch(
                        value: _isAppUpdates,
                        activeColor: Colors.blue,
                        onChanged: (value) async {
                          _isAppUpdates = false;
                        },
                        // activeTrackColor: Theme.of(context).accentColor,
                        inactiveTrackColor: Theme.of(context).accentColor,
                        inactiveThumbColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
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
                      image: DecorationImage(
                          image: AssetImage("assets/images/moon.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Switch(
                        value: _isAppUpdates,
                        activeColor: Colors.blue,
                        onChanged: (value) async {
                          _isAppUpdates = false;
                        },
                        // activeTrackColor: Theme.of(context).accentColor,
                        inactiveTrackColor: Theme.of(context).accentColor,
                        inactiveThumbColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
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
                      image: DecorationImage(
                          image: AssetImage("assets/images/map.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Live Tracking',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Switch(
                        value: _isAppUpdates,
                        activeColor: Colors.blue,
                        onChanged: (value) async {
                          _isAppUpdates = false;
                        },
                        // activeTrackColor: Theme.of(context).accentColor,
                        inactiveTrackColor: Theme.of(context).accentColor,
                        inactiveThumbColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
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
                      image: DecorationImage(
                          image: AssetImage("assets/images/car.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Speed Limit',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Switch(
                        value: _isAppUpdates,
                        activeColor: Colors.blue,
                        onChanged: (value) async {
                          _isAppUpdates = false;
                        },
                        // activeTrackColor: Theme.of(context).accentColor,
                        inactiveTrackColor: Theme.of(context).accentColor,
                        inactiveThumbColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
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
                      image: DecorationImage(
                          image: AssetImage("assets/images/star.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rate App\n\nShare App',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                      Column(
                        children: <Widget>[
                          RaisedButton(
                              color: Color(0xffffffff),
                              child: Icon(
                                FontAwesomeIcons.star,
                                color: Color(0xff6200ee),
                              ),
                              onPressed: () {
                                launchUrl(
                                    'https://play.google.com/store/apps/details?id=comlifeplusapp&hl=en_IN');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          RaisedButton(
                              color: Color(0xffffffff),
                              child: Icon(
                                FontAwesomeIcons.share,
                                color: Color(0xff6200ee),
                              ),
                              onPressed: () {
                                Share.share('Hey download this amazing app :' +
                                    'https://play.google.com/store/apps/details?id=comlifeplusapp&hl=en_IN');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        ],
                      )
                    ],
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
