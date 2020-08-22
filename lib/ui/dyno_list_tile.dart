import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/network/models/dyno_formation.dart';
import 'package:heroku_dyno_utils/network/network_service.dart';
import 'package:heroku_dyno_utils/utils/flushbar_util.dart';

class DynoListTile extends StatefulWidget {
  final String appName;
  final DynoFormation dyno;
  const DynoListTile(this.appName, this.dyno);

  @override
  _DynoListTileState createState() => _DynoListTileState();
}

class _DynoListTileState extends State<DynoListTile> {
  bool switchVal = false;

  @override
  void initState() {
    super.initState();
    setState(() => switchVal = widget.dyno.quantity == 1);
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: switchVal,
      onChanged: (val) {
        updateState(widget.appName, widget.dyno.type, val ? 1 : 0);
      },
      title: Text("Size : ${widget.dyno.size} Type : ${widget.dyno.type}"),
      subtitle: Text(widget.dyno.command),
    );
  }

  void updateState(String appName, String dynoType, int val) {
    NetworkService.updateDynoStatus(appName, dynoType, val).then((value) {
      if (value) {
        showMsg(context, "Dyno ${val == 1 ? 'started' : 'stopped'}");
        setState(() => switchVal = val == 1 ? true : false);
      } else {
        showMsg(context, "Error Occured");
        setState(() => switchVal = val == 1 ? false : true);
      }
    }).catchError((e) {
      showMsg(context, e.toString() + "Error");
    });
  }
}
