// ignore_for_file: constant_identifier_names

import 'package:attendants/constants/functions.dart';
import 'package:attendants/object/stuab.dart';
import 'package:attendants/service/stuHelper.dart';
import 'package:gsheets/gsheets.dart';

import '../object/stu.dart';

const String name_wk = 'Class Attendants';
//const String col_ = '';
//const String col_ = '';

/*class TodHelper {

  Future adddate() async {
    List<String> cols = (await (await atsheet).values.allRows())[0];
    String hour = '$date ${period}th hour';
    if (cols.contains(hour)) {
      return;
    }
    (await atsheet).values.appendColumn([hour]);
  }

  Future getdata() async {
    //wk = await atsheet;
    //cols = (await wk.values.allRows())[0];
    //rows = (await wk.values.allRows()).skip(1).toList();
//
    //for (int i = 0; i < cols.length; i++) {
    //  if (cols[i] == '$date ${period}th hour') {
    //    pridx = i;
    //  }
    //}
  }

  String date = today, cid;
  int period;

  TodHelper({required this.cid, required this.period}) {
    adddate();
  }

  Future<List<Stuab>> getlist() async {
    await getdata();
    Worksheet wk = await atsheet;
    int pridx = -1;
    List<String> cols = (await wk.values.allRows())[0];
    for (int i = 0; i < cols.length; i++) {
        if (cols[i] == '$date ${period}th hour') {
          pridx = i;
        }
      }
    List<List<String>> rows = (await wk.values.allRows()).skip(1).toList();
    print('----------'+rows.toString()+'----------');
    print(pridx);
    List<Stuab> list = rows.map((map) {
      return Stuab(
        sid: tosid(int.parse(map[i_sprn]), int.parse(map[i_regn])),
        cid: cid,
        isPresent: pridx<map.length ? map[pridx] : '',
        period: period,
        date: date,
      );
    }).toList();

    return list;
  }

  Future<Worksheet> get atsheet async {
    GSheets gsheets = GSheets(credential);
    Spreadsheet spreedsheet = await gsheets.spreadsheet(cid);
    bool hasSh = false;
    for (Worksheet sh in spreedsheet.sheets) {
      if (sh.title == name_wk) hasSh = true;
    }
    if (!hasSh) {
      spreedsheet.addWorksheet(name_wk);
    }
    return spreedsheet.worksheetByTitle(name_wk)!;
  }

  Future<void> marklist(List<Stuab> ablist) async {
    Worksheet wk = await atsheet;
    int pridx = -1;
    List<String> cols = (await wk.values.allRows())[0];

    for (int i = 0; i < cols.length; i++) {
      if (cols[i] == '$date ${period}th hour') {
        pridx = i;
      }
    }

    List<List<String>> rows = (await wk.values.allRows()).skip(1).toList();
    for(Stuab stuab in ablist) {
      int? sridx;
      for (int i = 0; i < rows.length; i++) {
        if (sprfromsid(rows[i][0]) == sprfromsid(stuab.sid)) {
          sridx = i;
          break;
        }
      }

      if (sridx == null) {
        Stu stu = await StuHelper(cid: cid).getstu(stuab.sid);
        await StuHelper(cid: cid).add(cid, stu.name, stu.regno, stu.sprno, stu.smob, stu.pmob);
      }

      await wk.values.insertValue(stuab.isPresent, column: pridx + 1, row: sridx! + 2);

    }

  }

  Future<void> markPresent(String sid) async {
    int? sridx;
    Worksheet wk = await atsheet;
    int pridx = -1;
    List<String> cols = (await wk.values.allRows())[0];
    for (int i = 0; i < cols.length; i++) {
      if (cols[i] == '$date ${period}th hour') {
        pridx = i;
      }
    }
    List<List<String>> rows = (await wk.values.allRows()).skip(1).toList();
    for (int i = 0; i < rows.length; i++) {
      if (sprfromsid(rows[i][0]) == sprfromsid(sid)) {
        sridx = i;
      }
    }

    if (sridx == null) {
      Stu stu = await StuHelper(cid: cid).getstu(sid);
      await StuHelper(cid: cid).add(cid, stu.name, stu.regno, stu.sprno, stu.smob, stu.pmob);
    }

    wk.values.insertValue('P', column: pridx + 1, row: sridx! + 1);
  }

  Future<void> markAbsent(String sid) async {
    int? sridx;
    Worksheet wk = await atsheet;
    int pridx = -1;
    List<String> cols = (await wk.values.allRows())[0];
    for (int i = 0; i < cols.length; i++) {
      if (cols[i] == '$date ${period}th hour') {
        pridx = i;
      }
    }
    List<List<String>> rows = (await wk.values.allRows()).skip(1).toList();
    for (int i = 0; i < rows.length; i++) {
      if (sprfromsid(rows[i][0]) == sprfromsid(sid)) {
        sridx = i;
      }
    }

    if (sridx == null ) {
      return;
    }

    wk.values.insertValue('A', column: pridx + 1, row: sridx + 1);
  }

/*Future<void> update(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.update(stu.toMap());
  }

  /*Future<void> update(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.update(stu.toMap());
  }

  Future<void> delete(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.delete();
  }

  Stream<List<Stu>> getClasstu(String cid) {
    final reference = FirebaseFirestore.instance.collection(colofstu);
    final snapshots =
        reference.where(col_clid, isEqualTo: cid).orderBy(col_name).snapshots();
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
}*/
 */
 */

class TodHelper {

  Future adddate() async {
    List<String> cols = (await (await atsheet).values.allRows())[0];
    String hour = '$date ${period}th hour';
    if (cols.contains(hour)) {
      return;
    }
    (await atsheet).values.appendColumn([hour]);
  }

  Future getdata() async {
    //wk = await atsheet;
    //cols = (await wk.values.allRows())[0];
    //rows = (await wk.values.allRows()).skip(1).toList();
    //for (int i = 0; i < cols.length; i++) {
    //  if (cols[i] == '$date ${period}th hour') {
    //    pridx = i;
    //  }
    //}
  }

  String date = today, cid;
  int period;

  TodHelper({required this.cid, required this.period}) {
    adddate();
  }

  Stream<List<Stuab>> getlist() {

  }

  Future<void> marklist(List<Stuab> ablist) async {

  }

/*Future<void> update(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.update(stu.toMap());
  }

  Future<void> delete(Stu stu) async {
    DocumentReference<Map<String, dynamic>> docrefer =
        FirebaseFirestore.instance.doc(docofstu(stu.id!));
    return await docrefer.delete();
  }

  Stream<List<Stu>> getClasstu(String cid) {
    final reference = FirebaseFirestore.instance.collection(colofstu);
    final snapshots =
        reference.where(col_clid, isEqualTo: cid).orderBy(col_name).snapshots();
    return snapshots
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Stu.fromMap(data);
              },
            ).toList())
        .asBroadcastStream();
  }
}*/
}
