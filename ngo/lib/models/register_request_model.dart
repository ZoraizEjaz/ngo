import 'package:flutter/material.dart';

class RegisterRequestModel{
   String name;
   String email;
   String address;
   String phonenumber;
   String city;
   String dob;
   String gender;
   String password;

  RegisterRequestModel({this.name, this.email, this.address,
      this.phonenumber, this.city, this.dob, this.gender, this.password});

   void setName(String value) {
     name = value;
   }

  void setEmail(value) {
    email = value;
  }

  void setPassword(value) {
    password = value;
  }

  void setGender(value) {
    gender = value;
  }

  void setdob(value) {
    this.dob = value;
  }

  void setcity(value) {
    this.city = value;
  }

  void setphonenumber(value) {
    this.phonenumber = value;
  }

  void setaddress(value) {
    this.address = value;
  }

  String getName(){
     return this.name;
  }

  String getEmail(){
     return this.email;
  }

  String getAddress(){
     return this.address;
  }

  String getPhoneNumber(){
     return this.phonenumber;
  }

  String getCity(){
     return this.city;
  }

  String getDob(){
     return this.dob;
  }

  String getGender(){
     return this.gender;
  }

  String getPassword(){
     return this.password;
  }

}