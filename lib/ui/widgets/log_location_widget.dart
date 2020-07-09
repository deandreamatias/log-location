import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:log_location/models/log_location.dart';

class LogLocationWidget extends StatelessWidget {
  const LogLocationWidget({Key key, this.logLocation}) : super(key: key);

  final LogLocation logLocation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          'Lat: ${logLocation.latitude.toStringAsFixed(4)} / Log: ${logLocation.longitude.toStringAsFixed(4)}'),
      subtitle: Text(
          'Altitude: ${logLocation.altitude.toStringAsFixed(2)} / Uid: ${logLocation.uid}'),
      isThreeLine: true,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(DateFormat('dd/MM/yy').format(logLocation.dateTime)),
          Text(DateFormat('hh:mm:ss').format(logLocation.dateTime)),
        ],
      ),
      onTap: () async => await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location'),
            content: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(logLocation.latitude, logLocation.longitude),
                zoom: 15.0,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CLOSE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
