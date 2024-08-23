// ignore_for_file: constant_identifier_names

const String col_uid = 'uid';
const String col_name = 'name';
const String col_logins = 'login_ats';
const String col_crtm = 'created_at';
const String col_email = 'email';
const String col_url = 'photo_url';
const String col_fcid = 'focused_cid';
const String col_deps = 'deps';
//const String col_ = '';

class Users {
  String uid,fcid, name,crtime,email,url;
  List<String> logins,deps;


  Users({
    required this.uid,
    required this.fcid,
    required this.name,
    required this.crtime,
    required this.logins,
    required this.email,
    required this.url,
    required this.deps,
  });

  factory Users.fromMap(Map<String, dynamic>? map) => Users(
      uid: map![col_uid] ?? '',
      fcid: map[col_fcid] ?? '',
      name: map[col_name] ?? '',
      logins: List.castFrom(map[col_logins]?? []),
      deps: List.castFrom(map[col_deps]?? ['CIVIL', 'CSE', 'ECE', 'EEE', 'MECH']),
      crtime: map[col_crtm],
      email : map[col_email] ?? '',
      url:  map[col_url] ?? ''
  );

  Map<String, dynamic> toMap(){
    return {
      col_uid: uid,
      col_fcid: fcid,
      col_name: name,
      col_crtm: crtime,
      col_email: email,
      col_url: url,
      col_deps: deps,
    };
  }

}
