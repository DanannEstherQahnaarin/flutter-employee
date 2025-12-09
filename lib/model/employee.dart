class Employee {
  String name; // 이름
  String phone; // 전화번호
  String dept; // 부서
  int empNo; // 사원번호
  int salary; // 월급
  String account; // 계좌번호
  String position; // 직급 (사원, 대리, 과장, 부장)

  Employee({
    required this.name,
    required this.phone,
    required this.dept,
    required this.empNo,
    required this.salary,
    required this.account,
    required this.position,
  });

  // Optionally: Add a method to display basic info
  @override
  String toString() {
    return 'Employee{name: $name, empNo: $empNo, position: $position, dept: $dept}';
  }
}
