import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:finals/pos-folder/pos_scaffold.dart';
import 'package:finals/search-folder/search_scaffold.dart';
import 'package:get/get.dart';
class botNavBarController extends GetxController{
  RxInt index = 0.obs;
  var pages = [
    const PosScaffold(),
    const SearchScaffold(),
    const InventoryScaffold()
  ];
}


botNavBarController controlNavBar = Get.put(botNavBarController());