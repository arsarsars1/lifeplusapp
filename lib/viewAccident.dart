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

class ViewAccident extends StatefulWidget {
  @override
  _ViewAccident createState() => _ViewAccident();
}

class _ViewAccident extends State<ViewAccident> {
  final databaseReference = FirebaseDatabase.instance.reference();

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
  String getdataValues;
  String namee;
  String location;
  String Date;
  String Time;
  String Description;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      databaseReference.once().then((DataSnapshot snapshot) {
        print('Data : ${snapshot.value}');
        getdataValues = snapshot.value.toString();

        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          print('Reported by ' + values['Reported by']);
          namee = values['Reported by'];
          email = values['Reporter Email'];
          location = values['location'];
          Date = values['Date'];
          Time = values['Time'];
          Description = values['Description'];
          print('name=' + namee);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
        title: Text("View Accidents"),
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
                'Recently Reported Accidents : ',
                //TODO:get database value
                //  getdataValues.toString(),
                style: TextStyle(
                  fontSize: 17.5,
                  height: 1.3,
                  fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            InkWell(
              onTap: () {
                AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'INFO',
                        desc: 'Reported By: ' +
                            namee +
                            '\nEmail id: ' +
                            email +
                            '\nLocation: ' +
                            location +
                            '\nDate: ' +
                            Date +
                            '\nTime: ' +
                            Time +
                            '\nDescription: ' +
                            Description,
//                        btnCancelOnPress: () {},
                        btnOkOnPress: () {})
                    .show();
              },
              child: Card(
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
                          image: AssetImage("assets/images/app.png"),
                          fit: BoxFit.scaleDown)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Accident Reported By ' + namee.toString(),
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
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
                  getData();
                  showCenterShortLoadingToast();
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                        FontAwesomeIcons.sync,
                        color: Colors.white,
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                        "Refresh",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'RobotoSlab'),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCenterShortLoadingToast() {
    FlutterFlexibleToast.showToast(
        message: "Refreshing",
        toastLength: Toast.LENGTH_LONG,
        toastGravity: ToastGravity.CENTER,
        icon: ICON.LOADING,
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
