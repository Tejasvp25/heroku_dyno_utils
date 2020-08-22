import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/network/models/dyno_formation.dart';
import 'package:heroku_dyno_utils/ui/dyno_list_tile.dart';

class DynosListExpansionTile extends StatefulWidget {
  final List<DynoFormation> dynoList;
  final String appName;
  const DynosListExpansionTile(this.appName, this.dynoList);

  @override
  _DynosListExpansionTileState createState() => _DynosListExpansionTileState();
}

class _DynosListExpansionTileState extends State<DynosListExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Dynos"),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) => DynoListTile(
            widget.appName,
            widget.dynoList[index],
          ),
          itemCount: widget.dynoList.length,
        ),
      ],
    );
  }
}
