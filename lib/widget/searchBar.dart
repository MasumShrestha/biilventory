import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/updateForm.dart';

class SearchBarr extends StatelessWidget {
  const SearchBarr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              // Expanded(
              //   child: TextField(
              //     // controller: _searchController,
              //     decoration: const InputDecoration(
              //       hintText: 'Search',
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black)),
              //     ),
              //   ),
              // ),
              // IconButton(
              //   icon: const Icon(Icons.search),
              //   onPressed: () {
              //     // Perform search action here
              //   },
              // ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateForm(),
                        ));
                  },
                  child: const Text(
                    'Add Items',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
