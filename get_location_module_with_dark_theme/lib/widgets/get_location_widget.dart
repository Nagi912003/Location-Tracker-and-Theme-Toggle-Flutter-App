import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:fl_location/fl_location.dart';
import 'package:provider/provider.dart';
import 'package:get_location_module_with_dark_theme/providers/my_colors_provider.dart';

import 'view_coordinates.dart';

enum ButtonState { LOADING, DONE, DISABLED }

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  String _result = '';
  ButtonState _getLocationButtonState = ButtonState.DONE;

  double _resultLatitude = 0;

  double _resultLongitude = 0;

  Future<bool> _checkAndRequestPermission({bool? background}) async {
    if (!await FlLocation.isLocationServicesEnabled) {
      // Location services are disabled.
      return false;
    }

    var locationPermission = await FlLocation.checkLocationPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      // Cannot request runtime permission because location permission is denied forever.
      return false;
    } else if (locationPermission == LocationPermission.denied) {
      // Ask the user for location permission.
      locationPermission = await FlLocation.requestLocationPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) return false;
    }

    // Location permission must always be allowed (LocationPermission.always)
    // to collect location data in the background.
    if (background == true &&
        locationPermission == LocationPermission.whileInUse) return false;

    // Location services has been enabled and permission have been granted.
    return true;
  }

  void _refreshPage() {
    setState(() {});
  }

  Future<void> _getLocation() async {
    if (await _checkAndRequestPermission()) {
      _getLocationButtonState = ButtonState.LOADING;
      _refreshPage();

      const timeLimit = Duration(seconds: 10);
      await FlLocation.getLocation(timeLimit: timeLimit).then((location) {
        _result = location.toJson().toString();
        _resultLatitude = location.latitude;
        _resultLongitude = location.longitude;
      }).onError((error, stackTrace) {
        _result = error.toString();
      }).whenComplete(() {
        _getLocationButtonState = ButtonState.DONE;
        _refreshPage();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // The getLocationServicesStatusStream function is not available in Web.
    if (!kIsWeb) {
      FlLocation.getLocationServicesStatusStream().listen((event) {
        _refreshPage();
      });
    }
      _checkAndRequestPermission();
      _getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<MyColors>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
        ),
        viewCoordinates(_resultLatitude, _resultLongitude,themeData.myCardColor,themeData.myGrey,themeData.myText),
        const SizedBox(height: 20,),
        _buildContentView(color: themeData.myCardColor, textColor: themeData.myButtonText),
      ],
    );
  }

  Widget _buildContentView({required Color color, required Color textColor}) {
    final buttonList = _buildTestButton(
      text: _result.isEmpty ? 'GET Location' : 'refresh Location',
      state: _getLocationButtonState,
      onPressed: _getLocation,
      color: color,
      textColor: textColor,
    );
    return buttonList;
  }

  Widget _buildTestButton({
    required String text,
    required ButtonState state,
    required VoidCallback? onPressed,
    Color color = Colors.blue,
    Color textColor = Colors.white,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 70),
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onPressed: state == ButtonState.DONE ? onPressed : null,
      child: state == ButtonState.LOADING
          ? SizedBox.fromSize(
              size: const Size(20.0, 20.0),
              child: const CircularProgressIndicator(strokeWidth: 2.0),
            )
          : Text(text, style: TextStyle(color: textColor)),
    );
  }
}
