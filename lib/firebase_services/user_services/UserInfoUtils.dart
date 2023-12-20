import 'package:fund_raiser_second/firebase_services/user_services/update_user_info_services.dart';

class UserInfoUtils {
  final FirebaseService firebaseService = FirebaseService();
  late Map<String, dynamic> userData;

  Future<void> loadUserInfo(String userId) async {
    userData = await firebaseService.getUser(userId);
  }
  Map<String, dynamic> loadUser() {
    return userData;
  }
  String getUserName() {
    return userData['name'];
  }

  String getUserEmail() {
    return userData['email'];
  }

  String getUserImageUrl() {
    return userData['imageUrl'];
  }

  String getUserPhoneNumber() {
    return userData['phone'];
  }
}
