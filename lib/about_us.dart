import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String arrows = '---------------*****---------------';
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
          child: Icon(FontAwesomeIcons.chevronLeft),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
//              decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight,
//                      colors: [
//                    Colors.blue,
//                    Colors.orange,
//                  ])
////                image: DecorationImage(
////                  image: AssetImage(
////                      "assets/images/road.jpg"), // <-- BACKGROUND IMAGE
////                  fit: BoxFit.cover,
////                ),
//                  ),
                  ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Our Team : ",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Source-Sans-Pro',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: MediaQuery.of(context).size.width * 0.107,
                        child: ClipOval(
                          child: Image.network(
                              'https://instagram.fdel1-1.fna.fbcdn.net/v/t51.2885-19/s150x150/81809112_2528015457433482_7972926664067776512_n.jpg?_nc_ht=instagram.fdel1-1.fna.fbcdn.net&_nc_ohc=KID-l0PTs88AX9ZAZ-H&oh=12585a8fa7a4f6511c8e6b47f0fb5672&oe=5ED0E3A2'),
                        ),
                      ),
                      Text(
                        "Aditya Pratap Singh",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () =>
                                launchUrl("https://www.facebook.com/saditya05"),
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.instagram.com/aditya_sigh/"),
                            child: Icon(FontAwesomeIcons.instagram,
                                color: Color(0xfffb3958), size: 35),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        arrows,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: MediaQuery.of(context).size.width * 0.107,
                        child: ClipOval(
                          child: Image.network(
                              'https://instagram.fdel1-1.fna.fbcdn.net/v/t51.2885-19/s150x150/53255483_2085100281559385_3331370591205720064_n.jpg?_nc_ht=instagram.fdel1-1.fna.fbcdn.net&_nc_ohc=6IRU57doC7wAX9GabQu&oh=ba344eef1776830fb9de49aaae3a8df6&oe=5EA57B89'),
                        ),
                      ),
                      Text(
                        "Saket Kumar Jaiswal",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.facebook.com/saket.jaiswal.92"),
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.instagram.com/saket_1911/"),
                            child: Icon(FontAwesomeIcons.instagram,
                                color: Color(0xfffb3958), size: 35),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        arrows,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: MediaQuery.of(context).size.width * 0.107,
                        child: ClipOval(
                          child: Image.network(
                              'https://instagram.fdel1-1.fna.fbcdn.net/v/t51.2885-19/s150x150/74984697_839249973204612_6565089981335863296_n.jpg?_nc_ht=instagram.fdel1-1.fna.fbcdn.net&_nc_ohc=gtnuf15CqDIAX8yU8CD&oh=7461d59bf5755d75ffd2f7c681d98c85&oe=5EA31F3F'),
                        ),
                      ),
                      Text(
                        "Sumit Kumar",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.facebook.com/profile.php?id=100003121304751"),
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.instagram.com/sumit9075/"),
                            child: Icon(FontAwesomeIcons.instagram,
                                color: Color(0xfffb3958), size: 35),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        arrows,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: MediaQuery.of(context).size.width * 0.107,
                        child: ClipOval(
                          child: Image.network(
                              'https://instagram.fdel1-1.fna.fbcdn.net/v/t51.2885-19/s150x150/81403178_453141895589714_3441829612391235584_n.jpg?_nc_ht=instagram.fdel1-1.fna.fbcdn.net&_nc_ohc=epjDAECXYJwAX80DtW8&oh=3319746d69d9649533d461cb338632ea&oe=5EA525FE'),
                        ),
                      ),
                      Text(
                        "Shivam Kapasia",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () =>
                                launchUrl("https://github.com/shivamkapasia0"),
                            child: Icon(
                              FontAwesomeIcons.github,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.instagram.com/shivaay0o7/"),
                            child: Icon(FontAwesomeIcons.instagram,
                                color: Color(0xfffb3958), size: 35),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://www.linkedin.com/in/shivam-kapasia-8a485218a/"),
                            child: Icon(FontAwesomeIcons.linkedin,
                                color: Colors.blue, size: 35),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                                "https://shivamkapasia0.github.io/portfolio-webpage/"),
                            child: Icon(FontAwesomeIcons.google,
                                color: Colors.deepOrange, size: 30),
                          ),
                        ],
                      ),
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
