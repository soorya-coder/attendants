
const col_id = 'id';
const col_oid = 'owner_id';
const col_read = 'read_uid';
const col_write = 'write_uid';
const col_sudents = 'students';
const col_dep = 'department';
const col_year = 'year';
const col_sec = 'section';
const col_time = 'created_at';
//const col_ = '';

class Classes {
  String? id, time;
  String oid, dep, sec;
  int year;
  List<String> read, write, students;

  Classes({
    this.id,
    required this.oid,
    required this.dep,
    required this.year,
    required this.sec,
    required this.read,
    required this.write,
    required this.students,
    this.time,
  });

  factory Classes.fromMap(Map<String, dynamic> map) => Classes(
        id: map[col_id],
        oid: map[col_oid] ?? '',
        dep: map[col_dep],
        year: map[col_year],
        sec: map[col_sec],
        read: List.castFrom(map[col_read]?? []),
        write: List.castFrom(map[col_write]?? []),
        students: List.castFrom(map[col_sudents]?? []),
        time: map[col_time] ?? '',
        //: map[col_],
      );

  Map<String, dynamic> toMap() => {
        col_id: id,
        col_oid: oid,
        col_dep: dep,
        col_year: year,
        col_sec: sec,
        col_read: read,
        col_write: write,
        col_sudents: students,
        col_time: time,
        //col_: ,
      };
}
