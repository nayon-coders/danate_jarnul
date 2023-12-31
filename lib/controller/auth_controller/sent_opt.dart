import 'dart:convert';
import 'dart:math';

import 'package:dante/boxs/boxs.dart';
import 'package:dante/config/app_config.dart';
import 'package:dante/model/auth_model/email_verify_model.dart';
import 'package:dante/view/auth/verify_email.dart';
import 'package:dante/view/auth/verify_success.dart';
import 'package:dante/view/index.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/app_loading.dart';

class SendOtp{


  // otp send method
  // now we can use this method anywhere in our project. its take 2 parameters.
  static Future sendOTP({required BuildContext context,  required String email})async{
    AppLoading.appLoading(context: context);
    EmailOTP myauth = EmailOTP();

    //otp config
    myauth.setConfig(
        appEmail: AppConfig.APP_MAIL,
        appName: "Dante - Digital Dating Journal: Verify you email. ",
        userEmail: "$email",
        otpLength: 5,
        otpType: OTPType.digitsOnly
    );

    if(await myauth.sendOTP() == true){//if otp sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
        content: Text('Verification code has been sent.'),
      ));
      Navigator.pop(context);
      //redirect otp verification page
      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailVerify(myauth: myauth, email: email,)));
    }else{ //if otp not sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 3500),
        content: Text('OTP Not Send to your email. Please try again!'),
      ));
      Navigator.pop(context);
    }

  }


  //check otp
  // now we can use this method anywhere in our project. its take 2 parameters.
  static Future checkOTP({required BuildContext context,  required String otp,  required EmailOTP myauth, required String email, required bool exitUser, required bool noUserFound, required String userToken})async{

    AppLoading.appLoading(context: context);
    var res =await myauth.verifyOTP(otp: otp);

    SharedPreferences prefs = await SharedPreferences.getInstance();


    print("exit user === $exitUser");
    print("no user found === $noUserFound");
    print("no user found === $userToken");



    if(res){
      //if otp sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
        content: Text('Email Verified.'),
      ));

      //login token
      final random = Random();
      final chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
      final length = 32;
      String token = String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
      print(token);


      if(exitUser == true && noUserFound == false){
        prefs.setString("token", userToken);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Index()), (route) => false);
      }else {
        print("=================== user is not exit =========================");
        //this mean user is not exit
        //now create a new user
        prefs.setString("token", token.toString()); //store the token data

        //create random user id
        var id = new Random().nextInt(1000);
        var data = LoginModel(
            id: id,
            email: email,
            isVerified: true,
            isLogin: true,
            token: token
        );
        var box = await Boxes.getLogin;
        box.put("${id}", data);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VerifySuccess()), (route) => false);
      }


    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 3500),
        content: Text('OTP do not match. Please try again!'),
      ));
      Navigator.pop(context);
    }

  }

}