import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'customerEntity.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<List<Customer>> fetchData() async {
  var url = 'https://fluttermanager.000webhostapp.com/get.php';
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server returns a success response, parse the JSON
    List<dynamic> jsonData = jsonDecode(response.body);
    // Parse the JSON data into a list of Customer objects
    List<Customer> customers = jsonData.map<Customer>((json) => Customer.fromJson(json)).toList();

    return customers;
  } else {
    // If the server returns an error response, throw an exception
    throw Exception('Failed to load data');
  }
}

void insertData(Customer newCustomer) async {
  var url = 'https://fluttermanager.000webhostapp.com/post.php';

  // Create a Map containing the data to be sent in the request body
  Map<String, String> data = {
    'name': newCustomer.name.toString(),
    'birthday': newCustomer.birthday.toString(),
    'gender': newCustomer.gender.toString(),
    'country': newCustomer.country.toString(),
  };


  // Send a POST request with the data
  try {
    var response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(jsonEncode(data));
      print('Data inserted successfully');
    } else {
      // Request failed
      print('Failed to insert data: ${response.statusCode}');
    }
  } catch (e) {
    // An error occurred during the request
    print('Error: $e');
  }
}

void updateData(Customer editedCustomer) async {
  var url = 'https://fluttermanager.000webhostapp.com/put.php';

  // Create a Map containing the data to be sent in the request body
  Map<String, String> data = {
    'id': editedCustomer.id.toString(), // Assuming 'id' is needed for updating
    'name': editedCustomer.name.toString(),
    'birthday': editedCustomer.birthday.toString(),
    'gender': editedCustomer.gender.toString(),
    'country': editedCustomer.country.toString(),
  };

  // Send the PUT request
  try {
    var response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(jsonEncode(data));
      print('Data updated successfully');
    } else {
      // Request failed
      print('Failed to insert data: ${response.statusCode}');
    }
  } catch (e) {
    // An error occurred during the request
    print('Error: $e');
  }
}

void deleteData(String id) async {
  var url = 'https://fluttermanager.000webhostapp.com/delete.php';

  Map<String, String> data = {
    'id': id
  };

  // Send a POST request with the data
  try {
    var response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(jsonEncode(data));
      print('Data deleted successfully');
    } else {
      // Request failed
      print('Failed to delete data: ${response.statusCode}');
    }
  } catch (e) {
    // An error occurred during the request
    print('Error: $e');
  }
}




