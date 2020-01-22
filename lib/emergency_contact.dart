import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifeplusapp/signin/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContact extends StatefulWidget {
  @override
  _EmergencyContact createState() => _EmergencyContact();
}

class _EmergencyContact extends State<EmergencyContact> {
  final databaseReference = FirebaseDatabase.instance.reference();
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool checkedValue = false;
  @override
  void initState() {
    super.initState();
    showData();
  }

  _launchURLMail() async {
    const url =
        'mailto:smith@example.org?subject=LifePlusApp&body=Your sugestions%20or Feedback..';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String num;
  void savedData(String number) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt('number', 6);
    myPrefs.setString('number', number);
    myPrefs.setBool('syncData', false);
  }

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

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String name;
  String message;
  String helpMessage = 'jndwenwocne';
  String SenderNmae;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    SenderNmae = user.displayName;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.infoCircle),
              color: Theme.of(context).accentColor,
              onPressed: () {
                AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'INFO',
                        desc: 'Last saved contact number :' + num,
//                        btnCancelOnPress: () {},
                        btnOkOnPress: () {})
                    .show();
              }),
        ],
        title: Text("My Contacts"),
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
                "Save numbers of your friends, and we'll notify them in case of emergency. ",
                style: TextStyle(
                  fontSize: 17.5,
                  height: 1.3,
                  fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
                onChanged: (val) {
                  if (val != null || val.length > 0) name = val;
                },
                controller: t1,
                decoration: InputDecoration(
                  // fillColor: Color(0xffe6e6e6),

                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Ex: 918089799797',
                  hintStyle: TextStyle(
                      color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
            CheckboxListTile(
              title: Text("Data Protection"),
              value: checkedValue,
              onChanged: (bool value) {
                setState(() {
                  checkedValue = value;
                });
                AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'Data Protection',
                        desc:
                            'By Enabling your data will only be stored locally.',
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
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  savedData(name);
                  showData();
                  showCenterShortLoadingToast();
                  AwesomeDialog(
                          context: context,
                          headerAnimationLoop: false,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          tittle: 'INFO',
                          desc:
                              'This number has been saved locally on your phone and will be deleted automatically if you uninstall app.',
//                        btnCancelOnPress: () {},
                          btnOkOnPress: () {})
                      .show();
//                  setState(() {
//                    t1.clear();
//                    t2.clear();
//                    launchUrl(
//                        "mailto:lifeplusapp2020@gmail.com?subject=From $name&body=$message");
//                  });
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                        FontAwesomeIcons.solidSave,
                        color: Colors.white,
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'RobotoSlab'),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 21,
                  right: 21,
                  bottom: MediaQuery.of(context).size.height * 0.034),
              child: Text(
                "Currently, we only support one number per user...",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.redAccent,
                  fontSize: 17,
                  height: 1.3,
                ),
              ),
            ),
            Text(
              "Alternatively, you can also contact your friend through following platforms.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'RobotoSlab',
                color: Colors.blueGrey[600],
                fontSize: 17,
                height: 1.3,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => launchUrl(
                      "https://github.com/shivamkapasia0/lifeplusapp"),
                  child: Icon(
                    FontAwesomeIcons.phoneAlt,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      launchUrl("sms:$num?body=$helpMessage");
                    });
                  },
                  child:
                      Icon(FontAwesomeIcons.sms, color: Colors.blue, size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => _launchURLMail(),
                  child: Icon(FontAwesomeIcons.whatsapp,
                      color: Colors.green, size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void createRecord() {
    databaseReference
        .child("1")
        .set({'title': 'Accident reported', 'description': 'at location'});
    databaseReference.child("2").set({
      'title': 'Accident reported',
      'description': 'at location',
      'location': 'longitude & latitude'
    });
  }

  void showCenterShortLoadingToast() {
    FlutterFlexibleToast.showToast(
        message: "Number Saved",
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
