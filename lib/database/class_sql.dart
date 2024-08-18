
/*
class classdata {

  classdata._Constructor();
  static final classdata instance = classdata._Constructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  static const String table = 'classlists';

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'class_databse.db');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
       ''' 
       CREATE TABLE $table(
           $col_id INTEGER PRIMARY KEY,
           $col_dep INTEGER,
           $col_year INTEGER,
           $col_deindex INTEGER,
           $col_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
       )
       '''
    );
  }

  Future<List<Classes>> getlist() async {
    Database db = await instance.database;
    List<Map<String, Object?>> clas = await db.query(table, orderBy: col_year);
    List<Classes> classlist = clas.isNotEmpty ? clas.map((Map<String, dynamic> map)  => Classes.fromMap(map)).toList() : [];
    return classlist;
  }

  Future<int> add(int dep,int year) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      {col_dep: dep, col_year: year,col_deindex: 0},
    );
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$col_id = ?', whereArgs: [id]);
  }

  Future<int> upfocus(int id) async {
    Database db = await instance.database;
    var clas = await db.query(table, orderBy: col_year);
    List<Classes> classlist = clas.isNotEmpty ? clas.map((c) => Classes.fromMap(c)).toList() : [];
    classlist.forEach((element) async {
      await db.update(
          table,
          {col_deindex: 0},
          where: "$col_id = ?",
          whereArgs: [element.id]
      );
    });
    return await db.update(
        table,
        {col_deindex: 1},
        where: "$col_id = ?",
        whereArgs: [id]
    );
  }

}

 */
