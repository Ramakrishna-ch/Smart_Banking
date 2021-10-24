import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import '../drawpage.dart';
import '../../rest/login.dart';
import './registerpage.dart';
import 'package:provider/provider.dart';

class StartUpScreen extends StatefulWidget {
  static const routename = '/startup';
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  static const routename = '/loginpage';
  final _form = GlobalKey<FormState>();

  final loginDat = {'userid': '', 'password': ''};
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Colors.indigo[50],
      Colors.indigo[100],
      Colors.indigo[200],
      Colors.indigo[300],
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  Widget position(
      double left, double right, double top, double bottom, Widget child) {
    return Positioned(
      child: child,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }

  Future<void> validatedat(
      Function check1, BuildContext context, Function check2) async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    try {
      await check1(loginDat);
      print('login successful');
      await _showToast1(context, 'Save password', loginDat, check2);
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

  Future<void> _showToast1(BuildContext context, String message,
      Map<String, String> id, Function check1) async {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('Save Password'),
          actions: [
            TextButton(
              child: Text('YES'),
              onPressed: () async {
                try {
                  final responseDat = await check1(id);
                  _showToast(context, responseDat);
                  Navigator.of(context1).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                } catch (e) {
                  print(e);
                  Navigator.of(context1).pop();
                }
              },
            ),
            TextButton(
                child: Text('NO'),
                onPressed: () async {
                  Navigator.of(context1).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                }),
          ],
        );
      },
    );
  }

  bool eyeval = true;

  @override
  Widget build(BuildContext context) {
    final dynamicHeight = MediaQuery.of(context).size.height;
    final dynamicWidth = MediaQuery.of(context).size.width;
    final logobj = Provider.of<Login>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: dynamicHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    // Colors.indigo[50],
                    // Colors.indigo[100],
                    // Colors.indigo[200],
                    // Colors.indigo[300],
                    Colors.blue[50],
                    Colors.blue[100],
                    // Colors.blue[200],
                  ],
                ),
              ),
            ),
            position(
              0,
              null,
              50,
              10,
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                width: dynamicWidth * 0.9,
                height: dynamicHeight,
              ),
            ),
            position(
              15,
              null,
              100,
              null,
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                        width: dynamicWidth * 0.78,
                        height: dynamicWidth * 0.55,
                        // color: Colors.amber,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          image: DecorationImage(
                            image: AssetImage('images/bank.png'),
                            fit: BoxFit.fitWidth,
                          ),
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.hardEdge),
                    Container(
                      width: dynamicWidth * 0.8,
                      padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 10),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 10, top: 1),
                                    child: Icon(
                                      Icons.account_circle,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Email or phone',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black45),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black45),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Provide emailid or number';
                                        } else if (value
                                                .contains(RegExp(r'[0-9]')) &&
                                            value.length != 10 &&
                                            !value.contains('@')) {
                                          return 'Invalid number';
                                        } else if (value.length == 10 &&
                                            value.contains(RegExp(r'[0-9]'))) {
                                          loginDat['userid'] = value;
                                          return null;
                                        } else if (!value.contains('@') ||
                                            !value.contains(RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                          return 'Invalid email';
                                        }
                                        loginDat['userid'] = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 1,
                                      right: 10,
                                    ),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      obscureText: eyeval,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black45),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black45),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter password';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        loginDat['password'] = value;
                                      },
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  !eyeval
                                      ? IconButton(
                                          icon: Icon(Icons.visibility_outlined),
                                          onPressed: () {
                                            setState(() {
                                              eyeval = !eyeval;
                                            });
                                          })
                                      : IconButton(
                                          icon: Icon(
                                            Icons.visibility_off_outlined,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              eyeval = !eyeval;
                                            });
                                          }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 180,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue[100],
                                    Colors.blue[100],
                                  ],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => validatedat(logobj.loginuser,
                                    context, logobj.timeupdate),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Color.fromRGBO(21, 101, 192, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            TextButton(
                                child: Text('Forgot password?'),
                                onPressed: () {}),
                            SizedBox(
                              height: 135,
                            ),
                            Text(
                              'New User? Register Now',
                              style: TextStyle(
                                  foreground: Paint()..shader = linearGradient),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            position(
              null,
              dynamicWidth * .1,
              null,
              50,
              Arc(
                edge: Edge.LEFT,
                height: dynamicHeight * 0.16 * 0.5,
                arcType: ArcType.CONVEX,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blue[100],
                        Colors.blue[100],
                      ],
                    ),
                  ),
                  width: dynamicHeight * 0.16 * 0.5,
                  height: dynamicHeight * 0.16,
                ),
              ),
            ),
            position(
              null,
              dynamicWidth * .05,
              null,
              82,
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.routeName);
                },
                foregroundColor: Color.fromRGBO(21, 101, 192, 1),
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ),
            position(
              35,
              null,
              50,
              20,
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  child: Text(" S L R BANK  🏦",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          // fontFamily: "AvenirNext",
                          fontStyle: FontStyle.normal,
                          fontSize: 30)),
                  padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
