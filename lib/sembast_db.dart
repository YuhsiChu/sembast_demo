import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDB {
  static final SembastDB _singleton = SembastDB._internal();
  static SembastDB get instance => _singleton;
  SembastDB._internal();
  Database? _database;

  Future<Database> get database async {
    return _database ??= _database = await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    // 取要放db data的資料夾
    Directory dir = await getApplicationDocumentsDirectory();
    // 確保資料夾存在
    await dir.create(recursive: true);
    // 資料庫路徑
    String dbPath = join(dir.path, 'demo.db');
    // 開啟資料庫
    return await databaseFactoryIo.openDatabase(dbPath);

    // db = await databaseFactoryIo.openDatabase(dbPath, version: 2, onVersionChanged: (db, oldVersion, newVersion) async {
    //   if (oldVersion == 1) {
    // var store = intMapStoreFactory.store('shop');
    // await store.add(db, {'name':'alex','age':'28'});
    // await store.add(db, {'name':'alex','age':'28'});
    //     var store = StoreRef.main();
    //     await store.record('title').put(db, 'fuxx');
    //     var title = await store.record('title').get(db);
    //     print(title);
    //   }
    // });
  }
}
