import 'package:flutter/material.dart';
import '../../rest/my_services.dart';
import 'package:provider/provider.dart';
import '../../rest/login.dart';

class Add_New_Request extends StatefulWidget {
  static const routename = '/add-new-request';
  @override
  _Add_New_RequestState createState() => _Add_New_RequestState();
}

class _Add_New_RequestState extends State<Add_New_Request> {
  final _form = GlobalKey<FormState>();

  My_Services User_dat_obj = new My_Services();

  List<String> types = ['Withdraw', 'Deposit'];
  Map<String, String> form_data = {
    'account_no': '',
    'type': 'Deposit',
    'amount': '',
    'status': 'Pending',
    'reference_name': ''
  };

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromRGBO(67, 206, 162, 1),
      Color.fromRGBO(24, 90, 157, 1),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  Widget textfield(String initname, bool auth, String label,
      TextInputType keyname, Function validate, Function saved) {
    return TextFormField(
      cursorColor: Colors.white,
      initialValue: initname == 'account_no' ? form_data[initname] : null,
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

  bool isinit = true;

  @override
  void didChangeDependencies() {
    if (isinit) {
      final _editedUserDetails = Provider.of<Login>(context).userdat;
      form_data['account_no'] = _editedUserDetails['account_no'];
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.blue[100],
        title: Text('Transaction Form'),
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
                                'type': form_data['type'],
                                'amount': form_data['amount'],
                                'status': form_data['status'],
                                'reference_name': form_data['reference_name'],
                              };
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text(
                                'Type:',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 21),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white,
                                  ),
                                  items: types.map<DropdownMenuItem<String>>(
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
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: form_data['type'],
                                  onChanged: (String value) {
                                    setState(() {
                                      form_data = {
                                        'account_no': form_data['account_no'],
                                        'type': value,
                                        'amount': form_data['amount'],
                                        'status': form_data['status'],
                                        'reference_name':
                                            form_data['reference_name'],
                                      };
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textfield('Amount', false, 'Transaction Amount',
                              TextInputType.phone, (value) {
                            if (value.isEmpty) {
                              return 'Amount cannot be empty';
                            } else if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Invalid amount';
                            }
                            form_data = {
                              'account_no': form_data['account_no'],
                              'type': form_data['type'],
                              'amount': value,
                              'status': form_data['status'],
                              'reference_name': form_data['reference_name'],
                            };
                            return null;
                          }, null),
                          SizedBox(height: 40),
                          textfield(
                            'reference_name',
                            false,
                            'Reference Name',
                            TextInputType.name,
                            (value) {
                              if (value.isEmpty) {
                                return 'Reference Name cannot be empty';
                              }
                              return null;
                            },
                            (value) {
                              form_data = {
                                'account_no': form_data['account_no'],
                                'type': form_data['type'],
                                'amount': form_data['amount'],
                                'status': form_data['status'],
                                'reference_name': value,
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
                          .insert_new_form_data),
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
