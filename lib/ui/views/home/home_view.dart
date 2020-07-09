import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/log_location.dart';
import '../../widgets/log_location_widget.dart';
import '../../views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Colors.lightBlueAccent,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.my_location),
                    tooltip: 'Get random close location',
                    onPressed: () async => await model.getLocation(),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear_all),
                    tooltip: 'Clear list',
                    onPressed: () async => await model.clearList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async => await model.logout(),
                  ),
                ],
              ),
            ),
            primary: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async => await model.getLocation(random: true),
              child: model.isBusy
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Icon(Icons.location_searching),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16.0),
                    child: FittedBox(
                      child: Text(
                        'Olá ${model.userId}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: StreamBuilder<List<LogLocation>>(
                        stream: model.list,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<LogLocation>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isEmpty) {
                              return Text('Não há logs');
                            } else {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) =>
                                      LogLocationWidget(
                                    logLocation: snapshot.data[index],
                                  ),
                                ),
                              );
                            }
                          } else {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Text('Não há logs');
                            }
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
