
const col_sid = 'sid';
const col_cid = 'cid';
const col_ispresent = 'is_present';
const col_peroid = 'period';
const col_date = 'date';

const i_sprn = 0;
const i_regn = 1;
const i_name = 2;
const i_smob = 3;
const i_pmob = 4;
//const i_ = ;

class Stuab {
  String sid, cid, date,isPresent;
  int period;

  //stu? student;

  Stuab({
    required this.sid,
    required this.cid,
    required this.isPresent,
    required this.period,
    required this.date,
    // this.student
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stuab && runtimeType == other.runtimeType && sid == other.sid;

  @override
  int get hashCode => sid.hashCode;

  /*factory Stuab.fromList(List<dynamic> map,String cid,int i_isp,String date,int period) => Stuab(
        sid: tosid(map[i_sprn], map[i_regn]),
        cid: cid,
        isPresent: map[i_isp] ,
        period: period,
        date: date,
    );*/

  /*List<dynamic> toList(String name,String dep) {

    return [
      sprfromsid(sid),
      regfromsid(sid),
      name,
      is_present,
      period,
      date,
    ];
  }
   */

  factory Stuab.fromMap(Map<String, dynamic> map) => Stuab(
   sid : map[col_sid],
   cid : map[col_cid],
   isPresent : map[col_ispresent],
   period : map[col_peroid],
   date : map[col_date],
  );

  Map<String, dynamic> toMap() {
    return {
      col_sid: sid,
      col_cid: cid,
      col_ispresent: isPresent,
      col_peroid: period,
      col_date: date,
    };
  }

}

String sprfromsid(String sid) => sid.split(' - ')[0];

String regfromsid(String sid) => sid.split(' - ')[1];

String tosid(int spr, int reg) => '$spr - $reg';
