import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.directions_run),
                    tooltip: 'Get random close location',
                    onPressed: () async =>
                        await model.getLocation(random: true),
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
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async => await model.getLocation(),
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
                    child: model.hasListItems
                        ? ListView.builder(
                            itemCount: model.list.length,
                            itemBuilder: (context, index) => LogLocationWidget(
                              logLocation: model.list[index],
                            ),
                          )
                        : Text('Não há logs'),
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
