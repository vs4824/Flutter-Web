import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/Auth/Auth.dart';
import '../../../common_widgets/next_button.dart';
import '../../../common_widgets/snackbar.dart';
import '../../../controller/mobx.dart';
import '../../../style/colors.dart';
import '../../dashboard/ui/dashboard_screen.dart';
import '../../signup/ui/signup_screen.dart';
import 'dart:io';
import 'dart:convert';


class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 12),
            child: Center(
              child: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100,),
                    Image.asset("assets/images/login/image 4.png"),
                    const Text("Welcome back",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Welcome back! Please enter your details.",style: TextStyle(fontSize: 16,color: Colors.grey),),
                    ),
                    const SizedBox(height: 30,),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("Email"),
                    ),
                    Container(
                      width: kIsWeb && MediaQuery.of(context).size.width < 1000 ?
                      MediaQuery.of(context).size.width * 0.9
                          : kIsWeb && MediaQuery.of(context).size.width < 1000 ?
                      MediaQuery.of(context).size.width * 0.4
                          : MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xd9343f4b),
                              fontFamily: 'Lato'),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          controller: email,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0x80343f4b),
                                fontFamily: 'Lato',
                                fontSize: 15,
                              ),
                              // hintStyle: ,
                              hintText: 'Enter your email'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("Password"),
                    ),
                    Container(
                      width: kIsWeb && MediaQuery.of(context).size.width < 1000 ?
                      MediaQuery.of(context).size.width * 0.9
                          : kIsWeb && MediaQuery.of(context).size.width < 1000 ?
                      MediaQuery.of(context).size.width * 0.4
                          : MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xd9343f4b),
                              fontFamily: 'Lato'),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          controller: password,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0x80343f4b),
                                fontFamily: 'Lato',
                                fontSize: 15,
                              ),
                              // hintStyle: ,
                              hintText: '**************'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    GestureDetector(
                      onTap: () {
                        if(email.text == null || email.text == ""){
                          showSnackbar(
                            context: context,
                            title: "Email field is empty!",
                            duration: const Duration(seconds: 4),
                          );
                        }
                        else if(password.text == null || password.text == ""){
                          showSnackbar(
                            context: context,
                            title: "Password field is empty!",
                            duration: const Duration(seconds: 4),
                          );
                        }
                        else{
                          Loader.show(context,progressIndicator: const CircularProgressIndicator(
                            color: pinkButton,
                          ));
                          Auth.logIn(
                              email: email.text,
                              password: password.text
                          ).then((value) async {
                            print(value);
                            Loader.hide();
                            Map<String, dynamic> map = jsonDecode(value);
                            setState(() {
                              centralState.email = map['data']['loginUser']['email'];
                              centralState.name = map['data']['loginUser']['name'];
                            });
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('Login', "true");
                            prefs.setString('email', centralState.email!);
                            prefs.setString('name', centralState.name!);
                            prefs.setString("password", password.text);
                            showSnackbar(
                              context: context,
                              title: "Login Successfully",
                              duration: const Duration(seconds: 4),
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                            => const DashboardScreenWidget()));
                          });
                        }
                      },
                      child: const NextButton(
                        text: "Log in",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don’t have an account?",style: TextStyle(fontSize: 14),),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreenWidget()));
                            },
                            child: const Text(" Sign up",style: TextStyle(color: Color(0xffF0349D),
                                fontSize: 14),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}