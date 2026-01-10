# flutter_employee

간단한 직원 관리(예: 직원 목록) 예제 Flutter 앱입니다.  
이 저장소는 모바일/웹/데스크톱(Windows, Linux) 빌드를 지원하도록 생성된 Flutter 프로젝트 구조를 포함합니다.

## 주요 특징
- Flutter (Dart) 기반 UI
- Provider 패키지를 이용한 상태 관리 (MultiProvider, EmployeeProvider)
- 플랫폼별 러너 코드 포함: web/, windows/, linux/
- 간단한 직원 목록 화면(예: `lib/screens/emp_list.dart`) 및 프로바이더(`lib/providers/emp_provider.dart`)로 구성

## 언어 구성(리포지토리 기준)
- Dart: 주된 앱 로직 (약 41%)
- C++ / CMake: 데스크톱 런너 및 Flutter 엔진 래퍼(약 29% / 23%)
- Swift / C / HTML 등 소량 포함

## 요구사항 (Prerequisites)
- Flutter SDK (stable 채널 권장) 설치: https://docs.flutter.dev/get-started/install
- 플랫폼별 툴체인
  - Android: Android SDK
  - iOS: Xcode (macOS)
  - Windows: Visual Studio (C++ 워크로드)
  - Linux: build-essential, GTK 개발 패키지 등
- Dart/Flutter PATH가 설정되어 있어야 합니다.

## 빠른 시작
프로젝트 루트에서:

1. 의존성 가져오기
```bash
flutter pub get
```

2. 개발 모드로 실행
- Web (Chrome)
```bash
flutter run -d chrome
```
- Windows (설정된 Windows 환경에서)
```bash
flutter run -d windows
```
- Linux
```bash
flutter run -d linux
```
- Android/iOS (장치 연결 또는 에뮬레이터)
```bash
flutter run
```

3. 릴리즈 빌드 예시
- Web
```bash
flutter build web
```
- Windows
```bash
flutter build windows
```
- Linux
```bash
flutter build linux
```

## 프로젝트 구조 (주요 파일/폴더)
- lib/
  - main.dart — 앱 진입점 (MultiProvider 설정 포함)
  - providers/
    - emp_provider.dart — 직원 데이터 관리를 담당하는 ChangeNotifier
  - screens/
    - emp_list.dart — 직원 목록 화면
  - widgets/ — 재사용 위젯들(있는 경우)
- web/ — 웹 관련 정적 파일 (index.html 등)
- windows/ — Windows 데스크톱 러너(C++/CMake)
- linux/ — Linux 데스크톱 러너(C++/CMake)
- README.md — 이 파일

(참고) main.dart의 상단에서 MultiProvider로 `EmployeeProvider`를 주입하는 구조를 사용하고 있으므로, 하위 위젯에서 Provider.of 또는 Consumer로 상태를 사용할 수 있습니다.

## 상태관리 및 아키텍처(간단)
- Provider (ChangeNotifier) 기반으로 앱 상태(직원 리스트 등)를 관리합니다.
- UI는 Provider로부터 상태를 구독하여 변경 시 자동으로 갱신됩니다.
- 플랫폼 네이티브 실행 코드는 Flutter가 생성한 기본 템플릿(CMake, Win32 등)을 사용합니다.

## 개발/기여
기여 환영합니다. 변경/기능 추가 제안 시:
- 이슈(issues)를 열어주세요.
- 간단한 변경은 PR로 보내주시고, PR 설명에 변경 목적과 테스트 방법을 적어 주세요.

## 향후 개선 아이디어
- 직원 추가/수정/삭제 기능(현재 읽기 전용일 가능성 ��음)
- 로컬 DB(예: sqflite) 또는 원격 API 연동
- 단위/위젯 테스트 추가
- CI (GitHub Actions)로 빌드 테스트 자동화
- 스크린샷 및 데모 영상 추가

## 라이선스
이 저장소에 라이선스 파일이 없다면 원하는 라이선스(MIT, Apache-2.0 등)를 알려주세요. README에도 반영하겠습니다.

## 연락처
저장소 소유자: DanannEstherQahnaarin
