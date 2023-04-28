import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/view/signup/ui/signup_screen.dart';
import 'package:example/view/dashboard/ui/dashboard_screen.dart';
import '../../../api/Auth/Auth.dart';
import '../../../controller/mobx.dart';
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;
  String? login, onBoarding, email, password;

  Future<void> data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getString('Login');
      email = prefs.getString('email');
      password = prefs.getString('password');
    });
  }

  @override
  void initState(){
    animation = AnimationController(vsync: this, duration: const Duration(seconds: 5),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.9).animate(animation!);

    animation?.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animation?.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        animation?.forward();
      }
    });
    animation?.forward();
    data();
    Future.delayed(const Duration(seconds: 3),(){
     if(login == "true") {
        Auth.logIn(
            email: email,
            password: password
        ).then((value) async {
          if (kDebugMode) {
            print(value);
          }
          Map<String, dynamic> map = jsonDecode(value);
          setState(() {
            centralState.email = map['data']['loginUser']['email'];
            centralState.name = map['data']['loginUser']['name'];
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('Login', "true");
          prefs.setString('email', centralState.email!);
          prefs.setString('name', centralState.name!);
          prefs.setString("password", password!);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreenWidget()));
      });}
      else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreenWidget()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeInFadeOut!,
        child: Container(
        ),
      ),
    );
  }
}