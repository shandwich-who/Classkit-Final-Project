// put all the operations here
// import the firestore
import 'package:cloud_firestore/cloud_firestore.dart';

// 5 create a class firestoreservice
class FirestoreService {
  // get the collections from the database
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('items');

  // Create
  Future<void> createData(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }
  /*Purpose: Adds a new note to the notes collection.
  Parameters: Accepts a single String note parameter, which is the content of the note to be added.
  Functionality: Uses the .add() method to add a document with the fields note and timestamp (set to the current time) to the notes collection.*/

//Read
  // 8 create a reading constructor
  Stream<QuerySnapshot> readData() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }
/*Purpose: Reads the list of notes from the Firestore database in real time, reflecting any changes made to the collection.
  Return Type: Returns a Stream<QuerySnapshot>, allowing you to listen to changes in the collection.
  Functionality: Orders the notes by the timestamp field in descending order to retrieve the latest notes first.*/

  // stream: Read any changes on our database

// Update
  // we need to know which doc id we need to change
  // also what new note will update
  Future<void> updateData(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  /*Purpose: Updates an existing note in the notes collection.
  Parameters: Accepts a docID (the document ID of the note to update) and newNote (the updated note content).
  Functionality: Uses the .update() method to modify the note and timestamp fields in the specified document. The timestamp field is updated to the current time.*/

//Delete
  Future<void> deleteData(String docID) {
    return notes.doc(docID).delete();
  }
}
/*Purpose: Deletes a specific note from the notes collection.
Parameters: Accepts docID, which identifies the document to be deleted.
Functionality: Uses the .delete() method to remove the specified document from the collection.*/
