import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_add.dart';
import 'package:flutter_employee/screens/emp_detail.dart';
import 'package:provider/provider.dart';

/// 직원 목록 전체를 보여주고, 상세조회/추가 기능을 제공하는 StatelessWidget
/// 직원 전체 목록을 표시하며, 상세 조회 및 신규 추가 기능을 제공하는 화면 위젯입니다.
/// 
/// 주요 기능 및 역할:
/// - Provider(EmployeeProvider)를 구독해 실시간으로 직원(Employee) 목록을 표시합니다.
/// - 각 직원 아이템은 이름, 부서, 직급 정보를 간략히 나타내며, 클릭 시 상세조회 화면(DetailEmp)으로 이동할 수 있습니다.
/// - 상세조회 화면에서는 개별 직원의 자세한 정보 확인, 수정, 삭제가 가능합니다.
/// - 화면 우측 하단의 + 버튼(FloatingActionButton)을 누르면 직원 추가(AddEmp) 화면으로 이동하며, 신규 입력 시 Provider에 즉시 반영됩니다.
/// 
/// 구조 요약:
/// - AppBar: 상단에 "Employee Manager" 타이틀 고정.
/// - ListView: 직원 목록을 동적으로 빌드.
/// - FloatingActionButton: 직원 추가 진입 동작 담당.
/// 
/// Provider 패턴을 활용해, 변경되는 직원 데이터에 즉시 반응하며, 상태 관리를 효율적으로 수행합니다.
class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    // EmployeeProvider의 직원 목록 상태 구독
    final provider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      // 상단 타이틀 AppBar
      appBar: AppBar(
        title: Text('Employee Manager'),
        centerTitle: true,
      ),
      // 직원 목록 리스트뷰
      body: ListView.builder(
        itemCount: provider.empList.length,
        itemBuilder: (context, index) {
          final emp = provider.empList[index]; // 해당 인덱스 직원

          return ListTile(
            // 직원 이름 표시
            title: Text(emp.name),
            // 부서, 직급 출력
            subtitle: Text('${emp.dept},${emp.position}'),
            // 상세 진입용 아이콘
            trailing: const Icon(Icons.arrow_forward_ios),
            // 각 직원 아이템 선택 시 상세 화면으로 이동
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailEmp(
                    // 상세 화면에서의 삭제/변경 콜백 (실제 삭제는 상세 내에서 처리)
                    onRemoveEmp: (Employee emp) {},
                    detailEmpNo: emp.empNo,
                  ),
                ),
              );
            },
          );
        },
      ),
      // 직원 추가 진입용 플로팅 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // AddEmp 화면 진입 및 신규 직원 추가 시 Provider에 등록 처리
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEmp(
                onAddEmp: (Employee emp) {
                  Provider.of<EmployeeProvider>(
                    context,
                    listen: false, // 이 위젯은 상태 변경 시 리빌드 필요 없음
                  ).addEmp(emp);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
