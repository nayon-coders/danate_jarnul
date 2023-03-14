import 'dart:io';

import 'package:dante/utility/app_colors.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utility/app_button.dart';

class AddAdmirerProfile extends StatefulWidget {
  const AddAdmirerProfile({Key? key}) : super(key: key);

  @override
  State<AddAdmirerProfile> createState() => _AddAdmirerProfileState();
}

class _AddAdmirerProfileState extends State<AddAdmirerProfile> {

  //image picker global variable
  final ImagePicker _picker = ImagePicker(); // this is Come from Image Picker Livery
  //it help use to take images

  String dropdownValue = 'One';
  final List<String> items = [
    'Facebook',
    'Instagram',
    'YouTube',
    'Linkd In',
  ];
  String? selectedValue;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: ()=>Get.back(),
            icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,),
          ),
        ),
        // leading: Container(
        //   width: 40, height: 40,
        //   margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade200,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Center(child: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,)),
        // ),
        title: Text("Add Profile",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textColor
          ),
        )
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: size.width,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     color: AppColors.bgColor,
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 40, height: 40,
            //         padding: EdgeInsets.only(left: 12, right: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade200,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Center(child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
            //       ),
            //       SizedBox(width: size.width*.25,),
            //       Text("Add Profile",
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black
            //         ),
            //       ),
            //     ],
            //   ),
            // )

            //Upload profile image section
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: 130,
                   width: 130,
                  //padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child:  InkWell(
                    onTap: ()=>openBottomSheet(),
                    child: ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                        child: profileImage != null
                            ? Image.file(profileImage, height: 130, width: 130, fit: BoxFit.cover,)
                            :  Padding(
                                padding: EdgeInsets.all(40),
                                child: Image.asset("assets/icons/upload_images.png", height: 40, width: 40, )
                            )
                    ),
                  ),

                ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text("Add Profile Picture",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 160,
                //padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  InkWell(
                  onTap: ()=>openBottomSheet(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: profileImage != null
                          ? Image.file(profileImage, height: 130, width: 130, fit: BoxFit.cover,)
                          :  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text("Feature Photo",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                  ),
                ),

              ),
            ),

            SizedBox(height: 50,),

            Text("Date of Birth",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 15,),
            DOBInputField(
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              showLabel: true,
              dateFormatType: DateFormatType.DDMMYYYY,
              autovalidateMode: AutovalidateMode.always,
            ),

            SizedBox(height: 30,),

            Text("Zodiac Sign",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Choose Sign",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 30,),

            Text("Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter bio about the person...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 30,),

            Text("My Likes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter text here",

                  contentPadding: EdgeInsets.only( right: 10, top: 15, bottom: 15),
                  prefixIcon: Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.mainColor.withOpacity(0.6),
                    ),
                    child: Icon(Icons.add),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 30,),
            Text("My Dislikes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter text here",

                  contentPadding: EdgeInsets.only( right: 10, top: 15, bottom: 15),
                  prefixIcon: Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.blue.withOpacity(0.6),
                    ),
                    child: Icon(Icons.add),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 30,),

            Text("Social Media",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300
              ),
              child: Center(child: Text("Add social media link",style: TextStyle(color: AppColors.textColor),),),
            ),

            SizedBox(height: 30,),
            InkWell(
              onTap: ()=>_addSocialMedia(size),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.mainColor
                      ),
                      child: Icon(Icons.add, color: Colors.white,)),
                  SizedBox(width: 10,),
                  Text("Add Account",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                  )
                ],
              ),
            ),

            SizedBox(height: 30,),

            AppButton(
              onClick: (){},//rout the next login pages
              size: size,
              child: Text("Save Admirer",
                style: TextStyle(
                    fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height: 30,),





          ],
        ),
      ),
    );
  }




  //Open bottomsheet for select the method to upload images.
  Future openBottomSheet(){
   return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Gallery'),
                onTap: () {
                  uploadProfile(ImageSource.gallery); //it will take one parameter
                },
              ),

              ListTile(
                leading: new Icon(Icons.camera_alt_outlined),
                title: new Text('Camera'),
                onTap: () {
                  uploadProfile(ImageSource.camera); //it will take one parameter
                },
              ),
            ],
          );
        });
  }
  //Like Camera or Gallery


  // this is profile image store variable
  var profileImage, profileImageStr;
  //this method going take images and save local variable

  void uploadProfile(type) async{ // its take one parameter
    var image = await _picker.pickImage(source: type);
    setState(() {
      profileImage = File(image!.path); // store the image path in this local variable
      profileImageStr = image;
    });
    Navigator.pop(context); //when image taken, it will be close bottom sheets.
  }



  //this method show the popup for add social media
  Future _addSocialMedia(size) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              titlePadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

              actionsPadding: EdgeInsets.zero,
             // contentPadding: EdgeInsets.all(10),
              content: SingleChildScrollView(
                child: ListBody(
                  children:  <Widget>[

                    Text('Choose media',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: AppColors.blue
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.blue, width: 1)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text('Profifile link',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: AppColors.blue
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                          fillColor: Colors.white,
                          hintText: "Choose Sign",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  color: AppColors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:
                            AppColors.blue)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color:
                          AppColors.blue),
                        ),
                      ),
                    ),


                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          onClick: ()=>{}, //rout the next login pages
                          size: size*.25,
                          bg: Colors.grey.shade300,
                          child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 15, color:AppColors.textColor, fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        AppButton(
                          onClick: ()=>{}, //rout the next login pages
                          size: size*.25,
                          child: Text("Save",
                            style: TextStyle(
                                fontSize: 15, color:AppColors.white, fontWeight: FontWeight.w500
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10,),

                  ],
                ),
              ),

            );
          }
        );
      },
    );
  }


}
