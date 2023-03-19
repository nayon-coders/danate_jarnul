import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocalDatabases{

  //user information database
  static var INITIAL_DATA = Hive.openBox<Map>('initial_Data');
  static var EMAIL_VERIFY = Hive.openBox<Map>('email_verify_bd');
  static var PROFILE = Hive.openBox<Map>('profile');
  static var ADMIRER_PROFILE = Hive.openBox<List>('admirer');


}