import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

class EmployeeProvider extends ChangeNotifier {
  // 직원 목록 상태
  final List<Employee> _empList = List.empty(growable: true);

  // 전체 직원 목록 조회
  List<Employee> get empList => _empList;

  // 직원 추가
  void addEmp(Employee e) {
    _empList.add(e);
    notifyListeners();
  }

  // 직원 삭제
  void removeEmp(int empNo) {
    _empList.remove(_empList.singleWhere((x) => x.empNo == empNo));
    notifyListeners();
  }

  // 사번으로 단건 조회
  Employee detailEmp(int empNo) {
    return _empList.singleWhere((x) => x.empNo == empNo);
  }

  // 직원 정보 수정
  Employee updateEmp(int empNo, Employee emp) {
    final index = _empList.indexWhere((x) => x.empNo == empNo);
    if (index != -1) {
      _empList[index] = emp;
      notifyListeners();
      return emp;
    }

    throw Exception('Employee with empNo $empNo not found');
  }
}
