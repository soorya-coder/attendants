// ignore_for_file: constant_identifier_names

import 'package:attendants/constants/functions.dart';
import 'package:attendants/object/stu.dart';
import 'package:attendants/service/classHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsheets/gsheets.dart';

//const String col_ = '';

class StuHelper {
  StuHelper({required this.cid});

  String cid;

  String get colofstu => '${ClassHelper.docofclass(cid)}/students';
  String docofstu(String doc) => '$colofstu/$doc';

  Future<void> add(String clid, String name, String regno, String sprno,
      String smob, String pmob) async {
    Stu stu = Stu(
        clid: clid,
        name: name,
        regno: regno,
        sprno: sprno,
        smob: smob,
        pmob: pmob);

    stu.id = '$sprno - $regno';
    stu.time = timenow;

    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    Worksheet wk = await ClassHelper.atsheet(cid);
    wk.values.appendRow(stu.toList());
    return await docrefer.set(stu.toMap());
  }

  Future<Stu> getstu(String sid) async {
    Stu stu = Stu.fromMap(
        (await FirebaseFirestore.instance.collection(colofstu).doc(sid).get())
            .data()!);
    return stu;
  }

  Future<void> update(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.update(stu.toMap());
  }

  Future<void> delete(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.delete();
  }

  Stream<List<Stu>> getlist() {
    final reference = FirebaseFirestore.instance.collection(colofstu);
    final snapshots = reference.orderBy(col_name).snapshots();
    return snapshots
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Stu.fromMap(data);
              },
            ).toList())
        .asBroadcastStream();
  }

  Stream<List<Stu>> getClasstu() {
    final reference = FirebaseFirestore.instance.collection(colofstu);
    final snapshots = reference.orderBy(col_name).snapshots();
    return snapshots
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Stu.fromMap(data);
              },
            ).toList())
        .asBroadcastStream();
  }

/*Future<void> setfocus(Classes cfocus) async {
    var ref = FirebaseFirestore.instance.collection('');
    await ref.get().then((value) {
      value.docs.forEach((e) {
        Classes cdata = Classes.fromMap(e.data());
        if(cfocus.id == cdata.id){
          cdata.
        }
      });
    });
  }*/
}
