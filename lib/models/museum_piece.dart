class MuseumPiece {
  final String id, title, subtitle, description, image, color, beaconUUID;
  final int rssi;

  MuseumPiece({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.color,
    required this.beaconUUID,
    required this.rssi,
  });
}
