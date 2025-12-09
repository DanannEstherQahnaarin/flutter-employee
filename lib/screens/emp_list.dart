import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_add.dart';
import 'package:flutter_employee/screens/emp_detail.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    // 직원 데이터 상태 접근
    final provider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Employee Manager'), centerTitle: true),
      body: ListView.builder(
        itemCount: provider.empList.length,
        itemBuilder: (context, index) {
          final emp = provider.empList[index];

          return ListTile(
            // 직원 기본 정보 표시
            title: Text(emp.name),
            subtitle: Text('${emp.dept},${emp.position}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 상세 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailEmp(onRemoveEmp: (Employee emp) {
                  
                }, detailEmpNo: emp.empNo)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 신규 직원 추가 화면으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEmp(
                onAddEmp: (Employee emp) {
                  Provider.of<EmployeeProvider>(
                    context,
                    listen: false,
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
