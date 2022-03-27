import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast_demo/product/product.dart';
import 'package:sembast_demo/product/product_list_controller.dart';

class ProductList extends GetView<ProductListController> {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductListController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await controller.addProduct();
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            Product p = controller.products[index];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(p.id),
                    subtitle: Text(p.name),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      controller.nameToUpdate.value.text = '';
                      Get.defaultDialog(
                          title: '修改產品名稱',
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: controller.nameToUpdate.value,
                              ))
                            ],
                          ),
                          confirm: ElevatedButton(
                              onPressed: () async {
                                await controller.updateProduct(p.id);
                                Get.back();
                              },
                              child: const Text('確定')),
                          cancel: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('取消')));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      await controller.deleteProduct(p);
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
