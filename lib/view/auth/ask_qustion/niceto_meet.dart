import '../../../utility/app_colors.dart';
import '/view/auth/ask_qustion/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utility/app_button.dart';
import 'get_name.dart';



class NiceToMeet extends StatefulWidget {
  final String name;
  const NiceToMeet({Key? key, required this.name}) : super(key: key);

  @override
  State<NiceToMeet> createState() => _NiceToMeetState();
}

class _NiceToMeetState extends State<NiceToMeet> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:AppColors.bgColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text("Nice to meet you ${widget.name}!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                        fontSize: 25,
                      )
                  ),
                ),
                SizedBox(height: 2.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text("We’re excited to embark on this awesome journey with you!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        wordSpacing: 0.9,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                SizedBox(
                  height: 250, width: size.width,
                  child: Image.asset("assets/images/qus2_icon.png", fit: BoxFit.contain,),
                ),

                SizedBox(height: 4.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text("Next we’ll ask you a couple of questions to help you with your goals for dating.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        wordSpacing: 0.9,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.normalTxtColor
                    ),
                  ),
                ),
                SizedBox(height: 5.h,),

                AppButton(
                  onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Question(name: widget.name,))), //rout the next login pages
                  size: size,
                  child: Text("Let's go",
                    style: TextStyle(
                        fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
