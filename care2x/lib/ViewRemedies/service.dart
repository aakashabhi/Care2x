import 'package:care2x/ViewRemedies/remedy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('QuickRemedies');

  List<Remedy> _RemedyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Remedy(
        title: doc.get('title') ?? '',
        description: doc.get('description') ?? '',
      );
    }).toList();
  }

  Stream<List<Remedy>?> get all_remedies {
    return brewCollection.snapshots().map(_RemedyListFromSnapshot);
  }
}
