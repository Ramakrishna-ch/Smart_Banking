import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sms_test/screens/forms/newformtype.dart';
import 'package:sms_test/widgets/user_form_item.dart';
import 'add_user_services.dart';
import '../../widgets/my_form_item.dart';
import '../../rest/my_services.dart';
import 'package:provider/provider.dart';
import '../../rest/login.dart';

class User_services_list_screen extends StatefulWidget {
  static const routeName = '/User-services-list-screen';

  @override
  _User_services_list_screenState createState() =>
      _User_services_list_screenState();
}

class _User_services_list_screenState extends State<User_services_list_screen> {
  bool isinit = true;
  int n = 0;
  List<Map<String, String>> form_dat, userdata;
  Map<String, String> new_data;
  var accountno;
  @override
  void didChangeDependencies() async {
    if (isinit) {
      new_data = Provider.of<Login>(context).userdat;
      accountno = {'accountno': new_data['account_no']};
      await Provider.of<My_Services>(context, listen: false)
          .get_form_data(new_data);
      await Provider.of<My_Services>(context, listen: false)
          .get_userdetails_data(accountno);
      form_dat = Provider.of<My_Services>(context, listen: false).services_list;
      userdata = Provider.of<My_Services>(context, listen: false).details_list;
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> refresh_services() async {
    await Provider.of<My_Services>(context, listen: false)
        .get_form_data(new_data);
    await Provider.of<My_Services>(context, listen: false)
        .get_userdetails_data(accountno);
  }

  void _onItemTapped(int index) {
    setState(() {
      n = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    form_dat = Provider.of<My_Services>(context).services_list;
    userdata = Provider.of<My_Services>(context).details_list;

    AppBar appBar = AppBar(
      title: Text('My Services'),
      backgroundColor: Colors.blue[100],
      foregroundColor: Colors.black,
    );

    double formheight = ht - appBar.preferredSize.height * 2;

    BottomNavigationBar bottom = BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.clipboardTextSearch,
            ),
            label: 'Cash Forms'),
        BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.cardAccountDetails,
            ),
            label: 'Change Details'),
      ],
      currentIndex: n,
      onTap: _onItemTapped,
      selectedItemColor: Color.fromRGBO(93, 153, 198, 1),
    );

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottom,
      body: Container(
        height: ht,
        width: wt,
        child: Stack(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: refresh_services,
              child: n == 0
                  ? form_dat.length <= 0
                      ? SingleChildScrollView(
                          child: Container(
                            height: formheight,
                            width: wt,
                            child: Center(
                                child: Text('You\'ve not created any forms')),
                          ),
                        )
                      : ListView.builder(
                          itemCount: form_dat.length,
                          itemBuilder: (ctx, index) => MyFormItem(
                              form_dat[index]['form_name'],
                              form_dat[index]['request_type'],
                              form_dat[index]['transaction_amount'],
                              form_dat[index]['service_request_status'],
                              form_dat[index]['form_id']))
                  : userdata.length <= 0
                      ? SingleChildScrollView(
                          child: Container(
                            height: formheight,
                            width: wt,
                            child: Center(
                                child: Text('You\'ve not created any forms')),
                          ),
                        )
                      : ListView.builder(
                          itemCount: userdata.length,
                          itemBuilder: (ctx, index) => UserItem(
                              userdata[index]['name'],
                              userdata[index]['address'],
                              userdata[index]['phone'],
                              userdata[index]['status'],
                              userdata[index]['id'])),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(NewFormType.routename);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: Colors.blue[100],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.clipboardEditOutline,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Compose',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
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
