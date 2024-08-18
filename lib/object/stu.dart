import 'package:attendants/constants/functions.dart';

const col_id = 'id';
const col_clid = 'clid';
const col_name = 'name';
const col_regno = 'regno';
const col_sprno = 'sprno';
const col_smob = 'smob';
const col_pmob = 'pmob';
const col_time = 'time';

class Stu{
  String? id,time;
  String name,regno,sprno,smob,pmob,clid;
  //List<String> classes;
  //List<stuab>? ablist;

  Stu({
    this.id,
    required this.clid,
    required this.name,
    required this.regno,
    required this.sprno,
    required this.smob,
    required this.pmob,
    this.time,
    //this.ablist
  });

  factory Stu.fromMap(Map<String, dynamic> map) => Stu(
    id: map[col_id],
    clid: map[col_clid] ?? '',
    name: map[col_name] ?? '',
    regno: map[col_regno] ?? '',
    sprno: map[col_sprno] ?? '',
    smob: map[col_smob] ?? '',
    pmob: map[col_pmob] ?? '',
    time: map[col_time],
  );

  factory Stu.fromsheet(List<String> map,String clid) => Stu(
    id: '',
    clid: clid,
    name: map[3],
    regno: map[2],
    sprno: map[1],
    smob: map[4],
    pmob: map[6],
    time: timenow
  );

  List<dynamic> toList(){
    return [
      sprno,
      regno,
      name,
      smob,
      pmob,
    ];
  }


  Map<String, dynamic> toMap() => {
    col_id: id,
    col_clid: clid,
    col_name: name,
    col_regno: regno,
    col_sprno: sprno,
    col_smob: smob,
    col_pmob: pmob,
    col_time: time,
  };

}