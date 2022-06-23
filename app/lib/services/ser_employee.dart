// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:app/constants/constants.dart';
// import 'package:app/model/employee.dart';

// class Services {
//   static const ROOT = Constants.API_HOST + "woms_api/test.php";
//   static const CREATE_TABLE_ACTION = "CREATE_TABLE";
//   static const _GET_ALL_ACTION = "GET_ALL";
//   static const _ADD_EMP_ACTION = "ADD_EMP";
//   static const _UPDATE_EMP_ACTION = "UPDATE_EMP";
//   static const _DELETE_EMP_ACTION = "DELETE_EMP";

//   //Method for table sample
//   static Future<String> createTable() async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = CREATE_TABLE_ACTION;
//       final response = await http.post(ROOT, body: map);
//       print("Create Table Response : ${response.body}");
//       if (response.statusCode == 200) {
//         return response.body;
//       } else {
//         return "ERROR";
//       }
//     } catch (e) {
//       return "error";
//     }
//   }

//   static Future<List<Employee>> getEmployees() async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _GET_ALL_ACTION;
//       final response = await http.post(ROOT, body: map);
//       print("GET ALL");
//       if (response.statusCode == 200) {
//         List<Employee> list = parseResponse(response.body);
//         return list;
//       } else {
//         return <Employee>[];
//       }
//     } catch (e) {
//       return <Employee>[];
//     }
//   }

//   static List<Employee> parseResponse(String body) {
//     final parsed = json.decode(body).cast<Map<String, dynamic>>();
//     return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
//   }

//   static Future<String> addEmployee(String firstName, String lastName) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _ADD_EMP_ACTION;
//       map['first_name'] = firstName;
//       map['last_name'] = lastName;
//       final response = await http.post(ROOT, body: map);
//       print("addEmployee ALL");
//       if (response.statusCode == 200) {
//         return response.body;
//       } else {
//         return "ERROR";
//       }
//     } catch (e) {
//       return "ERROR";
//     }
//   }

//   static Future<String> updateEmployee(
//       int empId, String firstName, String lastName) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _UPDATE_EMP_ACTION;
//       map['emp_id'] = empId;
//       map['first_name'] = firstName;
//       map['last_name'] = lastName;
//       final response = await http.post(ROOT, body: map);
//       print("updateEmployee ALL");
//       if (response.statusCode == 200) {
//         return response.body;
//       } else {
//         return "ERROR";
//       }
//     } catch (e) {
//       return "ERROR";
//     }
//   }

//   static Future<String> deleteEmployee(int empId) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _DELETE_EMP_ACTION;
//       map['emp_id'] = empId;
//       final response = await http.post(ROOT, body: map);
//       print("deleteEmployee ALL");
//       if (response.statusCode == 200) {
//         return response.body;
//       } else {
//         return "ERROR";
//       }
//     } catch (e) {
//       return "ERROR";
//     }
//   }
// }
