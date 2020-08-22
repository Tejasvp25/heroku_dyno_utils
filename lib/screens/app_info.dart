import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/network/models/dyno_formation.dart';
import 'package:heroku_dyno_utils/network/models/herokuapp.dart';
import 'package:heroku_dyno_utils/network/network_service.dart';
import 'package:heroku_dyno_utils/ui/config_var_expanstion_tile.dart';
import 'package:heroku_dyno_utils/ui/dynos_list_expansion_tile.dart';

class AppInfo extends StatefulWidget {
  final HerokuApp app;

  const AppInfo(this.app);
  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  List<DynoFormation> dynoList;
  String status = "-";
  bool dynosAvailable = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    NetworkService.getDynos(widget.app.name).then((value) {
      if (value.length > 0) {
        setState(() {
          status = value[0].state;
        });
      }
    });

    NetworkService.getDynosFormation(widget.app.name).then((value) {
      if (value.length > 0) {
        setState(() {
          dynosAvailable = true;
          dynoList = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app.name),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildText("App Name", widget.app.name),
          _buildText("Owner", widget.app.owner.email),
          _buildText("Status", status),
          dynosAvailable
              ? DynosListExpansionTile(widget.app.name, dynoList)
              : Container(),
          _buildText("Build Stack", widget.app.buildStack.name),
          _buildText("Created at", widget.app.createdAt),
          _buildText("ID", widget.app.id),
          _buildText(
            "Maintainance Mode",
            widget.app.maintenance.toString(),
          ),
          ConfigVarExpansionTile(widget.app.name),
        ],
      ),
    );
  }

  Widget _buildText(String header, String info) => ListTile(
        title: Text(header),
        subtitle: Text(info),
      );
}
