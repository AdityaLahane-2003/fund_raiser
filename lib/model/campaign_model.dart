class Campaign {
  final String id;
  final String title;
  final String description;
  final String ownerId; // Added field for campaign owner

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerId,
  });
}
