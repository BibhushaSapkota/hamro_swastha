import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mero_doctor/screens/dotor_profile.dart';
import 'package:mero_doctor/utils/constants.dart';

class Location extends StatefulWidget {
  String? id;
  String? profilePicture;
  Location({Key? key, this.id, this.profilePicture}) : super(key: key);

  @override
  _Location createState() => _Location();
}

class _Location extends State<Location> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(27.706320317381863, 85.33007579706239);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    _onMapCreated(mapController);
    // TODO: implement dispose
    super.dispose();
  }

  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    Set<Marker> _position = <Marker>{
      Marker(
          markerId: const MarkerId('originalPostion'),
          infoWindow: const InfoWindow(title: 'My Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: _center)
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('My Location'),
            centerTitle: true,
            backgroundColor: COLOR_SECONDARY,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => ProfileScreenDoc(
                              id: widget.id!,
                              profilePicture: widget.profilePicture!,
                            )),
                    (route) => false);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          floatingActionButton: Row(children: [
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentMapType = (_currentMapType == MapType.normal)
                      ? MapType.satellite
                      : MapType.normal;
                });
              },
              child: const Icon(
                Icons.layers,
                color: Colors.grey,
              ),
              backgroundColor: Colors.white,
            ),
          ]),
          body: Stack(children: [
            GoogleMap(
              mapType: _currentMapType,
              mapToolbarEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 18.5,
              ),
              markers: _position,
            ),
          ]),
        ),
      ),
    );
  }
}
