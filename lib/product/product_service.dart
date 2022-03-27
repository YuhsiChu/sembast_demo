import 'package:sembast_demo/product/product.dart';
import 'package:sembast_demo/sembast_db.dart';
import 'package:sembast/sembast.dart';

class ProductService {
  Future<Database> get _db async => await SembastDB.instance.database;
  final store = intMapStoreFactory.store('product');

  Future<List<Product>> getAll() async {
    return (await store.find(await _db)).map((record) => Product.fromJson(record.value)).toList(growable: false);
  }

  Future<dynamic> insert(Product product) async {
    return await store.add(await _db, product.toJson());
  }

  Future<int> update(Product product) async {
    return await store.update(await _db, product.toJson(), finder: Finder(filter: Filter.equals('id', product.id)));
  }

  Future<int> delete(String id) async {
    return await store.delete(await _db, finder: Finder(filter: Filter.equals('id', id)));
  }

  Future<int> deleteAll() async {
    return await store.delete(await _db);
  }
}
