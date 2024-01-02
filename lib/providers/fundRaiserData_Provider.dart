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
  String status = 'Urgent Need of Funds';
  DateTime dateEnd = DateTime.now().add(const Duration(days: 30));

  // New fields
  List<String> documentUrls = [];
  List<String> mediaImageUrls = [];
  List<String> mediaVideoUrls = [];
  int tipAmount = 0;
  List<String> donations = [];
  List<String> updates = [];
}
