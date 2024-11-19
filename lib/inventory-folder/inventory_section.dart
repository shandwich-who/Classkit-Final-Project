import 'package:flutter/material.dart';

class InventorySection extends StatefulWidget {
  const InventorySection({super.key});

  @override
  State<InventorySection> createState() => _InventorySectionState();
}

class _InventorySectionState extends State<InventorySection> {
  List<Map<String, dynamic>> tableData = [
    {"prdId": "001", "prdName": "Coke", "price": 20.00, "quantity": 10},
    {"prdId": "002", "prdName": "Pepsi", "price": 15.00, "quantity": 10}
  ];

  // Controllers for adding new rows
  final TextEditingController prdIdController = TextEditingController();
  final TextEditingController prdNameController = TextEditingController();
  final TextEditingController prcController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  void _addRow() {
    setState(() {
      tableData.add({
        "prdId": prdIdController.text,
        "prdName": prdNameController.text,
        "price": double.tryParse(prcController.text) ?? 0.0,
        "quantity": int.tryParse(qtyController.text) ?? 0,
      });
    });

    // Clear the input fields
    prdIdController.clear();
    prdNameController.clear();
    prcController.clear();
    qtyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FlexColumnWidth(2), // Product ID column
              1: FlexColumnWidth(3), // Product Name column
              2: FlexColumnWidth(2), // Price column
              3: FlexColumnWidth(2), // Quantity column
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Product ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Product Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Quantity",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tableData.length,
              itemBuilder: (context, index) {
                final row = tableData[index];
                return Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(row["prdId"] ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(row["prdName"] ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(row["price"].toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(row["quantity"].toString()),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: prdIdController,
                  decoration: const InputDecoration(labelText: "Product ID"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: prdNameController,
                  decoration: const InputDecoration(labelText: "Product Name"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: prcController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: qtyController,
                  decoration: const InputDecoration(labelText: "Quantity"),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addRow,
                child: const Text("Add"),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
// //* this is for the app bar
// class InventoryAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const InventoryAppBar({super.key});
//
//   @override
//   State<InventoryAppBar> createState() => _InventoryAppBarState();
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
//
// class _InventoryAppBarState extends State<InventoryAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text(
//         "Inventory",
//         style: TextStyle(color: Colors.blueAccent),
//       ),
//       centerTitle: true,
//       backgroundColor: const Color(0xffFFB38E),
//     );
//   }
// }

// //* this is for the body
// class InventorySection extends StatefulWidget {
//   const InventorySection({super.key});
//
//   @override
//   State<InventorySection> createState() => _InventorySectionState();
// }
//
// class _InventorySectionState extends State<InventorySection> {
//   final List<String> items = [
//     "item 1",
//     "item 2",
//     "item 1",
//     "item 2",
//     "item 1",
//     "item 2",
//     "item 1",
//     "item 2"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         // SliverAppBar for collapsing effect
//         SliverAppBar(
//           // expandedHeight: 200.0,
//           pinned: false,
//           flexibleSpace: FlexibleSpaceBar(
//             title: const Text('Sliver Card List'),
//             // background: Image.network(
//             //   'https://source.unsplash.com/random/800x600',
//             //   fit: BoxFit.cover,
//             // ),
//           ),
//         ),
//
//         // SliverList for the card items
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blueAccent,
//                       child: Text(items[index][0]),
//                     ),
//                     title: Text(items[index]),
//                     subtitle: const Text('This is a subtitle'),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Action on card tap
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Tapped on ${items[index]}')),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//             childCount: items.length, // Number of items in the list
//           ),
//         ),
//       ],
//     );
//   }
// }
