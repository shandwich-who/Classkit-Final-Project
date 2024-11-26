import 'package:flutter/material.dart';
class InventorySection extends StatefulWidget {
  const InventorySection({super.key});
  @override
  State<InventorySection> createState() => _InventorySectionState();
}
class _InventorySectionState extends State<InventorySection> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          // expandedHeight: 100,
          pinned: false,
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("Inventory"),
          ),
        ),
        SliverSafeArea(
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListItem(
                id: '00$index',
                name: 'Item $index',
                price: 10.0 + index,
                quantity: 100 - index,
                imageUrl:
                    'https://example.com/image_$index.jpg', 
                onEdit: () => showEditForm(context, '00$index'),
                onDelete: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deleted item 00$index')),
                  );
                },
              );
            },
            childCount: 10, // Replace with your dynamic list count
          )),
        ),
      ],
    );
  }
}
void showEditForm(BuildContext context, String itemId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditForm(itemId: itemId),
      );
    },
  );
}
class ListItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ListItem({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.onEdit,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
        } else if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: const CircleAvatar(
              // backgroundImage: AssetImage('assets/images/item_$index.png'), 
              ),
          title: Text('$id: $name'),
          subtitle:
              Text('Price: \$${price.toStringAsFixed(2)}, Quantity: $quantity'),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
// Edit Form Modal Bottom Sheet
class EditForm extends StatelessWidget {
  final String itemId;
  const EditForm({super.key, required this.itemId});
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: 'Item Name');
    final TextEditingController priceController =
        TextEditingController(text: '10.0');
    final TextEditingController quantityController =
        TextEditingController(text: '100');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Edit Item $itemId',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle save logic
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item $itemId updated!')),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CustomScrollView(
//       slivers: [
//         const SliverAppBar(
//           pinned: true,
//           flexibleSpace: FlexibleSpaceBar(
//             title: Text("Inventory"),
//             centerTitle: true,
//           ),
//           backgroundColor: Colors.black,
//         ),
//         SliverSafeArea(
//           sliver: SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 20, left: 20, right: 20, bottom: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                   color: Colors.black,
//                                   style: BorderStyle.solid,
//                                   width: 2),
//                             ),
//                             child: Image.asset(
//                               "images/eraser.png",
//                               height: 50,
//                               width: 50,
//                             ),
//                           ),
//                           const Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Id: 001"),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Name: Eraser"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     //next 
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
