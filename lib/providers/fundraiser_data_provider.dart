import 'package:flutter/material.dart';
import 'fundRaiserData_Provider.dart';

class FundraiserDataProvider extends ChangeNotifier {
  FundraiserData _fundraiserData = FundraiserData();
  bool _isBeneficiaryPhotoUploaded = false;
  bool _isCoverPhotoUploaded = false;
  FundraiserData get fundraiserData => _fundraiserData;
  bool get isBeneficiaryPhotoUploaded => _isBeneficiaryPhotoUploaded;
  bool get isCoverPhotoUploaded => _isCoverPhotoUploaded;

  void initiateFundraiserData() {
    _fundraiserData = FundraiserData();
    _isBeneficiaryPhotoUploaded = false;
    _isCoverPhotoUploaded = false;
    notifyListeners();
  }


  void updateBeneficiaryPhoto(bool value,String photoUrl){
    _isBeneficiaryPhotoUploaded=value;
    _fundraiserData.photoUrl=photoUrl;
    notifyListeners();
  }
  void updateCoverPhoto(bool value,String coverPhotoUrl){
    _isCoverPhotoUploaded=value;
    _fundraiserData.coverPhoto=coverPhotoUrl;
    notifyListeners();
  }

  void updateName(String name) {
    _fundraiserData.name = name;
    notifyListeners();
  }
  void updateEmail(String email) {
    _fundraiserData.email = email;
    notifyListeners();
  }
  void updateAmount(int amount) {
    _fundraiserData.amountGoal = amount;
    notifyListeners();
  }


  void updateFundraiserDataStep1(String name,
      DateTime date, String category, String status) {
    _fundraiserData.dateEnd = date;
    _fundraiserData.category = category;
    _fundraiserData.status = status;
    _fundraiserData.title="Help "+name+" to raise funds for "+category;
    notifyListeners();
  }

  void updateAge(String age) {
    _fundraiserData.age = age;
    notifyListeners();
  }
  void updateCity(String city) {
    _fundraiserData.city = city;
    notifyListeners();
  }


  void updateFundraiserDataStep2(String relation,
      String gender) {
    _fundraiserData.relation = relation;
    _fundraiserData.gender=gender;
    notifyListeners();
  }

  void updateSchoolOrHospital(String name) {
    _fundraiserData.schoolOrHospital=name;
    notifyListeners();
  }

  void updateLocation(String location) {
    _fundraiserData.location=location;
    notifyListeners();
  }

  void updateTitle(String title) {
    _fundraiserData.title=title;
    notifyListeners();
  }
  void updateStory(String story) {
    _fundraiserData.story=story;
    notifyListeners();
  }
}
