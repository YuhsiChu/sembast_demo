import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sembast_demo/product/product.dart';
import 'package:sembast_demo/product/product_service.dart';

class ProductListController extends GetxController {
  ProductService productService = ProductService();
  RxList<Product> products = <Product>[].obs;
  Rx<TextEditingController> nameToUpdate = TextEditingController().obs;
  int count = 0; // 已產出的產品數量

  @override
  Future<void> onInit() async {
    super.onInit();
    await productService.deleteAll();
  }

  Future<void> addProduct() async {
    String newId = (count++).toString();
    Product product = Product(id: newId, name: 'Product $newId');
    await productService.insert(product);
    products.value = await productService.getAll();
  }

  Future<void> updateProduct(String id) async {
    if (nameToUpdate.value.text != '') {
      Product product = Product(id: id, name: nameToUpdate.value.text);
      await productService.update(product);
      products.value = await productService.getAll();
    }
  }

  Future<void> deleteProduct(Product product) async {
    await productService.delete(product.id);
    products.value = await productService.getAll();
  }
}
