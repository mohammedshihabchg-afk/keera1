class Shipment {
  final String id;
  final String customerId;
  final String? driverId;
  final double pickupLat;
  final double pickupLng;
  final double dropoffLat;
  final double dropoffLng;
  final String status;
  final String trackingCode;
  final DateTime createdAt;

  Shipment({
    required this.id,
    required this.customerId,
    this.driverId,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.status,
    required this.trackingCode,
    required this.createdAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'],
      customerId: json['customer_id'],
      driverId: json['driver_id'],
      pickupLat: json['pickup_location_lat'],
      pickupLng: json['pickup_location_lng'],
      dropoffLat: json['dropoff_location_lat'],
      dropoffLng: json['dropoff_location_lng'],
      status: json['status'],
      trackingCode: json['tracking_code'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
