import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../ui/views/home/home_viewmodel.dart';

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
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FittedBox(
                    child: Text('Olá usuário'),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: model.latLng,
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      model.controller.complete(controller);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
