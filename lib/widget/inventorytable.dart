import 'package:flutter/cupertino.dart';

class InventoryTable extends StatelessWidget {
  const InventoryTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: const [
        TableRow(children: [TableCell(child: Text('type')),
          TableCell(child: Text('size')),
          TableCell(child: Text('company')),
          TableCell(child: Text('price')),
          TableCell(child: Text('Quantity')),
          TableCell(child: Text('CP')),
          TableCell(child: Text('SP')),
        ]),

        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),

        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),
        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),
        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),
        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),
        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),
        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),
        TableRow(children: [TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
          TableCell(child: Text('')),
        ]),



      ],
    );
  }
}
