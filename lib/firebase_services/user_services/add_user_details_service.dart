import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
String getCurrentUserEmail() {
  return user?.email ?? '';
}String getCurrentUserPhone() {
  return user?.phoneNumber ?? '';
}
String getCurrentUserId() {
  return user?.uid ?? '';
}
Future addUserDetails(String name, String email, String phone, int age, String bio) async{
  String userId = getCurrentUserId();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users.doc(userId).set({
    'name':name,
    'email':email,
    'phone':phone,
    'age':age,
    'bio':bio,
    'imageUrl': "",
    'campaigns': [],
  });
}