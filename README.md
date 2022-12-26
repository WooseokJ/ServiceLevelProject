#  ServiceLevelProject

### 2022.11.07 ~ 2022.12.07 (30일, 약 4주)

|                          앱 아이콘                           | 스크린샷                                                     |
| :----------------------------------------------------------: | ------------------------------------------------------------ |
| <img src="https://user-images.githubusercontent.com/55547933/208854647-52f47253-a0d7-4d8e-afd2-21c378837b9a.png"> | <img src="https://user-images.githubusercontent.com/55547933/209553750-fc85aabc-3ba0-4258-ac60-f3f4a62b7406.jpg" alt="merge_from_ofoct (5)" style="zoom:10%;" /> |
|                             개요                             | 디자이너, 서버개발자가 있는 프로젝트 로 새싹 스터디원을 찾고 채팅할수있는 앱 프로젝트 |
|                         디자인 패턴                          | MVC, Repository, Singleton                                   |
|                             화면                             | UIKit, SnapKit, AutoLayout                                   |
|                       의존성 관리 도구                       | CocoaPod , Swift Package Manager                             |
|                             서버                             | Firebase Auth, Firebase Cloud Messaging                      |
|                         데이터베이스                         | Realm                                                        |
|                           네트워크                           | Alamofire, async/await                                       |
|                         디버깅 스킬                          | LLDB                                                         |
|                          라이브러리                          | socket.io, NMapsMap, Tabman, Rxswift, RxCocoa                |
|                             협업                             | Confluence, Swagger, Github, Figma                           |



## 🟢 기술 명세

- 프로토콜 에서 **네트워크 로직**을 **where Self** 를 활용하여 **채택할 ViewController들** 제약
- 프로토콜로 **네트워크 로직**들을 **모듈화**하여 와 **비지니스 로직**과 분리 하여 뷰 컨트롤러 역할과 분리
- **정규표현식**으로 문자나 특수문자 입력시 인증요청이 안되게 함으로서 불필요한 요청 문제 해결
- **Alamofire** **URLRequestConvertible**로 네트워크 Router 모듈화로 매 통신에필요한 **파라미터,해더,HTTP 메서드 캡슐화**
- **await/async** 로 비동기 코드를 동기코드 처럼 작성하여 콜백함수가 **여러번 호출 될때 제어흐름이 복잡**하고 매개변수 **@escaping 구문이 읽기어려워  코드 가독성을 높임**
- **socket io** 으로 **Realm DB** 를 써서 네트워크 호출이 과하게 되지 않게 1:1 채팅 구현, 소켓 연결 및 해제 시점에 대해 대응
- **Firebase Auth** 로 **휴대폰 인증** 을 받고 **상태코드**를 통해 로그인 성공 화면 혹은 회원가입 **화면 분기처리**
- **Firebase Cloud Messaging 에서 발급받은 FCM token** 으로 **멀티디바이스 대응**
- **Confluence** 기획안을 보면서 **요구사항 필수 기능 구현 및 화면 로직 설계 ([화면 로직 링크](https://www.figma.com/file/qxHHEH3ETn9gviJU0gj1z0/SLP-Service-Flow?node-id=849%3A845&t=sTkjixRIIAvCy6zm-0))**
- 온보딩 화면을 **PageViewController**를 활용하여 앱 처음시작시 혹은 회원 탈퇴에 만 보이게 **화면 분기처리**
- **Timer**를 활용하여 5초마다 매칭상태 확인하는 **API 반복호출**



## 🔴 고민한 내용 및 트러블 슈팅

- [이슈 1.  프로토콜 채택할수있는 ViewController 들을 제약](https://github.com/WooseokJ/ServiceLevelProject/issues/1)
- [이슈 2. 토큰이 만료되는 상황에서 토큰 갱신이 무한으로 호출되는 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/3)
- [이슈 3. 휴대폰 번호 입력부분에서 숫자이외 한글 복사붙여넣기 허용 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/4)
- [이슈 4. 채팅 대화목록을 불러오는 부분에서 채팅할때 마다 계속해서 호출 되는 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/5)
- [이슈 5. 네트워크 요청시 배열로 요청할떄 bracket 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/6)




