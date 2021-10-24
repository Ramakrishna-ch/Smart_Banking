import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:sms_test/screens/forms/add_user_services.dart';
import 'package:sms_test/screens/forms/modify_user_details.dart';

class NewFormType extends StatelessWidget {
  static const routename = '/newformtype';
  final List<String> form_items = ['Withdraw/Deposit', 'Details Update'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Form Type',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.black87,
      ),
      body: Container(
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        index == 0
                            ? Navigator.of(context)
                                .pushNamed(Add_New_Request.routename)
                            : Navigator.of(context)
                                .pushNamed(Modify_userDetails.routename);
                      },
                      child: Card(
                        color: Colors.blue[200],
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(form_items[index],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black87)),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 28,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))),
    );
  }
}
