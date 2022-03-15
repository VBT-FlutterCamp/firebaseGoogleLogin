import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunctions {
  final database = FirebaseFirestore.instance;

  Future<void> addWithSet() async {
    await database.collection('users').doc('1').set({'name': 'evin', 'surname': 'gülcan'});
  }

  Future<void> addWithAdd() async {
    DocumentReference ref = await database.collection('studentName').add({'name': 'sara', 'surname': 'nefise'});
  }

  void getData() {
    database.collection('datas').get().then((QuerySnapshot snapshot) {
      for (var i in snapshot.docs) {
        print('${i.data()}');
      }
    });
  }

  void updateData() {
    database.collection('users').doc('1').update({"name": "merve"});
  }

  void deleteData() {
    database.collection('users').doc('1').delete();
  }
}
