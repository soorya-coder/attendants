/*
class studata {

  studata._Constructor();
  static final studata instance = studata._Constructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  static const table = 'stulists';
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'stu_databse.db');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        ''' 
       CREATE TABLE $table(
           $col_id INTEGER PRIMARY KEY,
           $col_clid INTEGER,
           $col_stuname TEXT,
           $col_regno TEXT,
           $col_sprno TEXT,
           $col_stuno TEXT,
           $col_prano TEXT
       )
       '''
    );
  }

  Future<List<Stu>> getlist() async {
    Database db = await instance.database;
    var data = await db.query(table, orderBy: col_stuname);
    List<Stu> stulist = data.isNotEmpty ? data.map((c) => Stu.fromMap(c)).toList() : [];
    /*stulist.forEach((element) async{
      element.ablist = await toddata.instance.getstuablist(element.id!);
    });

     */
    return stulist;
  }

  Future<List<Stu>> getclslist(int clsid) async {
    Database db = await instance.database;
    var stus = await db.query(table, orderBy: col_classid);
    List<Stu> data = stus.isNotEmpty ? stus.map((c) => Stu.fromMap(c)).toList() : [];
    List<Stu> stulist = [];
    data.forEach((element) async {
      if(element.clid == clsid){
        //element.ablist = await toddata.instance.getstuablist(element.id!);
        stulist.add(element);
      }
    });
    return stulist;
  }

  Future<int> add(Stu stu) async {
    Database db = await instance.database;
    return await db.insert(table, stu.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$col_id = ?', whereArgs: [id]);
  }

  Future<Stu> getstudent(int stuid) async {
    Database db = await instance.database;
    var data = await db.query(table, orderBy: col_clid);
    List<Stu> stulist = data.isNotEmpty ? data.map((c) => Stu.fromMap(c)).toList() : [];
    Stu student  = Stu(clid: 0, stuname: 'stuname', regno: 'regno', sprno: 'sprno', stuno: 'stuno', prano: 'prano');
    stulist.forEach((element) {
      if(element.id == stuid) {
        student = element;
      }
    });
    return student;
  }

  Future<List<stu>> getcuslist(int indx) async {
    Database db = await instance.database;
    var casfers = await db.query(table, orderBy: col_e);
    List<e> data = casfers.isNotEmpty ? casfers.map((c) => e0.fromMap(c)).toList() : [];
    List<e> elist = [];
    data.forEach((element) {
      if(element.indx == indx)
        e1list.add(element);
    });
    return e2list;
  }

}*/

