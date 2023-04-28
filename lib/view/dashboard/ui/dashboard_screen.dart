import 'package:flutter/material.dart';
import 'package:example/view/signup/ui/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/mobx.dart';
import '../../../api/dashboard/dashboard_api.dart';
import 'dart:convert';
import '../../../common_widgets/next_button.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import '../../../style/colors.dart';
import '../../../common_widgets/snackbar.dart';
import 'package:flutter/foundation.dart';


class DashboardScreenWidget extends StatefulWidget {
  const DashboardScreenWidget({super.key});

  @override
  State<DashboardScreenWidget> createState() => _DashboardScreenWidgetState();
}

class _DashboardScreenWidgetState extends State<DashboardScreenWidget> {
  Map<String, dynamic>? map;
  bool data = false;
  TextEditingController service = TextEditingController();
  TextEditingController desc = TextEditingController();

  getData(){
    Dashboard.dashboardData().then((value) {
      setState(() {
        map = jsonDecode(value);
        data = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Center(child: Text("Dashboard")),
        actions: [
          GestureDetector(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Provider"),
                      content: Container(
                          height: 200,
                          width: kIsWeb ? 600 : MediaQueryData().size.width * 0.6,
                          child: Column(
                        children: [
                          Container(
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
                                controller: service,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color(0x80343f4b),
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                    ),
                                    // hintStyle: ,
                                    hintText: 'Service'),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
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
                                controller: desc,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color(0x80343f4b),
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                    ),
                                    // hintStyle: ,
                                    hintText: 'Description'),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                              onTap:(){
                                if(service.text == null || service.text == ""){
                                  showSnackbar(
                                    context: context,
                                    title: "Service field is empty!",
                                    duration: const Duration(seconds: 4),
                                  );
                                }
                                else if(desc.text == null || desc.text == ""){
                                  showSnackbar(
                                    context: context,
                                    title: "Description field is empty!",
                                    duration: const Duration(seconds: 4),
                                  );
                                }
                                else{
                                  Loader.show(context,progressIndicator: const CircularProgressIndicator(
                                    color: pinkButton,
                                  ));
                                  Dashboard.addDashboardData(
                                      service: service.text,
                                      desc: desc.text
                                  ).then((value) {
                                    Navigator.pop(context);
                                    Loader.hide();
                                    getData();
                                  });
                                }
                              },
                              child: NextButton(text: "Submit"))
                        ],
                      )),
                    );
                  }
              );
            },
            child: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.add)),
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              centralState.email = null;
              centralState.token = null;
              centralState.name = null;
              centralState.id = null;
              prefs.remove("Login");
              prefs.remove("email");
              prefs.remove("password");
              prefs.remove("OnBoarding");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
              => SignUpScreenWidget()), (route) => false);
            },
            child: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: data == false ?  Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 6),
          child: Expanded(
            child: ListView.builder(
                itemCount: map!['data']['providers'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${map!['data']['providers'][index]['service']}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              SizedBox(height: 2,),
                              Text("${map!['data']['providers'][index]['email']}",style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 10,),
                              Text("${map!['data']['providers'][index]['desc']}"),
                            ],
                          )
                      )
                  ));
                }),
          )
      ),
    );
  }
}