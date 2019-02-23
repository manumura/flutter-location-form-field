import 'dart:async';
import 'package:flutter/material.dart';

import './location_data.dart';

class LocationFormField extends FormField<LocationData> {

  LocationFormField(
      {FormFieldSetter<LocationData> onSaved,
      FormFieldValidator<LocationData> validator,
      LocationData initialValue,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<LocationData> state) {
              return state.build(state.context);
            });

  @override
  FormFieldState<LocationData> createState() {
    return _LocationFormFieldState();
  }
}

class _LocationFormFieldState extends FormFieldState<LocationData> {
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressInputFocusNode.addListener(_updateLocationByAddress);
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocationByAddress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildLocationFormField();
  }

  Widget _buildLocationFormField() {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _addressInputController,
          validator: (String value) {
            if (this.value.address == null || this.value.address.isEmpty) {
              return 'No valid location found.';
            }
          },
          decoration: InputDecoration(labelText: 'Address'),
        ),
        SizedBox(height: 10.0),
        FlatButton(
          color: Colors.deepPurpleAccent,
          textColor: Colors.white,
          child: Text('Locate me !'),
          onPressed: _updateLocation,
        ),
      ],
    );
  }

  void _updateLocation() async {
    print('current value: ${this.value}');
      final double latitude = 45.632;
      final double longitude = 17.457;
      final String formattedAddress = await _getAddress(latitude, longitude);
      print(formattedAddress);

      if (formattedAddress != null) {
        final LocationData locationData = LocationData(
            address: formattedAddress,
            latitude: latitude,
            longitude: longitude);

//        setState(() {
          _addressInputController.text = locationData.address;
//        });

        // save data in form
        this.didChange(locationData);
        print('New location: ' + locationData.toString());
        print('current value: ${this.value}');
    }
  }

  Future<String> _getAddress(double lat, double lng) async {
    if (lat == null || lng == null) {
      return null;
    }
    return 'test address';
  }

  void _updateLocationByAddress() {
    if (!_addressInputFocusNode.hasFocus) {
      _displayLocation(address: _addressInputController.text);
    }
  }

  void _displayLocation({final String address, final double lat, final double lng}) async {

    if (lat != null && lng != null) {
      LocationData(address: address, latitude: lat, longitude: lng);
    } else {
      return;
    }
  }
}
