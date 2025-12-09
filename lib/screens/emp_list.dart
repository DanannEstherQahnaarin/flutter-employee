import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';
import 'package:flutter_employee/providers/emp_provider.dart';
import 'package:flutter_employee/screens/emp_add.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Employee Manager'), centerTitle: true),
      body: ListView.builder(
        itemCount: provider.empList.length,
        itemBuilder: (context, index) {
          final emp = provider.empList[index];
          return ListTile(
            title: Text(emp.name),
            subtitle: Text('$emp.dept,$emp.position'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Placeholder()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
