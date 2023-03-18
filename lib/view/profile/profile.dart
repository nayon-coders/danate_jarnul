import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '../../utility/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool status = false;

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
              onPressed: (){},
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
            //profile image section
            Container(
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
                    child: Image.network("https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg", height: 120, width: 120,),
                  ),
                  SizedBox(height: 20,),
                  Text("Nayon Talukder",
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
            ),

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
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildProfileItems({required String image, required String title, bool isTrailing = false }) {
    return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white
                  ),
                  child: ListTile(
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
                    trailing: isTrailing ? Container(
                      width: 40.0,
                      margin: EdgeInsets.only(right: 20),
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
                          });
                        },
                      ),
                    ):SizedBox(),
                  ),
                );
  }
}
