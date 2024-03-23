class Address {
  String address;
  double lat;
  double lng;
  String postalCode;

  Address({
    required this.address,
    required this.lat,
    required this.lng,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
      postalCode: json['postal_code'],
    );
  }
}
