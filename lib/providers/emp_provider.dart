import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

/// 직원(Employee) 데이터의 상태를 관리하는 Provider 클래스입니다.
///
/// [EmployeeProvider]는 ChangeNotifier를 상속받아 직원 목록의 상태 변화를 관리합니다.
/// 외부 위젯에서는 provider를 구독(subscribe)하여 직원 데이터가 변경될 때마다
/// 자동으로 화면을 업데이트할 수 있습니다.
///
/// 주요 기능은 다음과 같습니다:
/// 1. 전체 직원 목록 조회 (empList)
/// 2. 직원 신규 추가 (addEmp)
/// 3. 직원 삭제 (removeEmp)
/// 4. 사번(empNo)으로 개별 직원 상세 조회 (detailEmp)
/// 5. 개별 직원 정보 수정 (updateEmp)
class EmployeeProvider extends ChangeNotifier {
  /// 내부 직원 정보 리스트 (상태 저장)
  final List<Employee> _empList = List.empty(growable: true);

  /// 전체 직원 목록을 반환합니다.
  /// 데이터의 변경(추가/삭제/수정 등)에 따라 Provider를 구독 중인 위젯이 자동 갱신됩니다.
  List<Employee> get empList => _empList;

  /// 새로운 직원(Employee)을 추가합니다.
  /// 추가 후, notifyListeners()를 호출하여 구독자에게 변경 사실을 알립니다.
  void addEmp(Employee e) {
    _empList.add(e);
    notifyListeners();
  }

  /// 사번(empNo)으로 직원 정보를 찾아 삭제합니다.
  /// 삭제 후, notifyListeners() 호출로 UI에 반영되도록 합니다.
  void removeEmp(int empNo) {
    _empList.remove(_empList.singleWhere((x) => x.empNo == empNo));
    notifyListeners();
  }

  /// 사번(empNo)으로 개별 직원(Employee) 정보를 단일 조회합니다.
  /// 일치하는 사번이 없으면 예외를 발생시킵니다.
  Employee detailEmp(int empNo) {
    return _empList.singleWhere((x) => x.empNo == empNo);
  }

  /// 사번(empNo)에 해당하는 직원의 정보를 수정합니다.
  /// 기존 사번과 동일한 새 Employee 객체(emp)를 전달하면 해당 정보로 대체됩니다.
  /// 수정 후 notifyListeners() 호출로 변경 내용이 UI에 반영됩니다.
  /// 일치하는 사번이 없으면 예외를 발생시킵니다.
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
