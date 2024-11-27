import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:finals/pos-folder/pos_scaffold.dart';
import 'package:get/get.dart';

import '../search-folder/search_scaffold.dart';

class BnbController extends GetxController {
  RxInt index = 0.obs;
  var pages = [
    const PosScaffold(),
    const SearchScaffold(),
    const InventoryScaffold()
  ];
}

BnbController controlNavBar = Get.put(BnbController());

// class UserController {
//   static Future<User?> loginWithGoogle() async {
//     final googleAccount = await GoogleSignIn().signIn();
//
//     final googleAuth = await googleAccount?.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//
//     final userCredential = await FirebaseAuth.instance.signInWithCredential(
//       credential,
//     );
//
//     return userCredential.user;
//   }
// }
