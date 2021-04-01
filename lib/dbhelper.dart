import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:review_app/Models/feedback.dart';

import 'Models/offlineFeedBack.dart';
class dbhelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }
  initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'Feedback.db');
    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE feedbacks ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerName TEXT,"
        "phone  TEXT,"
        "email TEXT,"
        "city TEXT,"
        "country TEXT,"
        "comment TEXT,"
        "image TEXT,"
        "categoryId INTEGER,"
        "subCategoryId INTEGER,"
        "businessId INTEGER,"
        "overallRating REAL,"
        "customerFeedBacks TEXT"
        ")");
  }
  Future<int> addFeedBacks(feedback f) async {
    print("fgghdghfgh"+f.toString());
    var dbClient = await db;
    return 1;
    // var result = await dbClient.insert("feedbacks",{"customerName":f.customerName,"phone":f.phone,"email":f.email,"city":f.city,"country":f.country,"comment":f.comment,"image":f.image,"categoryId":f.categoryId,"subCategoryId":f.subCategoryId,"businessId":f.businessId,"overallRating":f.overallRating,"customerFeedBacks":jsonEncode(f.customerFeedBacks)});
    // return result;
  }
  Future<List> getFeedBacks() async {
    var dbClient= await db;
    var result = await dbClient.rawQuery('SELECT * FROM feedbacks');
    return result.toList();
  }
}