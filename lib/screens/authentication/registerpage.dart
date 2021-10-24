import 'package:flutter/material.dart';
import './startup_screen.dart';
import 'dart:ui';
import '../../rest/signup.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/registerpage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<String> _gender = ['Male', 'Female', 'Others'];
  final _form = GlobalKey<FormState>();
  final edituserdetails = {
    'name': '',
    'userid': '',
    'account_no': '',
    'contact': '',
    'password': '',
    'cfnpass': '',
    'gender': 'Male',
    'address': '',
  };

  Signup regobj = Signup();
  Future<void> _submit(BuildContext context, Function check2) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    try {
      final response = await check2(edituserdetails);
      _showToast(context, response);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      _showToast(context, e);
      return;
    }
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget textfield(
      String label, TextInputType keyname, Function validate, Function saved) {
    return TextFormField(
      cursorColor: Colors.indigo,
      style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: label,
        errorStyle: TextStyle(color: Colors.red[100]),
        hintStyle: TextStyle(color: Colors.indigo),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
        ),
      ),
      keyboardType: keyname,
      validator: validate,
      onSaved: saved,
    );
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Colors.indigo[100],
      Colors.indigo[300],
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: screenht,
          width: screenwt,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[50],
                Colors.blue[50],
                Colors.blue[100],
                Colors.blue[100],
                // Colors.indigo[100],
                // Colors.indigo[200],
                // Colors.indigo[300],
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: screenwt * 0.3,
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black45, width: 1),
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3.0,
                    child: Text(
                      ' SignUp ',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  // width: screenwt * 0.9,
                  height: screenht * 0.23,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    image: DecorationImage(
                      image: AssetImage('images/register.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    // shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: screenht * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          children: <Widget>[
                            textfield(
                              'Name',
                              TextInputType.name,
                              (value) {
                                if (value.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              (value) {
                                edituserdetails['name'] = value;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            textfield('Email or Phone number',
                                TextInputType.emailAddress, (value) {
                              if (value.isEmpty) {
                                return 'Provide emailid or number';
                              } else if (value.contains(RegExp(r'[0-9]')) &&
                                  value.length != 10 &&
                                  !value.contains('@')) {
                                return 'Invalid number';
                              } else if (value.length == 10 &&
                                  value.contains(RegExp(r'[0-9]'))) {
                                edituserdetails['userid'] = value;
                                return null;
                              } else if (!value.contains('@') ||
                                  !value.contains(RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                return 'Invalid email';
                              }
                              edituserdetails['userid'] = value;
                              return null;
                            }, null),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                                'Bank Account Number', TextInputType.phone,
                                (value) {
                              if (value.isEmpty) {
                                return 'Number cannot be empty';
                              } else if (!value.contains(RegExp(r'[0-9]')) ||
                                  value.length <= 7) {
                                return 'Invalid number';
                              }
                              edituserdetails['account_no'] = value;
                              return null;
                            }, null),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                                'Phone or Contact number', TextInputType.phone,
                                (value) {
                              if (value.isEmpty) {
                                return 'Number cannot be empty';
                              } else if (!value.contains(RegExp(r'[0-9]')) ||
                                  value.length != 9) {
                                return 'Invalid number';
                              }
                              edituserdetails['contact'] = value;
                              return null;
                            }, null),
                            SizedBox(height: 40),
                            textfield('password', TextInputType.visiblePassword,
                                (value) {
                              if (value.isEmpty) {
                                return 'Provide password';
                              } else if (!value.contains(RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                return 'Invalid Password';
                              }
                              edituserdetails['password'] = value;
                              return null;
                            }, null),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                              'confirm password',
                              TextInputType.visiblePassword,
                              (value) {
                                if (value.isEmpty) {
                                  return 'Please re-enter password';
                                } else if (!value.contains(RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                  return 'Invalid Password';
                                } else if (edituserdetails['password'] !=
                                    value) {
                                  return 'Password doestn\'t match';
                                }
                                return null;
                              },
                              (value) {
                                edituserdetails['cfnpass'] = value;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            textfield(
                              'Address',
                              TextInputType.name,
                              (value) {
                                if (value.isEmpty) {
                                  return 'Address cannot be empty';
                                }
                                return null;
                              },
                              (value) {
                                edituserdetails['address'] = value;
                              },
                            ),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Text(
                                  'Gender:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                    ),
                                    items: _gender
                                        .map<DropdownMenuItem<String>>(
                                            (String index) {
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            index,
                                            style: TextStyle(
                                                foreground: Paint()
                                                  ..shader = linearGradient),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: edituserdetails['gender'],
                                    onChanged: (String value) {
                                      setState(() {
                                        edituserdetails['gender'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              // Spacer(),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () => _submit(context, regobj.signupuser),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'Already Registered? Login',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
