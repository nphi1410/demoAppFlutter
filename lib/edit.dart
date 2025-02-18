import 'package:flutter/material.dart';
import 'customerEntity.dart';
import 'data.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Customer savedCustomer;
  late String? editedName;
  late String? editedGender;
  late DateTime editedBirthday;
  late String? editedCountry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    savedCustomer = ModalRoute.of(context)!.settings.arguments as Customer;
    editedName = savedCustomer.name;
    editedGender = savedCustomer.gender;
    editedBirthday = savedCustomer.birthday;
    editedCountry = savedCustomer.country;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Edit customer'),
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
                TextFormField(
                  initialValue: editedName,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        editedName = value;
                      });
                    } else {
                      setState(() {
                        editedName = null;
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
                    errorText: editedName == null ? '* Please fill this field' : null,
                  ),
                ),
                SizedBox(height: 20),
                // Date picker
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${editedBirthday.day}/${editedBirthday.month}/${editedBirthday.year} ',
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: editedBirthday,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (newDate != null) {
                          setState(() {
                            editedBirthday = newDate;
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
                      groupValue: editedGender,
                      onChanged: (value) {
                        setState(() {
                          editedGender = value as String?;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: editedGender,
                      onChanged: (value) {
                        setState(() {
                          editedGender = value as String?;
                        });
                      },
                    ),
                    Text('Female'),
                    Radio(
                      value: 'Other',
                      groupValue: editedGender,
                      onChanged: (value) {
                        setState(() {
                          editedGender = value as String?;
                        });
                      },
                    ),
                    Text('Other'),
                  ],
                ),

                if(editedGender == null)
                  Text('* Please select gender', style: TextStyle(color: Colors.red,),),
                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  hint: Text('Select a country'),
                  value: editedCountry,
                  onChanged: (newValue) {
                    setState(() {
                      editedCountry = newValue; // Update editedCountry when a new value is selected
                    });
                  },
                  items: countries.map<DropdownMenuItem<String>>((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                ),
                if (editedCountry == null) // Display validation message if no country is selected
                  Text('* Please select a country', style: TextStyle(color: Colors.red)),
                SizedBox(height: 20),
                // Submit button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if(editedName != null && editedGender != null && editedCountry != null){
                            Customer editedCustomer = Customer(id: savedCustomer.id ,name: editedName, birthday: editedBirthday, gender: editedGender, country: editedCountry);
                            updateData(editedCustomer);
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
