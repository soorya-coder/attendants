// ignore_for_file: constant_identifier_names

import 'package:attendants/constants/functions.dart';
import 'package:attendants/object/users.dart';
import 'package:attendants/service/todHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsheets/gsheets.dart';
import '../object/classes.dart';
import 'authHelper.dart';

const String col_id = 'id';
const String col_title = 'title';
const String col_subtitle = 'subtitle';
const String col_color = 'color';
const String col_time = 'time';
//const String col_ = '';

class ClassHelper {
  static String docofclass(String doc) => '/Classes/$doc';
  static String get colofclass => '/Classes';

  String uid = AuthHelper.myuser!.uid;
  GSheets sheets = GSheets(credential);

  static Future<Worksheet> atsheet(String cid) async {
    GSheets gsheets = GSheets(credential);
    Spreadsheet spreedsheet = await gsheets.spreadsheet(cid);
    bool hasSh = false;
    for (Worksheet sh in spreedsheet.sheets) {
      if (sh.title == name_wk) hasSh = true;
      print(sh.title);
    }

    if (!hasSh) {
      spreedsheet.addWorksheet(name_wk);
    }

    return spreedsheet.worksheetByTitle(name_wk)!;
  }

  Future<bool> create(int dep, int year, int sec) async {
    String id;
    try {

      Spreadsheet spreadsheet = await sheets
          .createSpreadsheet('${yearl[year]} - ${depl[dep]}(${secl[sec]})');

      spreadsheet.addWorksheet(name_wk);

      spreadsheet.share(AuthHelper.myuser!.email!, role: PermRole.writer);
      id = spreadsheet.id;
    } catch (e) {
      msg('Error occured $e');
      return false;
    }


    Classes classes = Classes(
      id: id,
      oid: uid,
      dep: depl[dep],
      year: year,
      sec: secl[sec],
      read: [uid],
      write: [uid],
      students: [],
      time: timenow,
    );

    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofclass(id));
    await docrefer.set(classes.toMap());

    Worksheet wk = await atsheet(id);


    return await wk.values.insertRow(1, [
        'Spr no',
        'Registration no',
        'Name',
        'Students phoneno',
        'Parent phoneno',
      ]);
  }

  Future<void> update(Classes classes) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofclass(classes.id!));
    return await docrefer.update(classes.toMap());
  }

  Stream<Classes> getClass(String cid) {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofclass(cid));
    return docrefer.snapshots().map((event) => Classes.fromMap(event.data()!));
  }

  Future<void> delete(Classes classes) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofclass(classes.id!));


    return await docrefer.delete();
  }

  Stream<List<Classes>> getlist() {
    final reference = FirebaseFirestore.instance.collection(colofclass);
    final snapshots = reference.orderBy(col_year).snapshots();
    return snapshots
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                msg(snapshot.data().toString());
                return Classes.fromMap(snapshot.data());
              },
            ).toList())
        .asBroadcastStream();
  }

  static Future<void> setfocus(Classes classes) async {
    return await AuthHelper.docuser.update({col_fcid: classes.id});
  }

  static Future<String> getfocus() async {
    return AuthHelper.docuser.get().then((value) {
      return value.get(col_fcid);
    });
  } /**/
}
