import 'package:flutter/material.dart';
import 'data.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
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
                    Icon(Icons.arrow_back,color: Colors.white,),
                    Text('Logout',style: TextStyle(color: Colors.white,fontSize: 20)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create');
                },
                icon: Icon(Icons.add,color: Colors.white,),
              ),
            ],
          ),
        ),
          body:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 30,
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Birthday')),
                DataColumn(label: Text('Gender')),
                DataColumn(label: Text('Country')),
                DataColumn(label: Text('Actions')),
              ],
              rows: List<DataRow>.generate(listCustomer.length, (index) {
                final customer = listCustomer[index];
                return DataRow(
                  cells: [
                    DataCell(Text(customer.name.toString())),
                    DataCell(Text('${customer.birthday.day.toString()}/${customer.birthday.month.toString()}/${customer.birthday.year.toString()}')),
                    DataCell(Text(customer.gender.toString())),
                    DataCell(Text(customer.country.toString())),
                    DataCell(Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'edit', arguments: index);
                          },
                          icon: Icon(Icons.create),
                        ),
                        IconButton(
                            onPressed: (){
                              setState(() {
                                listCustomer.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ))
                  ],
                );
              }).toList(),
            ),
          ),
      ),
    );
  }
}
