#  ServiceLevelProject

### 2022.11.07 ~ 2022.12.07 (30일, 약 4주)

|                          앱 아이콘                           | 스크린샷                                                     |
| :----------------------------------------------------------: | ------------------------------------------------------------ |
| <img src="https://user-images.githubusercontent.com/55547933/208854647-52f47253-a0d7-4d8e-afd2-21c378837b9a.png"> |                                                              |
|                             개요                             | 디자이너, 서버개발자가 있는 프로젝트 로 새싹 스터디원을 찾고 채팅할수있는 앱 프로젝트 |
|                         디자인 패턴                          | MVC, MVVM, Repository, Singleton                             |
|                             화면                             | UIKit, SnapKit, AutoLayout                                   |
|                       의존성 관리 도구                       | CocoaPod , Swift Package Manager                             |
|                             서버                             | Firebase Auth, Firebase Cloud Messaging                      |
|                         데이터베이스                         | Realm                                                        |
|                           네트워크                           | Alamofire, async/await                                       |
|                         디버깅 스킬                          | LLDB                                                         |
|                          라이브러리                          | socket.io, NMapsMap, Tabman, Rxswift, RxCocoa                |
|                             협업                             | Confluence, Swagger, Github, Figma                           |



## 🔴 고민한 부분

- [이슈 1.  프로토콜 채택할수있는 ViewController 들을 제약](https://github.com/WooseokJ/ServiceLevelProject/issues/1)

- [이슈 2. 토큰이 만료되는 상황에서 토큰 갱신이 무한으로 호출되는 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/3)

- [이슈 3. 휴대폰 번호 입력부분에서 숫자이외 한글 복사붙여넣기 허용 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/4)

- [이슈 4. 채팅 대화목록을 불러오는 부분에서 채팅할때 마다 계속해서 호출 되는 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/5)

- [이슈 5. 네트워크 요청시 배열로 요청할떄 bracket 문제](https://github.com/WooseokJ/ServiceLevelProject/issues/6)

    

## 🟢 학습한 부분

- 프로토콜 에서 **네트워크 로직**을 **where Self** 를 활용하여 **채택할 ViewController들** 제약
- **정규표현식**으로 문자입력시 인증요청이 안되게 해결
- **Alamofire** **URLRequestConvertible**로 네트워크 Router 모듈화
- **await/async** 로 네트워크 비동기를 동기처리
- **socket io**로 소켓통신 구현
- 기본적인 **회원정보 CRUD** 구현
