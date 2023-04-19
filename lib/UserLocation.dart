import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.administrativeArea} ${place.country} ${place.isoCountryCode}'
            ' ${place.locality} ${place.postalCode} ${place.subAdministrativeArea}'
            ' ${place.thoroughfare} ${place.subLocality} ${place.subThoroughfare}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw ("Couldn't open google maps");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Широта: ${_currentPosition?.latitude ?? ""}'),
              Text('Долгота: ${_currentPosition?.longitude ?? ""}'),
              Text('Адрес: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              GestureDetector(
                  onTap:_getCurrentPosition,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        width: 200,
                        height: 50,
                        color: Colors.purple,
                        child: const Center(child: Text('Current Location',style: TextStyle(color: Colors.white),))),
                  )
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                  onTap:(){
                    googleMap();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        width: 200,
                        height: 50,
                        color: Colors.purple,
                        child: const Center(child: Text('Google Map',style: TextStyle(color: Colors.white),))),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}