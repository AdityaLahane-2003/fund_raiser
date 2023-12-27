class FundraiserData {
  String category = 'Medical';
  String name = '';
  String title = 'Campaign Title';
  String email = '';
  String relation = 'Myself';
  String photoUrl = '';
  String age = '';
  String gender = '';
  String city = '';
  String schoolOrHospital = '';
  String location = '';
  String coverPhoto = '';
  String story = '';
  int amountRaised = 20;
  int amountGoal = 100;
  int amountDonors = 3;
  DateTime dateCreated = DateTime.now();
  String status = 'Active';
  DateTime dateEnd = DateTime.now().add(const Duration(days: 30));

  // New fields
  List<String> documentUrls = [];
  List<String> mediaUrls = [];
  int tipAmount = 0;
  List<Donation> donations = [];
  List<String> updates = [];
}

class Donation {
  String donorName = 'anonymous' ;
  int amount = 0 ;
  DateTime date= DateTime.now() ;
  // Donation({required this.donorName, required this.amount, required this.date});
}
