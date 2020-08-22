import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/network/models/config_var.dart';
import 'package:heroku_dyno_utils/network/network_service.dart';
import 'package:heroku_dyno_utils/ui/config_list_tile.dart';
import 'package:heroku_dyno_utils/ui/loading_widget.dart';

class ConfigVarExpansionTile extends StatefulWidget {
  final String appName;

  const ConfigVarExpansionTile(this.appName);

  @override
  _ConfigVarExpansionTileState createState() => _ConfigVarExpansionTileState();
}

class _ConfigVarExpansionTileState extends State<ConfigVarExpansionTile> {
  Future<List<ConfigVar>> configVars;

  @override
  void initState() {
    super.initState();
    configVars = NetworkService.getConfigVars(widget.appName);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Config Vars"),
      children: [
        FutureBuilder(
          future: configVars,
          builder:
              (BuildContext context, AsyncSnapshot<List<ConfigVar>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length + 1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    if (i >= snapshot.data.length) {
                      return ConfigListTile(
                        widget.appName,
                        "New Config Var key",
                        "New Config Var Value",
                        onDelete: () {
                          configVars = null;
                          configVars =
                              NetworkService.getConfigVars(widget.appName);
                          setState(() {});
                        },
                        editMode: true,
                      );
                    }
                    final ConfigVar configVar = snapshot.data[i];
                    return ConfigListTile(
                      widget.appName,
                      configVar.configKey,
                      configVar.value.toString(),
                      onDelete: () {
                        snapshot.data.remove(snapshot.data[i]);
                        configVars = null;
                        configVars =
                            NetworkService.getConfigVars(widget.appName);
                        setState(() {});
                      },
                    );
                  },
                  separatorBuilder: (context, i) => const Divider(),
                );
              }
            }
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
            }
            return const LoadingWidget();
          },
        ),
      ],
    );
  }

  Widget buildAddConfigVar() {
    return ListTile();
  }
}
