import 'package:flutter/material.dart';
import 'package:flutter_employee/model/employee.dart';

class AddEmp extends StatefulWidget {
  final Function(Employee) onAddEmp; // 신규 직원 추가 콜백

  const AddEmp({required this.onAddEmp, super.key});

  @override
  State<AddEmp> createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  final _formKey = GlobalKey<FormState>();

  // 입력 필드 컨트롤러
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtPhone = TextEditingController();
  final TextEditingController _txtDept = TextEditingController();
  final TextEditingController _txtEmpNo = TextEditingController();
  final TextEditingController _txtSalary = TextEditingController();
  final TextEditingController _txtAccount = TextEditingController();

  String _selectPosition = "사원";
  final List<String> _positions = ["사원", "대리", "과장", "부장"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Add")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 이름
              TextFormField(
                controller: _txtName,
                decoration: InputDecoration(labelText: '이름'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is empty";
                  }

                  return null;
                },
              ),
              // 전화번호
              TextFormField(
                controller: _txtPhone,
                decoration: InputDecoration(labelText: '전화번호'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "전화번호 is empty";
                  }

                  return null;
                },
              ),
              // 부서
              TextFormField(
                controller: _txtDept,
                decoration: InputDecoration(labelText: '부서'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "부서 is empty";
                  }

                  return null;
                },
              ),
              // 사원번호
              TextFormField(
                controller: _txtEmpNo,
                decoration: InputDecoration(labelText: '사원번호'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "사원번호 is empty";
                  }

                  return null;
                },
              ),
              // 월급
              TextFormField(
                controller: _txtSalary,
                decoration: InputDecoration(labelText: "월급"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return "월급을 입력하세요.";
                  if (int.tryParse(value) == null) return "숫자만 입력하세요.";
                  return null;
                },
              ),
              // 계좌번호
              TextFormField(
                controller: _txtAccount,
                decoration: InputDecoration(labelText: "계좌번호"),
              ),
              // 직급 선택
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "직급"),
                items: _positions.map((pos) {
                  return DropdownMenuItem(value: pos, child: Text(pos));
                }).toList(),
                onChanged: (value) {
                  _selectPosition = value ?? "사원";
                },
              ),
              SizedBox(height: 20),
              // 저장 버튼
              ElevatedButton(onPressed: _addEmpData, child: Text("Add")),
            ],
          ),
        ),
      ),
    );
  }

  void _addEmpData() {
    // 폼 검증 후 직원 객체 생성 및 콜백 전달
    if (_formKey.currentState!.validate()) {
      Employee newEmp = Employee(
        name: _txtName.text,
        phone: _txtPhone.text,
        dept: _txtDept.text,
        empNo: int.parse(_txtEmpNo.text),
        salary: int.parse(_txtSalary.text),
        account: _txtAccount.text,
        position: _selectPosition,
      );

      widget.onAddEmp(newEmp);
      Navigator.pop(context);
    }
  }
}
