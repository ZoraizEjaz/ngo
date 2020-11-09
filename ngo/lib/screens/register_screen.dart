import 'dart:ffi';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../models/register_request_model.dart';
import '../models/genderModel.dart';
import '../widgets/custom_radio.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {

  final myController = TextEditingController();

  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _cityFocus = FocusNode();

  final _form = GlobalKey<FormState>();
  DateTime _selectDate = DateTime.now();
  String _date = "Not set";

  List<Gender> genders = new List<Gender>();

  var _registerRequest = RegisterRequestModel(
      name: '',
      email: '',
      address: '',
      phonenumber: '',
      city: '',
      dob: '',
      gender: '',
      password: '');
  var _initValues = {
    'name': '',
    'email': '',
    'address': '',
    'phonenumber': '',
    'city': '',
    'dob': '',
    'gender': '',
    'password': '',
  };

  _RegisterScreenState(){
    // Set the text property to a value to be displayed
    myController.text = 'initial Value';
  }

  @override
  void initState() {
    genders.add(new Gender("Male", MdiIcons.genderMale, false));
    genders.add(new Gender("Female", MdiIcons.genderFemale, false));
    genders.add(new Gender("Others", MdiIcons.genderTransgender, false));
    myController.addListener(_printLatestValue);
    super.initState();
  }

  _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _addressFocus.dispose();
    _phoneNumberFocus.dispose();
    _passwordFocus.dispose();
    myController.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000,1),
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2004));
    if (picked != null && picked != _selectDate)
      setState(() {
        _selectDate = picked;
        _date = '${picked.year} - ${picked.month} - ${picked.day}';
      });
  }

  Widget addHeightSpace25(){
    return SizedBox(height: 25.0);
  }

  Widget addHeightSpace10(){
    return SizedBox(height: 10.0);
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    if(_date.startsWith('Not')){
     showToast("Please select date!");
    }

    print(getSelectedGender());
    if(getSelectedGender()==null){
      showToast("Please select gender!");
    }

    _form.currentState.save();

    print(_registerRequest.email);

    //setState(() {});
  }

  void showToast(String msg){

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

  String getSelectedGender(){
    var val= "";
    for(int i=0 ; i < genders.length; i++){
      if(genders[i].isSelected){
        val = genders[i].name;
        break;
      }
    }

    if(val.isEmpty){
      return null;
    }else{
      return val;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['name'],
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _initValues['name'] = 'zoraiz';
                      _registerRequest = RegisterRequestModel(
                        name: value,
                        email: _registerRequest.email,
                        address: _registerRequest.address,
                        phonenumber: _registerRequest.phonenumber,
                        city: _registerRequest.city,
                        dob: _registerRequest.dob,
                        gender: _registerRequest.gender,
                        password: _registerRequest.password,
                      );
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['email'],
                    focusNode: _emailFocus,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email address!';
                      }

                      if (!(validateEmail(value))) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _registerRequest = RegisterRequestModel(
                        name: _registerRequest.name,
                        email: value,
                        address: _registerRequest.address,
                        phonenumber: _registerRequest.phonenumber,
                        city: _registerRequest.city,
                        dob: _registerRequest.dob,
                        gender: _registerRequest.gender,
                        password: _registerRequest.password,
                      );
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_addressFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['address'],
                    focusNode: _addressFocus,
                    decoration: InputDecoration(labelText: 'Address'),
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter address!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _registerRequest = RegisterRequestModel(
                        name: _registerRequest.name,
                        email: _registerRequest.email,
                        address: value,
                        phonenumber: _registerRequest.phonenumber,
                        city: _registerRequest.city,
                        dob: _registerRequest.dob,
                        gender: _registerRequest.gender,
                        password: _registerRequest.password,
                      );
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phoneNumberFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['phonenumber'],
                    focusNode: _phoneNumberFocus,
                    decoration: InputDecoration(labelText: 'PhoneNumber'),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      if(value.length < 12){
                        return 'Incorrect phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _registerRequest = RegisterRequestModel(
                        name: _registerRequest.name,
                        email: _registerRequest.email,
                        address: _registerRequest.address,
                        phonenumber: value,
                        city: _registerRequest.city,
                        dob: _registerRequest.dob,
                        gender: _registerRequest.gender,
                        password: _registerRequest.password,
                      );
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_cityFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['city'],
                    focusNode: _cityFocus,
                    decoration: InputDecoration(labelText: 'City'),
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter city';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _registerRequest = RegisterRequestModel(
                        name: _registerRequest.name,
                        email: _registerRequest.email,
                        address: _registerRequest.address,
                        phonenumber: _registerRequest.phonenumber,
                        city: value,
                        dob: _registerRequest.dob,
                        gender: _registerRequest.gender,
                        password: _registerRequest.password,
                      );
                    },

                  ),
                  addHeightSpace25(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  addHeightSpace10(),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black45,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      selectDate(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      " $_date",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  Change",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  addHeightSpace25(),
                  Text(
                    'Select Gender',
                    style: TextStyle(color: Colors.black54),
                  ),
                  addHeightSpace10(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 86,
                            child:  ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                itemCount: genders.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashColor: Colors.pinkAccent,
                                    onTap: () {
                                      setState(() {
                                        genders
                                            .forEach((gender) => gender.isSelected = false);
                                        genders[index].isSelected = true;
                                      });
                                    },
                                    child: CustomRadio(genders[index]),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _initValues['password'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password must be at-least 6 characters';
                      }
                      if (value.length < 6) {
                        return 'Password must be at-least 6 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      _registerRequest = RegisterRequestModel(
                        name: _registerRequest.name,
                        email: _registerRequest.email,
                        address: _registerRequest.address,
                        phonenumber: _registerRequest.phonenumber,
                        city: _registerRequest.city,
                        dob: _registerRequest.dob,
                        gender: _registerRequest.gender,
                        password: value,
                      );
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 45,
                    width: 350,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        _saveForm();
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("SIGN UP".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 2, 0),
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.black38, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 2, 0),
                            child: Text(
                              'SignIn',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
