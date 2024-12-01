import 'package:cloud_firestore/cloud_firestore.dart';

class ListingsModel {
  final FirebaseFirestore firestore;

  ListingsModel({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addListing(Map<String, dynamic> listingData) async {
    await firestore.collection('houses').add(listingData);
  }
}
