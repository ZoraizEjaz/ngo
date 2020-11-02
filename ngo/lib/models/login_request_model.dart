import 'package:flutter/material.dart';

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({this.email, this.password});

  void setEmail(String _email){
    this.email = _email;
  }

  void setPassword(String _password){
    this.password = _password;
  }

  String getEmail(){
    return this.email;
  }

  String getPassword(){
    return this.password;
  }
}