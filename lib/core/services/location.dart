import 'package:location/location.dart';

class LocationService {
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<LocationData> determinePosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    //
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //    await showDialog(context: context, builder: (ctx){
    //       return AlertDialog(
    //         title: Text('Location Services'),
    //         content: Text('Please enable location services'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Ok'),
    //             onPressed: () async {
    //               _serviceEnabled = await location.requestService();
    //               Navigator.of(ctx).pop();
    //             },
    //           ),
    //           TextButton(
    //             child: const Text('ignore'),
    //             onPressed: () async {
    //               Navigator.of(ctx).pop();
    //             },
    //           )
    //         ],
    //       );
    //     });
    //     // return Future(() => throw Exception('Location service is not enabled'));
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     await showDialog(context: context, builder: (ctx){return AlertDialog(
    //       title: const Text('Location Permission'),
    //       content: const Text('Please enable location permission'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: const Text('Ok'),
    //           onPressed: () async {
    //             _permissionGranted = await location.requestPermission();
    //             Navigator.of(ctx).pop();
    //           },
    //         ),
    //         TextButton(
    //           child: const Text('ignore'),
    //           onPressed: () async {
    //             Navigator.of(ctx).pop();
    //           },
    //         )
    //       ],
    //     );});
    //     // return Future(() => throw Exception('Location permission is not granted'));
    //   }
    // }
    //
    _locationData = await location.getLocation();
    return Future.value(_locationData) ;
  }

}
