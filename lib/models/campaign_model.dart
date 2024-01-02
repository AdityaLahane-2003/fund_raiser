
class Campaign {
  final String id;
  final String title;
  final String name;
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
  final int amountRaised;
  final int amountGoal;
  final int amountDonors;
  final DateTime dateCreated;
  final String status;
  final DateTime dateEnd;
  final int tipAmount;
  final List<String> documentUrls;
  final List<String> mediaImageUrls;
  final List<String> mediaVideoUrls;
  final List<String> updates;
  // final List<Donation> donations;
  Campaign({
    required  this.gender,
    required this.age,
    required this.name,
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
    required this.amountRaised,
    required this.amountGoal,
    required this.amountDonors,
    required this.dateCreated,
    required this.status,
    required this.dateEnd,
    required this.tipAmount,
    required this.documentUrls,
    required this.mediaImageUrls,
    required this.mediaVideoUrls,
    required this.updates,
    // required this.donations,
  });
}
