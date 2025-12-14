
/// 직원(Employee) 정보를 나타내는 클래스입니다.
///
/// [Employee] 클래스는 사원의 이름, 전화번호, 부서, 사원번호, 월급, 계좌번호, 직급 등
/// 사원 관리에 필요한 주요 정보를 필드로 포함하고 있습니다.
/// 
/// - name: 사원 이름 (예: '홍길동')
/// - phone: 전화번호 (예: '010-1234-5678')
/// - dept: 부서명 (예: '총무부')
/// - empNo: 사원 고유 번호 (예: 24001)
/// - salary: 월급 (단위: 원, 예: 2800000)
/// - account: 계좌번호 (예: '123-456-7890')
//  - position: 직급 (예: '사원', '대리', '과장', '부장')
class Employee {
  /// 사원 이름
  String name;
  /// 전화번호
  String phone;
  /// 부서
  String dept;
  /// 사원번호
  int empNo;
  /// 월급
  int salary;
  /// 계좌번호
  String account;
  /// 직급 (사원, 대리, 과장, 부장)
  String position;

  /// Employee 객체 생성자
  ///
  /// 모든 필드는 필수 입력입니다.
  Employee({
    required this.name,
    required this.phone,
    required this.dept,
    required this.empNo,
    required this.salary,
    required this.account,
    required this.position,
  });

  /// 사원 기본 정보를 문자열로 반환합니다.
  @override
  String toString() {
    return 'Employee{name: $name, empNo: $empNo, position: $position, dept: $dept}';
  }
}
