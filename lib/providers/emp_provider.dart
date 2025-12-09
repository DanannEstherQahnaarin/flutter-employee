import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

class EmployeeProvider extends ChangeNotifier {
  final List<Employee> _empList = List.empty();

  List<Employee> get empList => _empList;

  void addEmp(Employee e) {
    _empList.add(e);
    notifyListeners();
  }

  void removeEmp(int empNo) {
    _empList.remove(_empList.singleWhere((x) => x.empNo == empNo));
    notifyListeners();
  }

  Employee detailEmp(int empNo) {
    return _empList.singleWhere((x) => x.empNo == empNo);
  }
}
