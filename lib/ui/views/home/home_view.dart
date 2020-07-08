import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Log location'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async => await model.logout(),
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FittedBox(
                  child: Text('Olá usuário'),
                ),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
