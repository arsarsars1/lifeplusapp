import 'package:lifeplusapp/signin/app/auth_widget_builder.dart';
import 'package:lifeplusapp/signin/app/email_link_error_presenter.dart';
import 'package:lifeplusapp/signin/app/auth_widget.dart';
import 'package:lifeplusapp/signin/services/auth_service.dart';
import 'package:lifeplusapp/signin/services/auth_service_adapter.dart';
import 'package:lifeplusapp/signin/services/firebase_email_link_handler.dart';
import 'package:lifeplusapp/signin/services/email_secure_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // [initialAuthServiceType] is made configurable for testing
  const MyApp({this.initialAuthServiceType = AuthServiceType.firebase});
  final AuthServiceType initialAuthServiceType;

  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that can be created right away
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider<AuthService>(
          create: (_) => AuthServiceAdapter(
            initialAuthServiceType: initialAuthServiceType,
          ),
          dispose: (_, AuthService authService) => authService.dispose(),
        ),
        Provider<EmailSecureStore>(
          create: (_) => EmailSecureStore(
            flutterSecureStorage: FlutterSecureStorage(),
          ),
        ),
        ProxyProvider2<AuthService, EmailSecureStore, FirebaseEmailLinkHandler>(
          update: (_, AuthService authService, EmailSecureStore storage, __) =>
              FirebaseEmailLinkHandler.createAndConfigure(
            auth: authService,
            userCredentialsStorage: storage,
          ),
          dispose: (_, linkHandler) => linkHandler.dispose(),
        ),
      ],
      child: AuthWidgetBuilder(
          builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
          ),
          darkTheme: ThemeData(
            /*For Automatic brightness/Theme of App */
            brightness: Brightness.dark,
            primaryColor: Colors.black38,
            // primaryColor: Color.fromRGBO(48, 48, 48, 1),
          ),
          //primarySwatch: Colors.indigo),
          home: EmailLinkErrorPresenter.create(
            context,
            child: AuthWidget(userSnapshot: userSnapshot),
          ),
        );
      }),
    );
  }
}
