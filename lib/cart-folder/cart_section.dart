import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/service-folder/firestore.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';

final FireStoreService _fireStoreService = FireStoreService();
final Set<String> _selectedItems = {};

class CartSection extends StatefulWidget {
  const CartSection({super.key});

  @override
  State<CartSection> createState() => _CartSectionState();
}

class _CartSectionState extends State<CartSection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(
                "CART",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              clipBehavior: Clip.none,
              elevation: 5,
              shadowColor: Colors.black,
              forceElevated: true,
              leading: IconButton(
                onPressed: () {
                  FluroRouterSetup.router.navigateTo(
                    context,
                    '/posScaffold',
                    transition: TransitionType.custom,
                    transitionDuration: const Duration(seconds: 1),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: FadeTransition(
                          opacity: ReverseAnimation(secondaryAnimation),
                          child: child,
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),
            SliverSafeArea(
              sliver: StreamBuilder<QuerySnapshot>(
                stream: _fireStoreService.readCart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('No data found!'),
                      ),
                    );
                  }

                  final documents = snapshot.data!.docs;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final doc = documents[index];
                        final data = doc.data() as Map<String, dynamic>;
                        final itemId = doc.id;

                        return Dismissible(
                          key: Key(itemId),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            return await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Delete'),
                                      content: Text(
                                          'Are you sure you want to remove "${data['name']}"?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (_) {
                            setState(() {
                              _selectedItems
                                  .remove(itemId); // Remove from selected items
                            });
                            _fireStoreService.deleteCart(itemId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${data['name']} removed'),
                              ),
                            );
                          },
                          child: Card(
                            borderOnForeground: true,
                            elevation: 5,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.all(5.0),
                            child: ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: _selectedItems.contains(itemId),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          _selectedItems.add(itemId);
                                        } else {
                                          _selectedItems.remove(itemId);
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: Image.asset("images/school.png")
                                            .image,
                                        filterQuality: FilterQuality.medium,
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              title: Text('${data['name']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '₱ ${(data['price'] * (data['quantity'] ?? 1)).toStringAsFixed(2)}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () async {
                                      if (data['quantity'] > 1) {
                                        setState(() {
                                          data['quantity']--;
                                        });
                                        await _fireStoreService.updateCart(
                                            itemId, data['quantity']);
                                      }
                                    },
                                  ),
                                  Text('${data['quantity']}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () async {
                                      setState(() {
                                        data['quantity']++;
                                      });
                                      await _fireStoreService.updateCart(
                                          itemId, data['quantity']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: documents.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        if (_selectedItems.isNotEmpty)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                _showCheckoutDialog(context);
              },
              label: Text('Checkout (${_selectedItems.length})'),
              icon: const Icon(Icons.shopping_cart),
              backgroundColor: Colors.black,
            ),
          ),
      ],
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Checkout'),
          content: Text(
              'You have selected ${_selectedItems.length} items for checkout. Proceed?'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _proceedToCheckout();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text('Proceed'),
                    ),
                  ]),
            ),
          ],
        );
      },
    );
  }

  void _proceedToCheckout() async {
    double totalPrice = 0;
    List<Map<String, dynamic>> itemsToCheckout = [];

    final cartDocs = await _fireStoreService.readCart().first;

    for (var item
        in cartDocs.docs.where((doc) => _selectedItems.contains(doc.id))) {
      final data = item.data() as Map<String, dynamic>;
      double price = data['price'] * (data['quantity'] ?? 1);
      totalPrice += price;

      itemsToCheckout.add({
        'id': item.id,
        'name': data['name'],
        'price': data['price'],
        'quantity': data['quantity'],
        'image': data['image'], // Assuming you store the image URL or path.
      });
    }

    _showPaymentDialog(mounted ? context : context, totalPrice, itemsToCheckout);
  }

  void _showPaymentDialog(BuildContext context, double totalPrice,
      List<Map<String, dynamic>> items) {
    final TextEditingController paymentController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Payment',textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(

                children: [
                  Text('Total Price: ₱ ${totalPrice.toStringAsFixed(2)}'),
                ],
              ),
              TextField(
                controller: paymentController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Enter payment amount'),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(16),
                          ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double payment =
                          double.tryParse(paymentController.text) ?? 0;
                      if (payment >= totalPrice) {
                        double change = payment - totalPrice;
                        Navigator.of(context).pop();
                        _showReceiptDialog(
                            context, items, totalPrice, payment, change);
                      } else {
                        showMessage(
                            context: context,
                            message: "Insufficient payment. Please try again.",
                            typeColor: AnimatedSnackBarType.error,
                            duration: duration300);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                            
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(16),
                          ),
                    child: const Text('Proceed'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showReceiptDialog(
      BuildContext context,
      List<Map<String, dynamic>> items,
      double total,
      double payment,
      double change) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Class Kit - Receipt',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map((item) => ListTile(
                      leading: Image.asset("images/school.png",
                          width: 40, height: 40),
                      title: Text(item['name']),
                      subtitle: Text(
                          'Qty: ${item['quantity']}  Price: ₱${item['price']}'),
                    )),
                const Divider(),
                Text('Total: ₱ ${total.toStringAsFixed(2)}'),
                Text('Payment: ₱ ${payment.toStringAsFixed(2)}'),
                Text('Change: ₱ ${change.toStringAsFixed(2)}'),
                const SizedBox(height: 10),
                const Text('Thank you for your purchase!',
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  for (var item in items) {
                    await _fireStoreService.deleteCart(item['id']);
                  }
                  setState(() {
                    _selectedItems.clear();
                  });
                  showMessage(
                      context: mounted ? context : context,
                      message: "Check Out Completed",
                      typeColor: AnimatedSnackBarType.success,
                      duration: duration300);

                  Navigator.of(mounted ? context : context, rootNavigator: true)
                      .pop();
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }
}
