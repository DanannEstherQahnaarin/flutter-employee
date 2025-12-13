import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_update.dart';
import 'package:provider/provider.dart';

// 직원 상세 정보를 표시하고 수정/삭제 기능을 제공하는 StatefulWidget
class DetailEmp extends StatefulWidget {
  final Function(Employee) onRemoveEmp; // 직원 삭제 시 부모에게 알리기 위한 콜백
  final int detailEmpNo; // 상세조회를 위한 직원번호

  const DetailEmp({
    required this.onRemoveEmp,
    required this.detailEmpNo,
    super.key,
  });

  @override
  State<DetailEmp> createState() => _DetailEmpState();
}

// 상세 화면의 상태를 관리하는 State 클래스
class _DetailEmpState extends State<DetailEmp> {
  @override
  Widget build(BuildContext context) {
    // EmployeeProvider를 통해 전체 직원 데이터 상태에 접근
    final provider = Provider.of<EmployeeProvider>(context);
    // 전달받은 사번(detailEmpNo)로 상세 직원 정보 조회
    Employee emp = provider.detailEmp(widget.detailEmpNo);

    // 상세 정보 화면 UI 구성 시작
    return Scaffold(
      appBar: AppBar(title: Text("Employee Detail")), // 상단 앱바
      body: Padding(
        padding: const EdgeInsets.all(20), // 전체 패딩
        child: ListView(
          children: [
            // ----- 직원 이름 표시 카드 -----
            Card(
              elevation: 0, // 그림자 없음
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('이름 : ${emp.name}'),
            ),
            // ----- 직원 전화번호 표시 카드 -----
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('전화번호 : ${emp.phone}'),
            ),
            // ----- 부서 표시 카드 -----
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('부서 : ${emp.dept}'),
            ),
            // ----- 사원번호 표시 카드 -----
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('사원번호 : ${emp.empNo}'),
            ),
            // ----- 월급 표시 카드 -----
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('월급 : ${emp.salary}'),
            ),
            // ----- 계좌번호 표시 카드 -----
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('계좌번호 : ${emp.account}'),
            ),
            // ----- 직급 표시 카드 -----
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('직급 : ${emp.position}'),
            ),
            SizedBox(height: 20), // 버튼들과 목록 간 간격
            // ----- 수정/삭제 버튼 행 -----
            Row(
              children: [
                // ---- 수정 버튼 ----
                ElevatedButton(
                  // '수정' 버튼 클릭 시 UpdateEmp 화면으로 이동
                  onPressed: () async {
                    // 수정 화면 이동 후 결과로 수정 Employee 객체를 받음
                    final updatedEmp = await Navigator.push<Employee>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateEmp(
                          employee: emp,
                          // UpdateEmp 내에서 수정 완료 시 콜백
                          onUpdateEmp: (Employee updated) {
                            // UpdateEmp에서 넘어올 때 수정 Employee 전달
                            Navigator.pop(context, updated);
                          },
                        ),
                      ),
                    );

                    // 만약 위젯이 마운트 해제되었거나, 수정 안하고 돌아온 경우 아무 것도 하지 않음
                    if (!mounted || updatedEmp == null) return;
                    // 수정된 데이터 적용(Provider에 반영)
                    _updateEmpData(emp.empNo, updatedEmp);
                  },
                  child: Text("Update"),
                ),
                // ---- 삭제 버튼 ----
                ElevatedButton(
                  // '삭제' 버튼 클릭 시 삭제 확인 팝업 호출
                  onPressed: () => _confirmRemove(emp.empNo),
                  child: Text("Deleted"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ----- 삭제 전 확인 다이얼로그 표시 함수 -----
  Future<void> _confirmRemove(int empNo) async {
    // 삭제 의사를 묻는 AlertDialog 생성
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('삭제 확인'), // 다이얼로그 타이틀
        content: Text('삭제하시겠습니까?'), // 안내 메시지
        actions: [
          // 취소 버튼: No
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          // 확인 버튼: Yes
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    // 사용자가 Yes를 눌렀을 때만 삭제 진행
    if (result == true) {
      _removeEmpData(empNo);
    }
  }

  // ----- 직원 정보 수정 처리 함수 -----
  Future<void> _updateEmpData(int empNo, Employee updatedEmp) async {
    final provider = Provider.of<EmployeeProvider>(
      context,
      listen: false, // listen: false로 상태 변경 시 widget 리빌드 방지
    );
    provider.updateEmp(empNo, updatedEmp); // Provider를 통해 직원 정보 업데이트
    setState(() {}); // setState로 화면 정보 갱신
  }

  // ----- 직원 삭제 처리 함수 -----
  void _removeEmpData(int empNo) {
    // Provider에서 해당 사번 직원 삭제 후, 현재 화면 종료(pop)
    final provider = Provider.of<EmployeeProvider>(
      context,
      listen: false,
    );
    provider.removeEmp(empNo); // 실제 데이터 삭제
    Navigator.pop(context);    // 화면 종료(뒤로가기)
  }
}
