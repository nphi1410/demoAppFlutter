import 'package:flutter/material.dart';
import 'customerEntity.dart';
import 'data.dart';



class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Customer> listCustomer = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromService();
  }

  Future<List<Customer>> fetchDataFromService() async {
    try {
      List<Customer> customers = await fetchData();
      return customers;
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }


  @override
  Widget build(BuildContext context) {
    final context1 = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    Text('Logout', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create');
                },
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<List<Customer>>(
                future: fetchDataFromService(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    listCustomer = snapshot.data!;
                    return DataTable(
                      columnSpacing: 10,
                      columns: [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Birthday')),
                        DataColumn(label: Text('Gender')),
                        DataColumn(label: Text('Country')),
                        DataColumn(
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Actions', textAlign: TextAlign.center,),
                          ),
                        ),

                      ],
                      rows: List<DataRow>.generate(listCustomer.length, (index) {
                        final customer = listCustomer[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(customer.name.toString())),
                            DataCell(Text(
                                '${customer.birthday.day.toString()}/${customer.birthday.month.toString()}/${customer.birthday.year.toString()}')),
                            DataCell(Text(customer.gender.toString())),
                            DataCell(Text(customer.country.toString())),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context1, 'edit', arguments: customer);
                                  },
                                  icon: Icon(Icons.create),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      deleteData(customer.id.toString());
                                    });
                                  },
                                  icon: Icon(Icons.delete),
                                )
                              ],
                            ))
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            )

          ),
        ),
      ),
    );
  }
}
