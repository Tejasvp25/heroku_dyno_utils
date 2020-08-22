import 'package:flutter/material.dart';
import 'package:heroku_dyno_utils/network/models/herokuapp.dart';
import 'package:heroku_dyno_utils/network/network_service.dart';
import 'package:heroku_dyno_utils/screens/api_key_input.dart';
import 'package:heroku_dyno_utils/screens/app_info.dart';
import 'package:heroku_dyno_utils/ui/loading_widget.dart';
import 'package:heroku_dyno_utils/utils/api_key_provider.dart';
import 'package:provider/provider.dart';

class AppList extends StatefulWidget {
  final String apiToken;
  const AppList(this.apiToken);

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apps"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApiKeyInput(
                    apiKeyProvider: Provider.of<ApiKeyProvider>(context),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: NetworkService.getApps(),
        builder:
            (BuildContext context, AsyncSnapshot<List<HerokuApp>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(snapshot.data[index].name),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppInfo(snapshot.data[index]),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppInfo(snapshot.data[index]),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(child: Text("No Apps Available"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
