//import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/material.dart';
//
//class FirebaseDemoScreen extends StatelessWidget {
//  final databaseReference = FirebaseDatabase.instance.reference();
//
//  @override
//  Widget build(BuildContext context) {
//    getData();
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Report Accident'),
//      ),
//      body: Center(
//          child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          RaisedButton(
//            child: Text('Report Accident'),
//            onPressed: () {
//              createRecord();
//            },
//          ),
//          RaisedButton(
//            child: Text('View Accident'),
//            onPressed: () {
//              getData();
//            },
//          ),
//          RaisedButton(
//            child: Text('Update Accident'),
//            onPressed: () {
//              updateData();
//            },
//          ),
//          RaisedButton(
//            child: Text('Delete Accident Report'),
//            onPressed: () {
//              deleteData();
//            },
//          ),
//        ],
//      )), //center
//    );
//  }
//
//  void createRecord() {
//    databaseReference
//        .child("1")
//        .set({'title': 'Accident reported', 'description': 'at location'});
//    databaseReference.child("2").set({
//      'title': 'Accident reported',
//      'description': 'at location',
//      'location': 'longitude & latitude'
//    });
//  }
//
//  void getData() {
//    databaseReference.once().then((DataSnapshot snapshot) {
//      print('Data : ${snapshot.value}');
//    });
//  }
//
//  void updateData() {
//    databaseReference
//        .child('1')
//        .update({'description': 'J2EE complete Reference'});
//  }
//
//  void deleteData() {
//    databaseReference.child('1').remove();
//  }
//}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lifeplusapp/signin/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportAccident extends StatefulWidget {
  @override
  _ReportAccident createState() => _ReportAccident();
}

class _ReportAccident extends State<ReportAccident> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name},${place.locality}, ${place.postalCode}, ${place.administrativeArea} , ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String name;
  String email;
  String message;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DateTime now = DateTime.now();
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    String res = timeOfDay.format(context);
    bool is12HoursFormat = res.contains(new RegExp(r'[A-Z]'));
    String formattedDate = DateFormat('EEE d MMM').format(now);
//    String formattedTime = DateFormat('kk:mm:ss').format(now);
    void createRecord() {
      _getCurrentLocation();
      databaseReference.child('Reported By ' + user.displayName).set({
        'Reported by': user.displayName,
        'Reporter Email': user.email,
        'Date': formattedDate,
        'Time': res,
        'Description': '$message',
        'longitude': _currentPosition.longitude.toString(),
        'latitude': _currentPosition.latitude.toString(),
        'location': '$_currentAddress'
      });
//      databaseReference.child("2").set({
//        'Name': user.displayName,
//        'Email': user.email,
//        'Description': '$message',
//        'location': ' & latitude'
//      });
    }

    void getData() {
      databaseReference.once().then((DataSnapshot snapshot) {
        print('Data : ${snapshot.value}');
      });
    }

    void updateData() {
      databaseReference.child('1').update({'description': 'update'});
    }

    void deleteData() {
      databaseReference.child('Reported By ' + user.displayName).remove();
    }

    var checkedValue = true;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Report Accident"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
              child: Text(
                "Report an accident, and we'll notify other user's to help as soon as possible.",
                style: TextStyle(
                  fontSize: 17.5,
                  height: 1.3,
                  fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
//            SizedBox(
//              height: MediaQuery.of(context).size.height * 0.02,
//            ),
//            Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: TextField(
//                onChanged: (val) {
//                  if (val != null || val.length > 0) email = val;
//                },
//                controller: t1,
//                decoration: InputDecoration(
//                  fillColor: Color(0xffe6e6e6),
//                  filled: true,
//                  contentPadding:
//                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                  hintText: user.email,
//                  hintStyle: TextStyle(
//                      color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(12),
//                    ),
//                    borderSide: BorderSide(color: Colors.grey[400]),
//                  ),
//                  enabledBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(12),
//                    ),
//                    borderSide: BorderSide(color: Colors.grey[400]),
//                  ),
//                  focusedBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(12),
//                    ),
//                    borderSide: BorderSide(color: Colors.grey[400]),
//                  ),
//                ),
//              ),
//            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0001,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) message = val;
                },
                textAlign: TextAlign.start,
                controller: t2,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  hintText: 'Your message',
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'RobotoSlab',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
              ),
            ),

            CheckboxListTile(
              title: Text("Include other info"),
              value: checkedValue,
              onChanged: (newValue) {
                AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'INFO',
                        desc:
                            'Information includes:\n*your name\n*your email\n*location\n*Reporting Time',
//                        btnCancelOnPress: () {},
                        btnOkOnPress: () {})
                    .show();
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Card(
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
//                  setState(() {
//                    t1.clear();
//                    t2.clear();
//                    launchUrl(
//                        "mailto:kapasiashivam007@gmail.com?subject=From $name&body=$message");
//                  });

                  _getCurrentLocation();
                  createRecord();
                  showCenterShortLoadingToast();
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                        "Report Accident",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'RobotoSlab'),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Card(
              color: Colors.deepOrangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  deleteData();
                  showCenterShortLoadingToasttwo_delete();
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                        FontAwesomeIcons.trashAlt,
                        color: Colors.white,
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                        "Delete Reported Accident",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'RobotoSlab'),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 21,
                  right: 21,
                  bottom: MediaQuery.of(context).size.height * 0.034),
              child: Text(
                "Alternatively, you can also check us out on the following platforms",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.blueGrey[600],
                  fontSize: 17,
                  height: 1.3,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => launchUrl("https://github.com/shivamkapasia0"),
                  child: Icon(
                    FontAwesomeIcons.github,
                    color: Colors.blueGrey[800],
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () =>
                      launchUrl("https://www.instagram.com/shivaay0o7/"),
                  child: Icon(FontAwesomeIcons.instagram,
                      color: Color(0xfffb3958), size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(FontAwesomeIcons.whatsapp,
                      color: Color(0xfffb3958), size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCenterShortLoadingToast() {
    FlutterFlexibleToast.showToast(
        message: "Accident Reported",
        toastLength: Toast.LENGTH_LONG,
        toastGravity: ToastGravity.TOP,
        icon: ICON.SUCCESS,
        radius: 100,
        elevation: 10,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        timeInSeconds: 2);
  }

  void showCenterShortLoadingToasttwo_delete() {
    FlutterFlexibleToast.showToast(
        message: "Report Deleted",
        toastLength: Toast.LENGTH_LONG,
        toastGravity: ToastGravity.TOP,
        icon: ICON.SUCCESS,
        radius: 100,
        elevation: 10,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        timeInSeconds: 2);
  }
}
