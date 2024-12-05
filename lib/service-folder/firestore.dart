import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  // final CollectionReference dataItems = FirebaseFirestore.instance.collection('iventory_items');
  Future<void> addToCart(
    String name,
    double price,
    int quantity,
  ) {
    final CollectionReference dataCart = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart_items');

    return dataCart.add({
      'name': name,
      'price': price,
      'quantity': quantity,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> readCart() {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart_items');
    final noteStream =
        dataItems.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  Future<void> updateCart(String itemId, int quantity) async {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart_items');

    await dataItems.doc(itemId).update({
      'quantity': quantity,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteCart(String docID) async {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart_items');

    await dataItems.doc(docID).delete();
  }

  Future<void> updateInventory(String docId, int stockChange) async {
  final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');

    await dataItems.doc(docId).update({
      'stock': stockChange,
      'timestamp': Timestamp.now(),
    });
}



  Future<void> createData(int itemId, String name, double price, int stock) {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');

    return dataItems.add({
      'item_id': itemId,
      'name': name,
      'price': price,
      'stock': stock,
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
      String docID, String newName, double newPrice, int newStock) async {
    final CollectionReference dataItems = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory_items');

    await dataItems.doc(docID).update({
      'name': newName,
      'price': newPrice,
      'stock': newStock,
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
