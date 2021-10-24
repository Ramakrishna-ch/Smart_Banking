import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../rest/my_services.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserItem extends StatelessWidget {
  final String form_item_name;
  final String form_item_address;
  final String form_item_contact;
  final String form_item_status;
  final String form_item_id;

  UserItem(
      @required this.form_item_name,
      @required this.form_item_address,
      @required this.form_item_contact,
      @required this.form_item_status,
      @required this.form_item_id);

  Widget archiveIcon(double lefts, double rights, double tops) {
    return Positioned(
      left: lefts,
      top: tops,
      right: rights,
      child: Icon(
        Icons.archive_outlined,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(form_item_id),
        background: Stack(
          children: <Widget>[
            Container(
              color: Colors.blue[700],
            ),
            archiveIcon(20, 300, 24),
            archiveIcon(310, 27, 24),
          ],
        ),
        child: Card(
          child: Container(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      form_item_name.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(" Phone: " + form_item_contact),
                    Spacer(),
                    Text(
                      'Address: $form_item_address',
                      style: TextStyle(
                          color: Colors.black87, fontFamily: 'GoogleRegular'),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      form_item_status == 'Pending'
                          ? Icons.pending_sharp
                          : form_item_status == 'Accepted'
                              ? Icons.verified_rounded
                              : MdiIcons.closeCircleOutline,
                      size: 30,
                      color: form_item_status == 'Pending'
                          ? Colors.blueGrey
                          : form_item_status == 'Accepted'
                              ? Colors.green
                              : Colors.red,
                    ),
                    Flexible(
                      child: Padding(
                        child: Text(form_item_status,
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 12)),
                        padding: EdgeInsets.fromLTRB(0, 8, 8, 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
