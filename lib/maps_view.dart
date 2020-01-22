import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:lifeplusapp/about_us.dart';
import 'package:lifeplusapp/database_accident.dart';
import 'package:lifeplusapp/emergency_contact.dart';
import 'package:lifeplusapp/license.dart';
import 'package:lifeplusapp/privacyPolicy.dart';
import 'package:lifeplusapp/settingPage.dart';
import 'package:lifeplusapp/signin/common_widgets/platform_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lifeplusapp/speedometer.dart';
import 'package:lifeplusapp/appDrawer_data/about.dart';
import 'package:lifeplusapp/appDrawer_data/privacypolicy.dart';
import 'package:lifeplusapp/appDrawer_data/reach_us.dart';
import 'package:lifeplusapp/home_page.dart';
import 'package:lifeplusapp/signin/common_widgets/platform_alert_dialog.dart';
import 'package:lifeplusapp/signin/common_widgets/platform_exception_alert_dialog.dart';
import 'package:lifeplusapp/signin/constants/strings.dart';
import 'package:lifeplusapp/signin/services/auth_service.dart';
import 'package:lifeplusapp/viewAccident.dart';
import 'package:provider/provider.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

//class MyMapSampleState extends State<MyMap> {
//  final Map<String, Marker> _markers = {};
//  @override
//  void initState() {
//    super.initState();
//    _getLocation();
//  }
//
//  void _getLocation() async {
//    var currentLocation = await Geolocator()
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//    print(currentLocation.longitude);
//    print(currentLocation.latitude);
//    setState(() {
//      _markers.clear();
//      final marker = Marker(
//        markerId: MarkerId("curr_loc"),
//        position: LatLng(currentLocation.latitude, currentLocation.longitude),
//        infoWindow: InfoWindow(title: 'Your Location'),
//      );
//      _markers["Current Location"] = marker;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      floatingActionButton: FloatingActionButton(
//        onPressed: _getLocation,
//        tooltip: 'Get Location ',
//        child: Icon(Icons.flag),
//      ),
//      appBar: AppBar(
//        title: Text('Maps Sample App'),
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//      ),
//      body: GoogleMap(
//        mapType: MapType.normal,
//        initialCameraPosition: CameraPosition(
//          target: position,
//          zoom: 11,
//        ),
//        myLocationButtonEnabled: true,
//        markers: _markers.values.toSet(),
//      ),
//    );
//  }
//}
class MyMapSampleState extends State<MyMap> {
  ///Firebase Messaging
  String _message = '';
  int navbarselectedIndex = 0;
  bool newNotification = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() {
        newNotification = true;
        _message = message['notification']['title'];
      });
//      setState(() =>
//      _message = message["notification"]["title"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }

  String textValue = 'Hello World !';
  update(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/${token}').set({"token": token});
    textValue = token;
    debugPrint(textValue);
    setState(() {});
  }

  ///
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

  Completer<GoogleMapController> controller1;

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;

  @override
  void initState() {
    super.initState();
    getMessage();
    _getUserLocation();
    _getUserLocation();
    getVehicleSpeed();
  }

  ///Speed Function
  double speedInMps;
  double speedInKph;
  var speed;
  int finalSpeed;
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  Future<void> getVehicleSpeed() async {
    try {
      geolocator.getPositionStream((locationOptions)).listen((position) async {
        speedInMps = await position.speed;
        setState(() {
          speedInKph = speedInMps * 1.609344;
          speed = speedInKph.round();
        });

        print(speed);
        if (speed >= 70) {
          if (speed <= 1) {
            startTimer();
            AwesomeDialog(
                context: context,
                headerAnimationLoop: false,
                dialogType: DialogType.WARNING,
                animType: AnimType.BOTTOMSLIDE,
                tittle: 'Do you need help?',
                desc: 'Reporting Accident & Asking for help in ' +
                    _start.toString() +
                    "seconds, " +
                    'Click on Cancel to ignore.',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (context) => ReportAccident()));
                }).show();
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///End Speed Function
  ///Timer Function
  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (speed > 1) {
            timer.cancel();
          } else if (speed <= 1) {
            _start = _start - 1;

            if (_start == 0) {
              timer.cancel();
              super.dispose();
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => ReportAccident()));
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  ///End Timer Function
  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: "last location",
              snippet: "This is a snippet",
              onTap: () {}),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.powerOff),
              color: Theme.of(context).accentColor,
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    headerAnimationLoop: false,
                    dialogType: DialogType.INFO,
                    animType: AnimType.TOPSLIDE,
                    tittle: 'Sign Out ?',
                    desc: 'Are you sure to sign out?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      _signOut(context);
                    }).show();
              }),
        ],
        title: Text(
          "Life Plus",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 30,
          ),
        ),
//        leading: InkWell(
//          onTap: () {
//            Drawer();
//          },
//          child: CircleAvatar(
//            backgroundColor: Colors.transparent,
//            radius: 20.0,
//            child: ClipOval(
//              child: new SizedBox(
//                width: 40.0,
//                height: 40.0,
//                child: new Image.network(user.photoUrl),
//              ),
//            ),
//          ),
//        ),
      ),
      drawer: new Drawer(
        elevation: 80.0,
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                user.displayName,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              accountEmail: Text(
                user.email,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/road.jpg'),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 100.0,
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.home,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Home', textScaleFactor: 1.5,
                  //style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) => HomePage()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.userAlt,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'My Profile',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => EmergencyContact()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.hireAHelper,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Emergency contacts',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => ReportAccident()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.carCrash,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Report Accident',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => ViewAccident()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.solidEye,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'View Accidents',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) => ReachUs()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.phoneAlt,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Ask Help',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) => ReachUs()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.bell,
                  color: Theme.of(context).accentColor,
                ),
                trailing: Icon(
                  FontAwesomeIcons.solidBell,
                  color: Colors.deepOrange,
                ),
                title: Text(
                  'Notifications',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => SettingPage()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.cog,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Settings and Privacy',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) => ReachUs()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.questionCircle,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Help Centre',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) => AboutPage()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.infoCircle,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'About App',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => AboutUsPage()));
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.users,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'About Us',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => LicensePolicy()));
              },
              child: ListTile(
                leading: Text('License  © 2020'),
                trailing: Text('LifePlus v 1.0    '),
                title: Icon(FontAwesomeIcons.scroll),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),

        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(FontAwesomeIcons.carCrash, color: Colors.black),
            title: "Report Accident",
            titleColor: Colors.white,
            subtitle: "You can Report Accident & Ask For Help.",
            subTitleColor: Colors.white,
            backgroundColor: Colors.deepOrange,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => ReportAccident()));
            },
          ),
          MenuItem(
            child: Icon(Icons.message, color: Colors.black),
            title: "Contact Friends",
            titleColor: Colors.white,
            subtitle: "Stay Connecting With Your Friends & Family.",
            subTitleColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => NetworkGiffyDialog(
                        image: Image.network(
                          "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                          fit: BoxFit.cover,
                        ),
                        entryAnimation: EntryAnimation.TOP_LEFT,
                        title: Text(
                          'Help',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w600),
                        ),
                        description: Text(
                          'Press power button 3 times in case of emergency',
                          textAlign: TextAlign.center,
                        ),
                        onOkButtonPressed: () {},
                      ));
            },
          ),
          MenuItem(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20.0,
              child: ClipOval(
                child: new SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: new Image.network(user.photoUrl),
                ),
              ),
            ),
            title: "My Profile",
            titleColor: Colors.white,
            subtitle: "You Can View your Profile.",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (context) => HomePage()));
            },
          ),
          MenuItem(
            child: Icon(FontAwesomeIcons.car, color: Colors.black),
            title: "Your Speed is $speed km/h",
            titleColor: Colors.white,
            subtitle: "View Your Speed, History & More.",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () {
              getVehicleSpeed();
              print(speed);
            },
          )
        ],
      ),
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                ),
//                child: Text(
//                  'loading map..',
//                  style: TextStyle(
//                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
//                ),
              ),
            )
          : Container(
              child: Stack(children: <Widget>[
                GoogleMap(
                  markers: _markers,
                  mapType: _currentMapType,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.4746,
                  ),
                  onMapCreated: _onMapCreated,
                  zoomGesturesEnabled: true,
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 620.0, 0.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          mapButton(_onAddMarkerButtonPressed,
                              Icon(Icons.add_location), Colors.blue),
                          mapButton(_onMapTypeButtonPressed,
                              Icon(FontAwesomeIcons.undo), Colors.blue),
//                          mapButton(
//                              _onMapTypeButtonPressed,
//                              Icon(
//                                FontAwesomeIcons.heartbeat,
//                                    fontFamily: CupertinoIcons.iconFont,
//                                    fontPackage:
//                                        CupertinoIcons.iconFontPackage),
//                              ),
                          //  Colors.green),
//                          mapButton(
//                              _onMapTypeButtonPressed,
//                              Icon(
//                                IconData(0xf473,
//                                    fontFamily: CupertinoIcons.iconFont,
//                                    fontPackage:
//                                        CupertinoIcons.iconFontPackage),
//                              ),
//                              Colors.green),
                        ],
                      )),
                )
              ]),
            ),
    );
  }
}

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      new ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController =
      new StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
