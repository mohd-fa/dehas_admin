import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Stream<List> getAlert() async* {
    await for (QuerySnapshot query
        in FirebaseFirestore.instance.collectionGroup('location').snapshots()) {
      List list =  query.docs.map((e) => e.data() as Map).toList();
      list.sort((a,b){
        return b['timestamp'].toString().compareTo(a['timestamp'].toString());
      });
      yield list;

    }
  }

  Future<Map> getUser(uid) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('userData').doc(uid).get();
    return data.data() as Map;
  }
}
