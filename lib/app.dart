import 'package:authentication_task/Screens/LoginOrSignup/loginOrSignup.dart';
import 'package:authentication_task/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: LogInOrSignup.routeName,
          routes: routes,
          theme: ThemeData(fontFamily: 'Changa'),
        ),
      ),
    );
  }
}
