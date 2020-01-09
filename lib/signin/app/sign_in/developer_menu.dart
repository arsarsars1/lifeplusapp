import 'package:lifeplusapp/maps_view.dart';
import 'package:lifeplusapp/signin/app/sign_in/auth_service_type_selector.dart';
import 'package:lifeplusapp/signin/constants/keys.dart';
import 'package:lifeplusapp/signin/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeveloperMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Column(children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Text(
                  Strings.developerMenu,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          _buildOptions(context),
        ]),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          AuthServiceTypeSelector(),
          Divider(
            height: 10.0,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) => MyMap()));
              },
              child: Text('              map')),
        ],
      ),
    );
  }
}
