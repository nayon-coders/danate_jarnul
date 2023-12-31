import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dante/boxs/boxs.dart';
import 'package:dante/utility/app_button.dart';
import 'package:dante/view/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller/auth_controller.dart';
import '../../model/profile_model/profile_model.dart';
import '../../utility/app_colors.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool status = false;

  Future<ProfileModel>? showProfileFuture;
  /// Initialize platform state.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }


  //EMAIL
  var userid, dob, email, fname, lname, image, isVerify;
   showProfile()async{



     List userTokenList = [];
     List userIdList = [];

     SharedPreferences prefes = await SharedPreferences.getInstance();
     var token = prefes.getString("token");

     print("this user token ==== ${token}");


     for(var i = 0; i < Boxes.getLogin.length; i ++){
       //store data with index
       var data = Boxes.getLogin.getAt(i);
       print("userIdList ${data?.id}");
      if(data?.token == token){
        userIdList.add(data?.id);
        userTokenList.add(data?.token);
      }
     }

     print("userIdList ${userIdList}");
     userid = userIdList[0];
     print(userid);
     var profiles = await Boxes.getProfile.get("${userid}");
     print("profiles?.email ${profiles?.email}");

     if(profiles != null){
       if(userTokenList.contains(token)){
         setState(() {
           fname = profiles.fName;
           lname = profiles.lName;
           image = profiles.profile;
           dob = profiles.dob;
         });
         return profiles;
       }
     }else{
       return Get.to(EditProfile());
     }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProfile();
    initPlatformState();
    openNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      //profile app bar 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Profile",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textColor,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: 7, bottom: 7),
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
              onPressed: ()=>Get.to(EditProfile(), transition: Transition.rightToLeft),
              icon: Icon(IconlyLight.edit,),
            ),
          )
        ],
      ),
      
      //profile body 
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(30),
        child: Column(
          children: [

          fname != null ? Container(
          width: size.width,
          padding: EdgeInsets.all(30),
          height: 30.h,
          decoration: BoxDecoration(
              color: AppColors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image != null? Image.memory(image, height: 120, width: 120, fit: BoxFit.cover) : Image.asset("assets/images/profile.jpeg", height: 120, width: 120,),
              ),
              SizedBox(height: 20,),
              Text("${fname} ${lname}",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.date_range, color: AppColors.mainColor,),
                  SizedBox(width: 10,),
                  Text("${dob}",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              )
            ],
          ),
        ):buildEditProfile(size),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [

                  buildProfileItems(
                    image: "assets/icons/info.png",
                    title: "Notification",
                    isTrailing: true,

                 ),
                  buildProfileItems(
                    image: "assets/icons/baloon.png",
                    title: "Relationships Goals",
                  ),
                  buildProfileItems(
                    image: "assets/icons/info.png",
                    title: "About Us",
                  ),
                  buildProfileItems(
                    image: "assets/icons/privacy.png",
                    title: "Privacy",
                  ),
                  buildProfileItems(
                    image: "assets/icons/logout.png",
                    title: "Logout",
                    onClick: ()async{
                      _showLogoutPopup();
                      // var data = {
                      //   "id" : userid,
                      //   "email" : email,
                      //   "isVerified" : isVerify,
                      //   "data" : "${DateTime.now()}",
                      //   "isLogin" : false,
                      // };
                      // AuthController.logout(data,context);
                    }
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildEditProfile(Size size) {
    return Container(
                 width: size.width,
                 padding: EdgeInsets.all(30),
                 height: 30.h,
                 decoration: BoxDecoration(
                     color: AppColors.white
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                       child: Image.asset("assets/images/profile.jpeg", height: 120, width: 120,),
                     ),
                     SizedBox(height: 20,),
                     Text("Edit Your Profile",
                       style: TextStyle(
                           fontSize: 15,
                           color: AppColors.textColor,
                           fontWeight: FontWeight.w600
                       ),
                     ),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.date_range, color: AppColors.mainColor,),
                         SizedBox(width: 10,),
                         Text("January 15",
                           style: TextStyle(
                               fontSize: 13,
                               color: AppColors.textColor,
                               fontWeight: FontWeight.w400
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
               );
  }

  Container buildProfileItems(
  {required String image, required String title, bool isTrailing = false, VoidCallback? onClick } ) {
    return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white
                  ),
                  child: ListTile(
                    onTap: onClick,
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 55, height: 55,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.blue.withOpacity(0.3)
                      ),
                      child: Image.asset("$image",
                        height: 20, width: 20,
                      ),
                    ),
                    title: Text("$title",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor
                      ),
                    ),
                    trailing: isTrailing ? InkWell(
                      child: Container(
                        width: 40.0,
                        margin: EdgeInsets.only(right: 20),
                        child: InkWell(
                          child: FlutterSwitch(
                            activeColor: AppColors.blue,
                            padding: 2,
                            width: 40.0,
                            height: 20.0,
                            valueFontSize: 5.0,
                            toggleSize: 15.0,
                            value: status,
                            borderRadius: 30.0,

                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                                if(status == false){
                                  AppSettings.openNotificationSettings();
                                }
                              });
                              print("click");
                            },
                          ),
                        ),
                      ),
                    ):SizedBox(),
                  ),
                );
  }

  bool isNotificationOn = false;
  void openNotificationSettings() async {
     print("click notification method");
   return await AwesomeNotifications().isNotificationAllowed().then(
            (isAllow)async{
          if(isAllow){
            setState(() {
              status = false;
            });

          }
          setState(() {
            status = true;
          });
        }
    );
  }

  Future<void> _showLogoutPopup() async {
     var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Center(
                  child: Image.asset("assets/images/logo.png", height: 80, width: 80,),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Text('Are you sure?',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(child: Text('Do you want to logout?')),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width*.25,
                      child: AppButton(
                          size: size,
                          child: Text("NO",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onClick: ()=>Navigator.pop(context)
                      ),
                    ),
                    SizedBox(
                      width: size.width*.25,
                      child: AppButton(
                          size: size,
                          child: Text("Yes",
                            style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w600,),
                          ),
                          onClick: ()=>_logout(),
                        bg: Colors.white,

                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

        );
      },
    );
  }

  void _logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
  }

}
