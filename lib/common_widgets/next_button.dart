import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class NextButton extends StatefulWidget {
  final String? text;

  const NextButton({super.key,this.text});

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: kIsWeb && MediaQuery.of(context).size.width < 1000 ?
        MediaQuery.of(context).size.width * 0.9
            : kIsWeb && MediaQuery.of(context).size.width < 1000 ?
        MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                Color(0xff96115B),
                Color(0xffF0349D),
              ],
              stops: [
                0.0,
                0.8
              ],
              // transform: GradientRotation(math.pi / 4),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text("${widget.text}",style: const TextStyle(fontSize: 15,
              color: Colors.white,fontWeight: FontWeight.w600),)),
        )
    );
  }
}