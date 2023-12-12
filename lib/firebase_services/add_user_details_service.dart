import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

  User? user = FirebaseAuth.instance.currentUser;
String getCurrentUserEmail() {
  return user?.email ?? '';
}
String getCurrentUserId() {
  return user?.uid ?? '';
}
Future addUserDetails(String name, String email, String phone, int age, String bio) async{
  String userId = getCurrentUserId();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users.doc(userId).set({
    'name':name,
    'email':getCurrentUserEmail(),
    'phone':phone,
    'age':age,
    'bio':bio,
    'imageUrl': "",
    'campaigns': [],
  });
}