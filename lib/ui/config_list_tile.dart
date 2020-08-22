import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/network/network_service.dart';
import 'package:heroku_dyno_utils/utils/flushbar_util.dart';

class ConfigListTile extends StatefulWidget {
  final String appName, configKey, value;

  /// bool [editMode] is declared in [ConfigListTile] and [ConfigListTileState] so we can use benefits of const Constructor
  final bool editMode;
  final Function onDelete;

  const ConfigListTile(this.appName, this.configKey, this.value,
      {this.onDelete, this.editMode = false});

  @override
  _ConfigListTileState createState() => _ConfigListTileState();
}

class _ConfigListTileState extends State<ConfigListTile> {
  final TextEditingController valueEditingController =
      TextEditingController(text: "");
  final TextEditingController keyEditingController =
      TextEditingController(text: "");

  bool editMode = false;

  @override
  void initState() {
    super.initState();
    valueEditingController.text = widget.value;
    keyEditingController.text = widget.configKey;
    setState(() => editMode = widget.editMode);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        controller: keyEditingController,
        enabled: editMode,
      ),
      subtitle: TextField(
        controller: valueEditingController,
        enabled: editMode,
      ),
      trailing: editMode
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => updateConfigVar(
                    keyEditingController.value.text == ""
                        ? widget.configKey
                        : keyEditingController.value.text,
                    valueEditingController.value.text == ""
                        ? null
                        : valueEditingController.value.text,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => editMode = false),
                )
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => setState(() => editMode = true),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => updateConfigVar(widget.configKey, null),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    valueEditingController.dispose();
    super.dispose();
  }

  void updateConfigVar(String newKey, String newValue) {
    showMsg(context, "Making Request to Sever");
    setState(() => editMode = false);
    NetworkService.updateConfigVar(widget.appName, newKey, newValue)
        .then((value) {
      if (value) {
        showMsg(context, "Updated Config");
        if (newValue == null) {
          widget.onDelete();
          debugPrint("onDeleteCalled");
        }
      } else {
        showMsg(context, "Error Occured");
      }
    }).catchError((e) {
      showMsg(context, e.toString());
    });
  }
}
