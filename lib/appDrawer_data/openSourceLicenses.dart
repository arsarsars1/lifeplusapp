import 'package:flutter/material.dart';

class LibrariesUsed extends StatelessWidget {
  final String libraries = """  
  \ncupertino_icons: ^0.1.2
  \nanimated_text_kit: ^2.0.0
  \nrandom_string: ^2.0.1
  \ngoogle_sign_in: ^4.1.1
  \nprovider: ^3.2.0
  \nrxdart: ^0.18.1
  \nfirebase_dynamic_links: ^0.5.0+9
  \nflutter_secure_storage: ^3.3.1+1
  \npackage_info: ^0.4.0+13
  \nfirebase_auth: ^0.15.3
  \ngoogle_maps_flutter: ^0.5.21
  \ngeolocator: ^5.1.5
  \nflutter_boom_menu: ^0.0.2
  \nfont_awesome_flutter: ^8.5.0
  \nurl_launcher: ^5.4.1
  \nrounded_floating_app_bar: ^0.1.0
  \nslider_button: ^0.4.0
  \nfirebase_database: ^3.1.1
  \nsyncfusion_flutter_gauges: ^17.4.40
  \nawesome_dialog: ^0.1.1
  \nflutter_flexible_toast: ^0.1.2
  \nbot_toast: ^2.2.1
  \nintl: ^0.16.1
  \nshare: ^0.6.3+5
  \nflutter_spinkit: ^4.1.1
  \nflutter_open_whatsapp: ^0.1.2
  \ngiffy_dialog:
  \nfirebase_messaging: ^6.0.9
        """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Party Libraries'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Libraries and Packages used : " + '\n\n' + libraries,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
