import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loginpage/main.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool showList = false;

  Future<List<dynamic>> getMedicineList() async {
    Dio dio = Dio();
    final response = await dio.get("$url/get_inventory/");
    final responseData = response.data;
    return responseData['medicines'];
  }

  late List<dynamic> medicinelist;
  late Iterable<dynamic> sublist;
  List<String> selectedMedication = [];

  void fetchMedicineList() async {
    Dio dio = Dio();
    final response = await dio.get("$url/medicinelist");
    final responseData = response.data;
    medicinelist = responseData['medicines'];
    sublist = medicinelist;
  }

  @override
  void initState() {
    super.initState();
    fetchMedicineList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: const Color(0xFFF2F3F8),
            labelText: 'Search Medicine',
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: Icon(showList ? Icons.arrow_upward : Icons.arrow_downward),
              onPressed: () {
                setState(() {
                  showList = !showList;
                });
              },
            ),
          ),
          onChanged: (text) {
            if (!showList) {
              return;
            }
            setState(() {
              sublist = medicinelist.where(
                (element) {
                  return element['name']
                      .toString()
                      .toLowerCase()
                      .contains(text.toLowerCase());
                },
              );
            });
          },
        ),
        if (showList)
          Container(
            height: 150,
            child: ListView.builder(
              itemCount: sublist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (selectedMedication
                        .contains("${sublist.toList()[index]['name']}")) {
                      return;
                    }
                    setState(() {
                      selectedMedication
                          .add("${sublist.toList()[index]['name']}");
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      "${sublist.toList()[index]['name']}",
                    ),
                  ),
                );
              },
            ),
          ),
        Container(
          width: double.infinity,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < selectedMedication.length; i++)
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${i + 1}. ${selectedMedication[i]}"),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 42, 58, 226),
                                  Color.fromARGB(255, 112, 145, 243)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Set Schedule",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedMedication = selectedMedication
                                    .where((element) =>
                                        element != selectedMedication[i])
                                    .toList();
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
