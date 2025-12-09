import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_update.dart';
import 'package:provider/provider.dart';

class DetailEmp extends StatefulWidget {
  final Function(Employee) onRemoveEmp; // 삭제 콜백
  final int detailEmpNo;

  const DetailEmp({
    required this.onRemoveEmp,
    required this.detailEmpNo,
    super.key,
  });

  @override
  State<DetailEmp> createState() => _DetailEmpState();
}

class _DetailEmpState extends State<DetailEmp> {
  @override
  Widget build(BuildContext context) {
    // 직원 데이터 상태 접근
    final provider = Provider.of<EmployeeProvider>(context);
    // 전달된 사번으로 상세 정보 조회
    Employee emp = provider.detailEmp(widget.detailEmpNo);

    return Scaffold(
      appBar: AppBar(title: Text("Employee Detail")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('이름 : ${emp.name}'),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('전화번호 : ${emp.phone}'),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('부서 : ${emp.dept}'),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('사원번호 : ${emp.empNo}'),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('월급 : ${emp.salary}'),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('계좌번호 : ${emp.account}'),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: Text('직급 : ${emp.position}'),
            ),
            SizedBox(height: 20),
            Row(children: [
              ElevatedButton(
                // 수정 화면 이동 후 업데이트 확인
                onPressed: () async {
                  final updatedEmp = await Navigator.push<Employee>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateEmp(
                        employee: emp,
                        onUpdateEmp: (Employee updated) {
                          Navigator.pop(context, updated);
                        },
                      ),
                    ),
                  );

                  if (!mounted || updatedEmp == null) return;
                  _updateEmpData(emp.empNo, updatedEmp);
                },
                child: Text("Update"),
              ),
              ElevatedButton(
              // 삭제 확인 팝업 호출
              onPressed: () => _confirmRemove(emp.empNo),
              child: Text("Deleted"),
            ),
            ],)
            
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRemove(int empNo) async {
    // 삭제 확인 다이얼로그
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('삭제 확인'),
        content: Text('삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (result == true) {
      _removeEmpData(empNo);
    }
  }

  Future<void> _updateEmpData(int empNo, Employee updatedEmp) async {
    final provider = Provider.of<EmployeeProvider>(
      context,
      listen: false,
    );
    provider.updateEmp(empNo, updatedEmp);
    setState(() {}); // Yes 선택 시 상세 화면 갱신
  }

  void _removeEmpData(int empNo) {
    // Provider 통해 삭제 후 화면 종료
    final provider = Provider.of<EmployeeProvider>(
      context,
      listen: false,
    );
    provider.removeEmp(empNo);
    Navigator.pop(context);
  }
}
