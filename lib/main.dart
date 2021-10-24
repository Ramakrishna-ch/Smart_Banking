import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_test/screens/forms/modify_user_details.dart';
import 'package:sms_test/screens/forms/newformtype.dart';
import 'screens/forms/add_user_services.dart';
import './rest/my_services.dart';

import 'screens/forms/user_services_list_screen.dart';
import 'screens/drawpage.dart';
import './screens/editDetails.dart';
import 'screens/authentication/registerpage.dart';
import './screens/splash_screen.dart';
import 'screens/authentication/startup_screen.dart';
import './rest/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Login(),
        ),
        ChangeNotifierProvider.value(
          value: My_Services(),
        ),
      ],
      child: Consumer<Login>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isauth
              ? HomePage()
              : FutureBuilder(
                  future: auth.checkuser(),
                  builder: (ctx, autosnap) =>
                      autosnap.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : StartUpScreen(),
                ),
          routes: {
            RegisterPage.routeName: (ctx) => RegisterPage(),
            StartUpScreen.routename: (ctx) => StartUpScreen(),
            HomePage.routeName: (ctx) => HomePage(),
            EditDetails.routename: (ctx) => EditDetails(),
            User_services_list_screen.routeName: (ctx) =>
                User_services_list_screen(),
            Add_New_Request.routename: (ctx) => Add_New_Request(),
            NewFormType.routename: (ctx) => NewFormType(),
            Modify_userDetails.routename: (ctx) => Modify_userDetails(),
          },
        ),
      ),
    );
  }
}
