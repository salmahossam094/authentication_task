import 'package:authentication_task/Screens/Login/login.dart';
import 'package:authentication_task/Screens/LoginOrSignup/loginOrSignup.dart';
import 'package:authentication_task/Screens/Register/register.dart';
import 'package:flutter/widgets.dart';

import 'Screens/HomePage.dart';


final Map<String, WidgetBuilder> routes = {
  LogInOrSignup.routeName: (context) => const LogInOrSignup(),
  Login.routeName: (context) => const Login(),
  Register.routeName: (context) => const Register(),
  HomePage.routeName: (context) => const HomePage(),

};
