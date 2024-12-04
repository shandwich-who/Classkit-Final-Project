import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finals/service-folder/firestore.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PosSection extends StatefulWidget {
  const PosSection({super.key});

  @override
  State<PosSection> createState() => _PosSectionState();
}

class _PosSectionState extends State<PosSection> {
  final TextEditingController _searchController = TextEditingController();
  final FireStoreService _fireStoreService = FireStoreService();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  String searchQuery = '';
  bool isConnected = true;
  final FireStoreService firebaseFirestore = FireStoreService();

  @override
  void initState() {
    super.initState();
    _checkNetworkConnection();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController;
  }

  Future<void> _checkNetworkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    setState(() {
      isConnected =
          connectivityResult.contains(ConnectivityResult.none) ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isConnected
          ? CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // AppBar with Search Bar
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      "CLASS KIT",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    titlePadding: EdgeInsets.only(bottom: 80),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        height: 30,
                        width: 30,
                        child: Lottie.asset(
                          "assets/animation/reveal-cart-black.json",
                          reverse: true,
                          repeat: true,
                        ),
                      ),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        focusNode: _searchFocusNode,
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search items...',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Lottie.asset(
                              "assets/animation/reveal-search.json",
                              repeat: true,
                              reverse: true,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _fireStoreService.readData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('Error loading data.')),
                      );
                    }
                    final items = snapshot.data?.docs ?? [];
                    final filteredItems = items.where((item) {
                      final name = item['name']?.toString().toLowerCase() ?? '';
                      return name.contains(searchQuery);
                    }).toList();

                    if (filteredItems.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('No items found.')),
                      );
                    }

                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = filteredItems[index];
                          return GestureDetector(
                            onTap: () {
                              _showAddToCartDialog(context, item['name'],
                                  item['price'], item['quantity']);
                            },
                            child: Card(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/school.png",
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['name'] ?? 'Unnamed Item',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: filteredItems.length,
                      ),
                    );
                  },
                ),
              ],
            )
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No internet connection.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Please check your connection.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showAddToCartDialog(BuildContext context, String itemName,
      double itemPrice, int itemQuantity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Item Details",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          content: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Name: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(itemName, style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Price: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("$itemPrice", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Quantity: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("$itemQuantity", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Text("Cancel")),
                  ElevatedButton(
                    onPressed: () {
                      _fireStoreService.addToCart(
                          itemName, itemPrice, itemQuantity);
                      showMessage(
                          context: context,
                          message: "Item added to cart",
                          duration: Duration(seconds: 1),
                          typeColor: AnimatedSnackBarType.success);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text("Add to Cart"),
                  ),
                  // add color design in the button
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
