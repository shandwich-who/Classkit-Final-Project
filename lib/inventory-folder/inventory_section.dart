import 'package:flutter/material.dart';

class InventorySection extends StatefulWidget {
  const InventorySection({super.key});


  static List<Item> inventoryItems = [
    Item(
      id: '001',
      name: 'Pencil',
      price: 10,
      quantity: 100,
      imageAsset: 'images/pencil.png',
    ),
    Item(
      id: '002',
      name: 'Eraser',
      price: 5,
      quantity: 100,
      imageAsset: 'images/eraser.png',
    ),
    Item(
      id: '001',
      name: 'Pencil',
      price: 10,
      quantity: 100,
      imageAsset: 'images/pencil.png',
    ),
    Item(
      id: '002',
      name: 'Eraser',
      price: 5,
      quantity: 100,
      imageAsset: 'images/eraser.png',
    ),
    Item(
      id: '001',
      name: 'Pencil',
      price: 10,
      quantity: 100,
      imageAsset: 'images/pencil.png',
    ),
    Item(
      id: '002',
      name: 'Eraser',
      price: 5,
      quantity: 100,
      imageAsset: 'images/eraser.png',
    ),
    Item(
      id: '001',
      name: 'Pencil',
      price: 10,
      quantity: 100,
      imageAsset: 'images/pencil.png',
    ),
    Item(
      id: '002',
      name: 'Eraser',
      price: 5,
      quantity: 100,
      imageAsset: 'images/eraser.png',
    ),
  ];
  
  get items => inventoryItems;

  @override
  State<InventorySection> createState() => _InventorySectionState();


}
class _InventorySectionState extends State<InventorySection> {
  @override
  Widget build(BuildContext context) {
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
              (context, index) {
                final item = widget.items[index];
                return ListItem(
                  id: item.id,
                  name: item.name,
                  price: item.price,
                  quantity: item.quantity,
                  imageAsset: item.imageAsset,
                  onEdit: () => showEditForm(context, item.id),
                  onDelete: () {
                    setState(() {
                      widget.items.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deleted item ${item.id}')),
                    );
                  },
                );
              },
              childCount: widget.items.length,
            ),
          ),
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
  final String imageAsset;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ListItem({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageAsset,
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
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Left to right: Trigger edit but prevent dismissal
          onEdit();
          return false; // Do not dismiss the item
        } else if (direction == DismissDirection.endToStart) {
          // Right to left: Confirm delete
          final shouldDelete = await _confirmDelete(context);
          if (shouldDelete) {
            onDelete();
          }
          return shouldDelete; // Dismiss only if confirmed
        }
        return false; // Default: do not dismiss
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black,),
            shape: BoxShape.circle,
          image: DecorationImage(
            image: Image.asset(imageAsset).image,
            filterQuality: FilterQuality.medium,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          ),
          width:50,
          height: 50,
          ),
          title: Text('$id: $name'),
          subtitle:
              Text('Price: ₱${price.toStringAsFixed(2)}, Quantity: $quantity'),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: Text('Are you sure you want to delete "$name"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false; // Default to false if the dialog is dismissed
  }
}

class EditForm extends StatelessWidget {
  final String itemId;

  const EditForm({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController();
    final TextEditingController priceController =
        TextEditingController();
    final TextEditingController quantityController =
        TextEditingController();

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

class Item {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageAsset;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageAsset,
  });
}

