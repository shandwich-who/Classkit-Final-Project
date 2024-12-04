import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  // final CollectionReference dataItems = FirebaseFirestore.instance.collection('iventory_items');
  Future<void> addToCart(String name, double price, int quantity) {
    final CollectionReference dataCart =
        FirebaseFirestore.instance.collection('cart');

    return dataCart.add({'name': name, 'price': price, 'quantity': quantity});
  }

  Future<void> createData(int itemId, String name, double price, int quantity) {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');

    return dataItems.add({
      'item_id': itemId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> readData() {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');
    final noteStream =
        dataItems.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  Future<void> updateData(
      String docID, String newName, double newPrice, int newQuantity) async {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');

    await dataItems.doc(docID).update({
      'name': newName,
      'price': newPrice,
      'quantity': newQuantity,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteData(String docID) async {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');

    await dataItems.doc(docID).delete();
  }
}
