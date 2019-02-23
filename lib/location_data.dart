class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({this.latitude, this.longitude, this.address});

  @override
  String toString() {
    return 'LocationData{latitude: $latitude, longitude: $longitude, address: $address}';
  }
}