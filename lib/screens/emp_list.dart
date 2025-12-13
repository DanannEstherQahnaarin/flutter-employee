import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_add.dart';
import 'package:flutter_employee/screens/emp_detail.dart';
import 'package:provider/provider.dart';

/// 직원 목록 전체를 보여주고, 상세조회/추가 기능을 제공하는 StatelessWidget
class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider 패턴을 이용해 EmployeeProvider 상태 객체를 읽어옴
    final provider = Provider.of<EmployeeProvider>(context);

    // 화면의 전체 구조(Scaffold) 정의
    return Scaffold(
      // 앱 상단에 고정된 AppBar(타이틀 표시, 가운데 정렬)
      appBar: AppBar(
        title: Text('Employee Manager'),
        centerTitle: true,
      ),
      // 직원 목록(리스트뷰) 영역
      body: ListView.builder(
        itemCount: provider.empList.length, // 직원 수만큼 아이템 생성
        itemBuilder: (context, index) {
          final emp = provider.empList[index]; // 개별 직원 데이터

          return ListTile(
            // 직원 이름을 큰 글씨로 출력
            title: Text(emp.name),
            // 소속 부서, 직급 조합으로 부제목 표기
            subtitle: Text('${emp.dept},${emp.position}'),
            // 오른쪽에 화살표 아이콘(상세 진입 유도)
            trailing: const Icon(Icons.arrow_forward_ios),
            // 리스트 아이템 터치 시 직원 상세화면으로 이동
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailEmp(
                    // 삭제 등 액션 발생 시 콜백(실제 삭제처리는 상세화면 내부에서 처리)
                    onRemoveEmp: (Employee emp) {
                      // 삭제 콜백 구현 필요 없으나, 구조상 추가됨(실사용은 상세에서)
                    },
                    // 상세조회용 직원 고유번호(사번)
                    detailEmpNo: emp.empNo,
                  ),
                ),
              );
            },
          );
        },
      ),
      // 하단 오른쪽 플로팅 액션 버튼: 직원 추가 화면 진입
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // AddEmp(직원 추가 화면)으로 이동, 추가 완료 시 Provider에 반영
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEmp(
                onAddEmp: (Employee emp) {
                  // Provider의 addEmp 메서드를 통해 직원 추가 수행
                  Provider.of<EmployeeProvider>(
                    context,
                    listen: false, // 상태 업데이트 시 해당 위젯 리빌드 방지
                  ).addEmp(emp);
                },
              ),
            ),
          );
        },
        // + 아이콘 표시
        child: Icon(Icons.add),
      ),
    );
  }
}
