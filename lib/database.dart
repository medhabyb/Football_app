import 'package:cloud_firestore/cloud_firestore.dart';

import 'info.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String? team, String? name) async {
    return await brewCollection.doc(uid).set({

      'name': name,

    });
  }

  List<info> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return info(
          name: doc.data()['name'] ?? '',
          equipe: doc.data()['team'] ?? '',

      );
    }).toList();
  }
  Stream<List<info>> get brews {
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

}