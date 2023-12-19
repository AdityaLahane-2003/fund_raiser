import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> getUser(String userId) async {
    DocumentSnapshot document = await usersCollection.doc(userId).get();

    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> updatedUserData) async {
    await usersCollection.doc(userId).update(updatedUserData);
  }
}