import 'package:flutter/material.dart';
import '../controller/mobx.dart';
import '../style/colors.dart';


class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({Key? key}) : super(key: key);
  @override
  State<BottomBarWidget> createState() => BottomBarWidgetState();
}

class BottomBarWidgetState extends State<BottomBarWidget> {
  bool home = true;
  bool search = false;
  bool three = false;
  bool four = false;
  bool notification = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: const Color(0xffF3F3FA),
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0,right: 22,top: 10,bottom: 30),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                color: Colors.grey.shade200,
                  spreadRadius: 3,
                    offset: const Offset(0.0, 0.9)
              ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    home ? home = false : home = true;
                    search = false;
                    three = false;
                    four = false;
                    notification = false;
                    centralState.index = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: home == true ? lightPink : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/bottom_bar/_01_align_center_1_.png",
                      color: home == true ? pinkButton : Colors.grey,),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    search ? search = false : search = true;
                    home = false;
                    three = false;
                    four = false;
                    notification = false;
                    centralState.index = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: search == true ? lightPink : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/bottom_bar/Group.png",
                      color: search == true ? pinkButton : Colors.grey,),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    three ? three = false : three = true;
                    home = false;
                    search = false;
                    four = false;
                    notification = false;
                    centralState.index = 2;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: three == true ? lightPink : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/bottom_bar/01 align center.png",
                      color: three == true ? pinkButton : Colors.grey,),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    four ? four = false : four = true;
                    home = false;
                    search = false;
                    three = false;
                    notification = false;
                    centralState.index = 3;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: four == true ? lightPink : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/bottom_bar/Group-2.png",
                      color: four == true ? pinkButton : Colors.grey,),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    notification ? notification = false : notification = true;
                    home = false;
                    search = false;
                    four = false;
                    three = false;
                    centralState.index = 4;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: notification == true ? lightPink : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/bottom_bar/Notification icon - inactive.png",
                      color: notification == true ? pinkButton : Colors.grey,),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    home = false;
                    search = false;
                    four = false;
                    three = false;
                    notification = false;
                    centralState.index = 5;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: pinkButton,
                  child: Icon(Icons.add,color: Colors.white,),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}