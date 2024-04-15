import 'package:crud_app_demo/customerEntity.dart';
import 'package:crud_app_demo/data.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? selectedGender;
  DateTime birthday = DateTime.now();
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Create customer'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Other input fields
                  TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          name = value;
                        });
                      } else {
                        setState(() {
                          name = null;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      errorText: name == null ? '* Please fill this field' : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Date picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${birthday.day}/${birthday.month}/${birthday.year} ',
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: birthday,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (newDate != null) {
                            setState(() {
                              birthday = newDate;
                            });
                          }
                        },
                        child: Text('Choose date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Gender selection
                  Row(
                    children: [
                      Text(
                        'Gender:',
                        style: TextStyle(fontSize: 20),
                      ),
                      Radio(
                        value: 'Male',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String?;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: 'Female',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String?;
                          });
                        },
                      ),
                      Text('Female'),
                      Radio(
                        value: 'Other',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String?;
                          });
                        },
                      ),
                      Text('Other'),
                    ],
                  ),

                  if(selectedGender == null)
                    Text('* Please select gender', style: TextStyle(color: Colors.red,),),
                  SizedBox(height: 20),
                  // Dropdown selection with validation
                  DropdownButtonFormField<String>(
                    hint: Text('Select a country'),
                    value: selectedCountry,
                    onChanged: (newValue) {
                      setState(() {
                        if(newValue != null){
                          selectedCountry = newValue;
                        } else {
                          selectedCountry = null;
                        }

                      });
                    },
                    items: countries.map<DropdownMenuItem<String>>((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                  ),
                  if (selectedCountry == null)
                    Text('* Please select a country', style: TextStyle(color: Colors.red,),),
                  SizedBox(height: 20),
                  // Submit button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if(name != null && selectedGender != null && selectedCountry != null){
                              Customer newCustomer = Customer(name: name, birthday: birthday, gender: selectedGender, country: selectedCountry);
                              listCustomer.add(newCustomer);
                              Navigator.pushNamed(context, 'home');
                            }
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

