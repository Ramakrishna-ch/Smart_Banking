import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../rest/login.dart';
import '../../rest/my_services.dart';

class Modify_userDetails extends StatefulWidget {
  static const routename = '/modify-new-request';

  @override
  State<Modify_userDetails> createState() => _Modify_userDetailsState();
}

class _Modify_userDetailsState extends State<Modify_userDetails> {
  final _form = GlobalKey<FormState>();

  Map<String, String> form_data = {
    'account_no': '',
    'name': '',
    'phone': '',
    'address': '',
    'ref_name': '',
  };

  bool isinit = true;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromRGBO(67, 206, 162, 1),
      Color.fromRGBO(24, 90, 157, 1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void didChangeDependencies() {
    if (isinit) {
      final _editedUserDetails = Provider.of<Login>(context).userdat;
      form_data['account_no'] = _editedUserDetails['account_no'];
      form_data['name'] = _editedUserDetails['name'];
      form_data['phone'] = _editedUserDetails['phone'];
      form_data['address'] = _editedUserDetails['address'];
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit(BuildContext context, Function check2) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    try {
      await check2(form_data);
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

  Widget textfield(String initname, bool auth, String label,
      TextInputType keyname, Function validate, Function saved) {
    return TextFormField(
      cursorColor: Colors.white,
      initialValue: form_data[initname],
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black54,
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: keyname,
      validator: validate,
      onSaved: saved,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.blue[100],
        title: Text('Modify Account details'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        height: screenht,
        width: screenwt,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue[200],
              Colors.blue[100],
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: screenht * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white70,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          textfield(
                            'account_no',
                            false,
                            'Account No',
                            TextInputType.phone,
                            (value) {
                              if (value.isEmpty) {
                                return 'Account No cannot be empty';
                              }
                              return null;
                            },
                            (value) {
                              form_data = {
                                'account_no': value,
                                'name': form_data['name'],
                                'phone': form_data['phone'],
                                'address': form_data['address'],
                                'ref_name': form_data['ref_name']
                              };
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textfield(
                            'name',
                            false,
                            'Name',
                            TextInputType.name,
                            (value) {
                              if (value.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              return null;
                            },
                            (value) {
                              form_data = {
                                'account_no': form_data['account_no'],
                                'name': value,
                                'phone': form_data['phone'],
                                'address': form_data['address'],
                                'ref_name': form_data['ref_name']
                              };
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textfield('phone', false, 'Phone Number',
                              TextInputType.phone, (value) {
                            if (value.isEmpty) {
                              return 'phone no cannot be empty';
                            } else if (!value.contains(RegExp(r'[0-9]')) ||
                                value.length != 9) {
                              return 'Invalid amount';
                            }
                            form_data = {
                              'account_no': form_data['account_no'],
                              'name': form_data['name'],
                              'phone': value,
                              'address': form_data['address'],
                              'ref_name': form_data['ref_name']
                            };
                            return null;
                          }, null),
                          SizedBox(height: 40),
                          textfield(
                            'address',
                            false,
                            'Address',
                            TextInputType.name,
                            (value) {
                              if (value.isEmpty) {
                                return 'Address cannot be empty';
                              }
                              return null;
                            },
                            (value) {
                              form_data = {
                                'account_no': form_data['account_no'],
                                'name': form_data['name'],
                                'phone': form_data['phone'],
                                'address': value,
                                'ref_name': form_data['ref_name']
                              };
                            },
                          ),
                          SizedBox(height: 40),
                          textfield(
                            'ref_name',
                            false,
                            'Reference name',
                            TextInputType.name,
                            (value) {
                              if (value.isEmpty) {
                                return 'Reference name cannot be empty';
                              }
                              return null;
                            },
                            (value) {
                              form_data = {
                                'account_no': form_data['account_no'],
                                'name': form_data['name'],
                                'phone': form_data['phone'],
                                'address': form_data['address'],
                                'ref_name': value
                              };
                            },
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
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () => _submit(
                      context,
                      Provider.of<My_Services>(context, listen: false)
                          .insert_user_form_data),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 122, 193, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
