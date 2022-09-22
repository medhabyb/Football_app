import 'package:flutter/material.dart';
import 'package:fmp/data/data.dart';
class Standings2020 extends StatefulWidget {
  const Standings2020({Key? key}) : super(key: key);

  @override
  _Standings2020State createState() => _Standings2020State();
}

class _Standings2020State extends State<Standings2020> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4373D9),
        appBar: AppBar(
          backgroundColor: Color(0xFF4373D9),
          elevation: 0.0,
          title: const Text(
            "STANDINGS 2020",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        //now we have finished the api service let's call it
        //Now befo re we create Our layout let's create our API service
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 15.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Teams'),
                  ),
                  DataColumn(
                    label: Text('P'),
                  ),
                  DataColumn(
                    label: Text('W'),
                  ),
                  DataColumn(
                    label: Text('D'),
                  ),
                  DataColumn(
                    label: Text('L'),
                  ),
                  DataColumn(
                    label: Text('GF'),
                  ),
                  DataColumn(
                    label: Text('GA'),
                  ),
                  DataColumn(
                    label: Text('+/-'),
                  ),
                  DataColumn(
                    label: Text('PTS'),
                  ),
                ],
                rows: <DataRow>[
                  for (var i in teams2020)
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Row(
                            children: [
                              Image.asset(
                                i.image,
                                width: 25.0,
                                height: 25.0,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(i.name),
                              const SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.p),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.w),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.d),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.l),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.gf),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.ga),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.plusorminus),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 25, //SET width
                            child: Text(i.pts),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}