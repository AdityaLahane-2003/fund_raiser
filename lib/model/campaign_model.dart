class Campaign {
  final String id;
  final String title;
  final String description;
  final String ownerId; // Added field for campaign owner
  final String category;
  final String email;
  final String relation;
  final String photoUrl;
  final String age;
  final String gender;
  final String city;
  final String schoolOrHospital;
  final String location;
  final String coverPhoto;
  Campaign({
    required  this.gender,
    required this.age,
    required this.city,
    required  this.schoolOrHospital,
    required this.location,
    required this.coverPhoto,
    required this.category,
    required this.email,
    required this.relation,
    required this.photoUrl,
    required this.id,
    required this.title,
    required this.description,
    required this.ownerId,
  });
}
