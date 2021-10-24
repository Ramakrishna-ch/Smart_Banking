import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import '../screens/forms/user_services_list_screen.dart';
import '../widgets/main_drawer.dart';
import '../screens/authentication/startup_screen.dart';
import '../rest/login.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/auth-screen';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Login logobj = Login();
  var initname = '';
  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showToast1(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure?'),
          actions: [
            TextButton(
              child: Text('YES'),
              onPressed: () async {
                try {
                  final result = await logobj.logout(id);
                  if (result == '8') {
                    Navigator.of(context1).pop();
                    _showToast(context, 'Logout Successful');
                    Navigator.of(context)
                        .pushReplacementNamed(StartUpScreen.routename);
                  } else if (result == '9') {
                    _showToast(context, 'Logout Unsuccessfull');
                  }
                } catch (e) {
                  print(e);
                  _showToast(context, e);
                  Navigator.of(context1).pop();
                }
              },
            ),
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context1).pop();
              },
            ),
          ],
        );
      },
    );
  }

  FSBStatus drawerStatus;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xff99ccff),
      Color(0xffb3d9ff),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  bool isinit = true;

  @override
  void didChangeDependencies() {
    if (isinit) {
      initname = Provider.of<Login>(context).userdat['name'];
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    var id = Provider.of<Login>(context).userid;
    var name = Provider.of<Login>(context).userdat;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Center(
          child: Text(
            ' SLR  BANK   ',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 22),
          ),
        ),
        // backgroundColor: Color.fromRGBO(116, 235, 213, 1),
        leading: IconButton(
          color: Color.fromRGBO(135, 73, 214, 1),
          onPressed: () {
            setState(() {
              drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                  ? FSBStatus.FSB_CLOSE
                  : FSBStatus.FSB_OPEN;
            });
          },
          icon: Icon(Icons.menu, color: Colors.black87),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black87,
              ),
              onPressed: () => _showToast1(context, id)),
        ],
      ),
      body: FoldableSidebarBuilder(
        drawerBackgroundColor: Colors.white,
        drawer: CustomDrawer(
          closeDrawer: () {
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },
        ),
        screenContents: BodyWidget(screenwt: screenwt),
        status: drawerStatus,
      ),
    );
  }
}

// BodyWidget(screenwt: screenwt),

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
    @required this.screenwt,
  }) : super(key: key);

  final double screenwt;

  @override
  Widget build(BuildContext context) {
    var name = Provider.of<Login>(context).userdat['name'];

    String assetElectricity = 'images/electricity.svg';
    String assetRecharge = 'images/recharge.svg';
    String assetSchoolFees = 'images/schoolfees.svg';
    String assetMovie = 'images/popcorn.svg';
    String assetBus = 'images/bus.svg';
    String assetTrain = 'images/train.svg';
    String assetFlight = 'images/airplane.svg';
    String assetRelief = 'images/relief.svg';
    String assetUPI = 'images/upi.svg';
    String assetQR = 'images/qr_code.svg';
    String assetBalance = 'images/balance.svg';
    String assetTransactions = 'images/transactions.svg';
    String assetLoan = 'images/loan.svg';

    Widget imagecarousel = Container(
      height: 180.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.network(
            "https://cdn.pixabay.com/photo/2017/08/07/19/45/ecommerce-2607114_640.jpg",
            height: 150.0,
            fit: BoxFit.fitWidth,
          ),
          Image.network(
            "https://cdn.pixabay.com/photo/2017/08/07/19/45/ecommerce-2607114_640.jpg",
            height: 150.0,
            fit: BoxFit.fitWidth,
          ),
          Image.network(
            "https://cdn.pixabay.com/photo/2017/08/07/19/45/ecommerce-2607114_640.jpg",
            height: 150.0,
            fit: BoxFit.fitWidth,
          ),
          Image.network(
            "https://cdn.pixabay.com/photo/2017/08/07/19/45/ecommerce-2607114_640.jpg",
            height: 150.0,
            fit: BoxFit.fitWidth,
          ),
          // AssetImage('assets/images/m2.jpg'),
        ],
        autoplay: true,
        autoplayDuration: Duration(seconds: 3),
        dotBgColor: Colors.transparent,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 5,
            ),
            Card(
                elevation: 5,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: imagecarousel),
            SizedBox(
              height: 10,
            ),
            /////////////////////////////////////
            ///
            ///
            Container(
              height: 100,
              padding: EdgeInsets.fromLTRB(5, 0, 16, 0),
              color: Color(0xff1873e8),
              child: ListView(
                // This next line does the trick.
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 26,
                            minRadius: 26,
                            backgroundColor: Color(0xFF0a4fa8),
                            child: SvgPicture.asset(
                              assetUPI,
                              semanticsLabel: 'Logo',
                              width: 22,
                              height: 22,
                            )),
                        Padding(
                          child: Text("UPI",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "AvenirNext",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10)),
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 26,
                            minRadius: 26,
                            backgroundColor: Color(0xFF0a4fa8),
                            child: SvgPicture.asset(
                              assetQR,
                              color: Color(0xddffffff),
                              semanticsLabel: 'Logo',
                              width: 22,
                              height: 22,
                            )),
                        Padding(
                          child: Text("Scan",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "AvenirNext",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10)),
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 26,
                            minRadius: 26,
                            backgroundColor: Color(0xFF0a4fa8),
                            child: SvgPicture.asset(
                              assetBalance,
                              color: Color(0xddffffff),
                              semanticsLabel: 'Logo',
                              width: 22,
                              height: 22,
                            )),
                        Padding(
                          child: Text("Balance",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "AvenirNext",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10)),
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 26,
                            minRadius: 26,
                            backgroundColor: Color(0xFF0a4fa8),
                            child: SvgPicture.asset(
                              assetTransactions,
                              semanticsLabel: 'Logo',
                              color: Color(0xddffffff),
                              width: 22,
                              height: 22,
                            )),
                        Padding(
                          child: Text("Transactions",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "AvenirNext",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10)),
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 26,
                            minRadius: 26,
                            backgroundColor: Color(0xFF0a4fa8),
                            child: SvgPicture.asset(
                              assetLoan,
                              semanticsLabel: 'Logo',
                              color: Color(0xddffffff),
                              width: 22,
                              height: 22,
                            )),
                        Padding(
                          child: Text("Quick Loan",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "AvenirNext",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10)),
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///
            ////////////////////////////
            SizedBox(
              height: 10,
            ),
            /////////////////////////////////////////////////////////////////////////

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                child: Text(" QUICK PAYMENT",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontFamily: "AvenirNext",
                        fontStyle: FontStyle.normal,
                        fontSize: 16)),
                padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
              ),
            ),
            Padding(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetElectricity,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Electricity",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetRecharge,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Recharge",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetSchoolFees,
                                    semanticsLabel: 'Logo',
                                    width: 18,
                                    height: 18,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("School Fees",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetMovie,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Movie",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetBus,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Bus",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetFlight,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Flight",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetTrain,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Train",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: new CircleAvatar(
                                  maxRadius: 28,
                                  minRadius: 28,
                                  child: SvgPicture.asset(
                                    assetRelief,
                                    semanticsLabel: 'Logo',
                                    width: 24,
                                    height: 24,
                                  ),
                                  backgroundColor: Colors.white),
                              padding: const EdgeInsets.all(1.0), // borde width
                              decoration: new BoxDecoration(
                                color: const Color(0x231873e8), // border color
                                shape: BoxShape.circle,
                              )),
                          Flexible(
                            child: Padding(
                              child: Text("Kerala Relief",
                                  style: const TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "AvenirNext",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              padding: EdgeInsets.fromLTRB(22, 8, 22, 8),
            ),
            ////////////////////////////////////////////////////////
            ///
            ///
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                child: Text(" SERVICES ",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        // fontFamily: "AvenirNext",
                        fontStyle: FontStyle.normal,
                        fontSize: 16)),
                padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
              ),
            ),

            ///////////////////////////////////
            ///

            ///
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, User_services_list_screen.routeName);
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.assignment_outlined,
                        size: 32.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    Flexible(
                      child: Padding(
                        child: Text("Fill Form",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 12)),
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                      ),
                    )
                  ],
                ),
                //////////
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {
                        //
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.wallet_membership_sharp,
                        size: 32.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    Flexible(
                      child: Padding(
                        child: Text("MemberShip Form",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 12)),
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
