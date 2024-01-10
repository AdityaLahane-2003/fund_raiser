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


  void updateBeneficiaryPhoto(bool value){
    _isBeneficiaryPhotoUploaded=value;
    notifyListeners();
  }
  void updateCoverPhoto(bool value){
    _isBeneficiaryPhotoUploaded=value;
    notifyListeners();
  }


  void updateFundraiserDataStep1(String name, String email, int amount,
      DateTime date, String category, String status) {
    _fundraiserData.name = name;
    _fundraiserData.email = email;
    _fundraiserData.amountGoal = amount;
    _fundraiserData.dateEnd = date;
    _fundraiserData.category = category;
    _fundraiserData.status = status;
    _fundraiserData.title="Help "+name+" to raise funds for "+category;
    notifyListeners();
  }
  void updateFundraiserDataStep2(String relation,
      String gender, String city, String age, String photoUrl) {
    _fundraiserData.relation = relation;
    _fundraiserData.age=age;
    _fundraiserData.gender=gender;
    _fundraiserData.city=city;
    _fundraiserData.photoUrl=photoUrl;
    notifyListeners();
  }
  void updateFundraiserDataStep3(String name, String location) {
    _fundraiserData.schoolOrHospital=name;
    _fundraiserData.location=location;
    notifyListeners();
  }
  void updateFundraiserDataStep4(String story, String coverPhotoUrl, String title) {
    _fundraiserData.story=story;
    _fundraiserData.coverPhoto=coverPhotoUrl;
    _fundraiserData.title=title;
    notifyListeners();
  }
}
