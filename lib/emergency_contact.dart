import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
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

  void savedEmail(String email) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('email', email);
  }

  void showEmail() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    String email = myPrefs.getString('email');
    if (email == '') {
      EmailId = "No Email Found";
    } else {
      print(email);
      EmailId = '+' + email;
    }
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
  String EmailId;
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
//                showData();
//                showEmail();
                AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'INFO',
                        desc: 'Last saved contact number :' +
                            num +
                            '\nLast saved email :' +
                            EmailId,
                        //                           '\nLast saved Email : +$EmailId',
//                        btnCancelOnPress: () {},
                        btnOkOnPress: () {})
                    .show();
              }),
        ],
        title: Text("Ask Help"),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "Email id :",
              textAlign: TextAlign.left,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
//                inputFormatters: [
//                  WhitelistingTextInputFormatter.digitsOnly,
//                  LengthLimitingTextInputFormatter(20),
//                ],
                onChanged: (val) {
                  if (val != null || val.length > 0) EmailId = val;
                },
                controller: t2,
                decoration: InputDecoration(
                  // fillColor: Color(0xffe6e6e6),

                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Ex: lifeplusapp@gmail.com',
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
            Card(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  savedData(name);
                  savedEmail(EmailId);
                  showData();
                  showCenterShortLoadingToast();
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
                  onTap: () => setState(() {
                    launchUrl("tel:$num");
                  }),
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
                  onTap: () => FlutterOpenWhatsapp.sendSingleMessage(
                      "$num", "Hey I need your help"),
                  child: Icon(FontAwesomeIcons.whatsapp,
                      color: Colors.green, size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      launchUrl(
                          "mailto:$EmailId?subject=From ${user.displayName}&body=$message");
                    });
                  },
                  child: Icon(Icons.email, color: Colors.green, size: 35),
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
        message: "Info saved ",
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
