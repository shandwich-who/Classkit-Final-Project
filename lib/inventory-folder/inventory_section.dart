import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/service-folder/firestore.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/text-form-field-validator-folder/validator_section.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
final FireStoreService _fireStoreService = FireStoreService();
TextEditingController quantityController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController nameController = TextEditingController();

class InventorySection extends StatefulWidget {
  const InventorySection({super.key});

  @override
  State<InventorySection> createState() => _InventorySectionState();
}

class _InventorySectionState extends State<InventorySection> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStoreService.readData(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading inventory data.'));
        }

        final items = snapshot.data?.docs ?? [];
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No items found."));
        }

        return CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: false,
              centerTitle: true,
              backgroundColor: Colors.indigo,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("List of the Items"),
              ),
            ),
            SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final itemData =
                        items[index].data() as Map<String, dynamic>;
                    final currentDocID =
                        items[index].id; // Get the docID for this item
                    return ListItem(
                      itemId: itemData['item_id'],
                      name: itemData['name'],
                      price: itemData['price'],
                      quantity: itemData['quantity'],
                      onEdit: () =>
                          showEditForm(context, currentDocID, itemData),
                      onDelete: () async {
                        await _fireStoreService.deleteData(currentDocID);
                      },
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Item {
  final int itemId;
  final String name;
  final double price;
  final int quantity;

  // final String imageAsset;

  Item({
    required this.itemId,
    required this.name,
    required this.price,
    required this.quantity,
    // required this.imageAsset,
  });
}

class ListItem extends StatelessWidget {
  final int itemId;
  final String name;
  final double price;
  final int quantity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ListItem({
    super.key,
    required this.itemId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(itemId),
      background: Container(
        color: Colors.blue[900],
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red[900],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          final shouldDelete = await _confirmDelete(context);
          if (shouldDelete) {
            onDelete();
          }
          return shouldDelete;
        }
        return false;
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Image.asset("images/school.png").image,
                filterQuality: FilterQuality.medium,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            width: 50,
            height: 50,
          ),
          title: Text('$itemId: $name'),
          subtitle:
              Text('Price: ₱${price.toStringAsFixed(2)}, Quantity: $quantity'),
          // trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Confirm Delete',
              textAlign: TextAlign.center,
            ),
            titlePadding:
                EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 20),
            content: Text('Are you sure you want to delete "$name"?'),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        showMessage(
                            context: context,
                            duration: Duration(milliseconds: 1500),
                            message: "Already Deleted",
                            typeColor: AnimatedSnackBarType.info);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text('Delete'),
                    ),
                  )
                ],
              )
            ],
          ),
        ) ??
        false; // Default to false if the dialog is dismissed
  }
}

void showEditForm(
    BuildContext context, String? docID, Map<String, dynamic> data) {
  Widget textFormField({
    required String? labelText,
    required String? hintText,
    required TextInputType? keyboardType,
    required TextEditingController txtController,
    required String? Function(String?)? validator,
  }) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: txtController,
          keyboardType: keyboardType!,
          decoration: InputDecoration(
            labelText: labelText!,
            hintText: hintText,
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Edit Item : ${data['item_id']}",
          textAlign: TextAlign.center,
        ),
        titlePadding: EdgeInsets.fromLTRB(30, 30, 30, 15),
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          height: 220,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                textFormField(
                    labelText: "Name",
                    hintText: "${data['name']}",
                    keyboardType: TextInputType.text,
                    txtController: nameController,
                    validator: validateName),
                SizedBox(height: 20),
                textFormField(
                    labelText: "Price",
                    hintText: "${data['price']}",
                    keyboardType: TextInputType.number,
                    txtController: priceController,
                    validator: validatePrice),
                SizedBox(height: 20),
                textFormField(
                    labelText: "Quantity",
                    hintText: "${data['quantity']}",
                    keyboardType: TextInputType.number,
                    txtController: quantityController,
                    validator: validateQuantity),
              ]),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          nameController.clear();
                          priceController.clear();
                          quantityController.clear();
                          Navigator.of(context).pop(false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _fireStoreService.updateData(
                              docID!,
                              nameController.text,
                              double.parse(priceController.text),
                              int.parse(quantityController.text),
                            );
                            showMessage(
                                context: context,
                                duration: Duration(milliseconds: 1500),
                                message: "Already Updated",
                                typeColor: AnimatedSnackBarType.info);
                            nameController.clear();
                            priceController.clear();
                            quantityController.clear();
                            Navigator.of(context, rootNavigator: true).pop();
                          } else {
                            showMessage(
                                context: context,
                                duration: Duration(milliseconds: 1500),
                                message:
                                    "Please Fix the Errors Before you Proceed",
                                typeColor: AnimatedSnackBarType.error);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text("Update"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}
