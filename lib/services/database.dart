import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Stream<List> getAlert() async* {
    await for (QuerySnapshot query
        in FirebaseFirestore.instance.collectionGroup('location').snapshots()) {
      yield query.docs.map((e) => e.data() as Map).toList();
    }
  }

  Future<Map> getUser(uid) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('userData').doc(uid).get();
    return data.data() as Map;
  }
}
