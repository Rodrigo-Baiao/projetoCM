import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Location _location = Location();

  LatLng _initialPosition = LatLng(-23.5505, -46.6333); 
  LatLng _currentPosition = LatLng(-23.5505, -46.6333);
  Set<Marker> _markers = {};
  Set<LatLng> _treasurePositions = {};
  final int _numTreasures = 5;
  final double _treasureRadius = 0.005;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _updateMarker(_currentPosition);
        _centerMapOnCurrentPosition();
        _checkProximityToTreasures();
      });
      if (_treasurePositions.isEmpty) {
        _spawnTreasures();
      }
    });
  }

  Future<void> _initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Verifica se o serviço de localização está habilitado.
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Verifica se a permissão de localização foi concedida.
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    setState(() {
      _currentPosition = LatLng(_locationData.latitude!, _locationData.longitude!);
      _initialPosition = _currentPosition;
      _updateMarker(_currentPosition);
    });
    _centerMapOnCurrentPosition();
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: position,
        infoWindow: InfoWindow(title: 'Você está aqui'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));

      for (LatLng treasure in _treasurePositions) {
        _markers.add(Marker(
          markerId: MarkerId(treasure.toString()),
          position: treasure,
          infoWindow: InfoWindow(title: 'Baú do Tesouro'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        ));
      }
    });
  }

  void _centerMapOnCurrentPosition() {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition, zoom: 15.0),
        ),
      );
    }
  }

  void _spawnTreasures() {
    Random random = Random();
    for (int i = 0; i < _numTreasures; i++) {
      double offsetLat = (random.nextDouble() - 0.5) * _treasureRadius;
      double offsetLng = (random.nextDouble() - 0.5) * _treasureRadius;
      LatLng treasurePosition = LatLng(_currentPosition.latitude + offsetLat, _currentPosition.longitude + offsetLng);
      _treasurePositions.add(treasurePosition);
    }
    _updateMarker(_currentPosition);
  }

  void _checkProximityToTreasures() {
    Set<LatLng> treasuresToRemove = {};
    for (LatLng treasure in _treasurePositions) {
      double distance = _calculateDistance(_currentPosition, treasure);
      if (distance < 0.0005) { // Aproximadamente 50 metros
        treasuresToRemove.add(treasure);
        _rewardUser();
      }
    }
    if (treasuresToRemove.isNotEmpty) {
      setState(() {
        _treasurePositions.removeAll(treasuresToRemove);
        _updateMarker(_currentPosition);
      });
    }
  }

  double _calculateDistance(LatLng pos1, LatLng pos2) {
    double lat1 = pos1.latitude;
    double lon1 = pos1.longitude;
    double lat2 = pos2.latitude;
    double lon2 = pos2.longitude;
    double p = 0.017453292519943295; // Pi/180
    double a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  void _rewardUser() {
    final ghostSettings = Provider.of<GhostSettings>(context, listen: false);
    ghostSettings.addMoney(50); // Recompensa de 50 moedas
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 11.0,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: _markers,
    );
  }
}
