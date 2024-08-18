// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names, camel_case_types, constant_identifier_names


/*class toddata {

  toddata._Constructor();
  static final toddata instance = toddata._Constructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  static const String table = 'todlists';

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tod_databse.db');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        ''' 
       CREATE TABLE $table(
           $col_id INTEGER PRIMARY KEY,
           $col_stuid INTEGER,
           $col_classid INTEGER,
           $col_ab INTEGER,
           $col_time TEXT
       )
       '''
    );
  }

  Future<List<Stuab>> getlist() async {
    Database db = await instance.database;
    var data = await db.query(table, orderBy: col_classid);
    List<Stuab> todlist = data.isNotEmpty ? data.map((c) => Stuab.fromMap(c)).toList() : [];
    return todlist;
  }

  Future<List<Stuab>> getstuablist(int stuid) async {
    Database db = await instance.database;
    var data = await db.query(table, orderBy: col_classid);
    List<Stuab> todlist = data.isNotEmpty ? data.map((c) => Stuab.fromMap(c)).toList() : [];
    List<Stuab> ablist = [];
    todlist.forEach((element) {
      if(element.stuid == stuid){
        ablist.add(element);
      }
    });
    return todlist;
  }

  Future<int> add(Stuab stuab) async {
    Database db = await instance.database;
    return await db.insert(table, stuab.toMap());
  }

  void removestutod(int stuid) async {
    Database db = await instance.database;
    var tods = await db.query(table, orderBy: col_classid);
    List<Stuab> todlist = tods.isNotEmpty ? tods.map((c) => Stuab.fromMap(c)).toList() : [];
    todlist.forEach((element) async {
      if(stuid == element.stuid) {
        await db.delete(
          table,
          where: '$col_id = ?',
          whereArgs: [stuid]
        );
      }
    });
  }

  Future<int> update(Stuab stu) async {
    Database db = await instance.database;
    return await db.update(
        table,
        stu.toMap(),
        where: "id = ?",
        whereArgs: [stu.id]
    );
  }

  Future<int> upab(int id,int ab) async {
    Database db = await instance.database;
    return await db.update(
      table,
      {
        col_ab: ab,
      },
      where: "id = ?",
      whereArgs: [id]
    );
  }


}

 */