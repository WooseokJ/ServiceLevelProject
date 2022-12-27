#  ServiceLevelProject

### 2022.11.07 ~ 2022.12.07 (30일, 약 4주)

|                          앱 아이콘                           | 스크린샷                                                     |
| :----------------------------------------------------------: | ------------------------------------------------------------ |
| <img src="https://user-images.githubusercontent.com/55547933/208854647-52f47253-a0d7-4d8e-afd2-21c378837b9a.png"> | <img src="https://user-images.githubusercontent.com/55547933/209553750-fc85aabc-3ba0-4258-ac60-f3f4a62b7406.jpg" width="500px" height="500px"> |
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
|                             참고                             | [회고](https://hotsanit.tistory.com/107)                     |



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
<details> <summary>이슈 1. 프로토콜 채택할수있는 ViewController 들을 제약</summary><br>
🔴 고민한 영역 <br><br>
프로토콜로 네트워크 로직을 만든후 아래와같이 UIViewController 로 제약을 걸면 studyPostDodge 메소드가 어느 ViewController에서 채택해서 사용이되는지 알기가 어렵고
네트워크로직에 import UIKit을 해주는게 적합하지 않다고 보인다.<br>

<img width="852" alt="스크린샷 2022-12-22 오후 3 12 58" src="https://user-images.githubusercontent.com/55547933/209069133-fc4b6836-5cf9-4163-86a6-fd0319e212cf.png"><br>

🔵 해결<br><br>
아래와같이 특정 뷰컨트롤러(ChattingViewController)에서만 studyPostdodge메소드를 사용한다고 제약을 주어서 어느 뷰컨트롤러에서 사용하는 메소드인지 명시!<br>
```swift
// DodgeProtocol.swift
import Foundation

protocol DodgeProtocol: APIProtocol, APIQueueProtocol  {
    func studyPostDodge(otheruid: String)
}

extension DodgeProtocol where Self: ChattingViewController {

    
    func studyPostDodge(otheruid: String) {
        apiQueue.studyPostDodge(otheruid: otheruid) { [weak self] data in
            do {
                switch data {
                case .success:
                    print(data)
                    self?.view.makeToast("스터디 취소 성공")
                case .failure(.otherUIDError):
                    self?.view.makeToast("잘못된 otheruid 요청")
 
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.studyPostDodge(otheruid: otheruid)
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch{
                print("에러야")
                return
            }
        }
    }
}
```
</details>



<details> <summary>이슈 2. 토큰이 만료되는 상황에서 토큰 갱신이 무한으로 호출되는 문제</summary><br>
🔴 이슈 <br><br>
토큰갱신하는게 비동기적으로 처리되기떄문에 토큰갱신하고 다시 네트워크 요청메소드 호출시 무한으로 호출되는 문제가 발생<br>
<br>

🔵 해결<br><br>
completion Handler로 토큰갱신후 네트워크 요청메소드 호출하는 방식으로 해결
<br>
```swift
func studyPostRequest(otheruid: String) {
        apiQueue.studyPostRequest(otheruid: otheruid) { [weak self] data in
            do {
                switch data {
                case .success:
                    self?.view.makeToast("스터디 요청을 보냈습니다")
                case .failure(.alreadyTomeRequest):
                    self?.view.makeToast("상대방이 이미 나에게 스터디 요청한 상태")
                    self?.studyPostAccept(otheruid: otheruid)

                case .failure(.oppnentStopRequest):
                    self?.view.makeToast("상대방이 스터디찾기를 그만두었습니다.")
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.studyPostRequest(otheruid: otheruid)
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")

                }
            }
            catch let error{
                print(error)
            }
        }
    }
}

//APIProtocol.swift
@objc protocol APIProtocol {
    @objc optional func presentVC()
    @objc optional func refreshIdToken()
}

extension APIProtocol where Self: UIViewController {
    
    typealias completion = ( () -> Void)
    
    func refreshIdToken(completion: @escaping completion) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if error != nil {
                self.view.makeToast("토큰 갱신 에러")
                return;
            }
            print("갱신한 idToken",idToken as Any)
            UserDefaults.standard.set(idToken!, forKey: "token")
            completion() 
        }
    }
}
```

</details>


<details> <summary>이슈 3. 휴대폰 번호 입력부분에서 숫자이외 한글 복사붙여넣기 허용 문제</summary><br>
🔴 이슈 <br><br>
휴대폰 인증 요청시 문자열 입력시에도 Firebase Auth로 인증을 요청이 되는 문제가있었다. <br>
<br>

🔵 해결<br><br>
정규표현식으로 유효성검사를 통해 유효하지않은 숫자포맷과 문자열이 TextField에 입력시 인증요청을 보내지않음.
<br>
```swift
// 정규표현식으로 유효성검사
extension LoginViewController {
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }
        let phoneRegEx = #"^\(?\d{3}\)?[ -]?\d{3,4}[ -]?\d{4}$"#
        guard let valid = phone.range(of: phoneRegEx, options: .regularExpression) != nil
        return valid
    }
   
      
      //MARK: textfield의 text가 변경이있을떄
      loginView.phoneNumberTextField.rx.text.orEmpty
          .observe(on: MainScheduler.asyncInstance)
          .withUnretained(self)
          .bind { (vc,textfield) in
              
              /// 글자수 제한
              guard vc.checkMaxLength(textField: vc.loginView.phoneNumberTextField, maxLength: 13) else {return}
              
              // 유효한 숫자형태면 색상변환
              guard !self.isValidPhone(phone: textfield) {
                 vc.loginView.phoneButton.backgroundColor = BrandColor.green
                  return
              }
              vc.loginView.phoneButton.backgroundColor = Grayscale.gray6
              let test = vc.loginView.phoneNumberTextField
              switch test.text?.count {
                  case 4:
                  if test.text?.filter({$0 == "-"}).count == 1 {
                          test.deleteBackward()
                      } else {
                          test.text?.insert("-", at: test.text?.index(test.text?.startIndex, offsetBy: 3))
                      }
                      vc.loginView.phoneNumberTextField.text? = test.text?
                  case 9:
                  if test.text?.filter({$0 == "-"}).count == 2 {
                          test.deleteBackward()
                      } else {
                          test.text?.insert("-", at: test.text?.index(test.text?.startIndex, offsetBy: 8))
                      }
                      vc.loginView.phoneNumberTextField.text? = test.text?
                  default:break
              }
          }
          .disposed(by: disposeBag)
    }
}
```

</details>

<details> <summary>이슈 4. 채팅 대화목록을 불러오는 부분에서 채팅할때 마다 계속해서 호출 되는 문제</summary><br>
🔴 이슈 <br><br>
채팅메세지를 보낼떄마다 채팅대화목록을 불러오는방식은 과도한 호출이 되는 문제가 발생할것같다. <br>
<br>

🔵 해결<br><br>
처음 채팅목록을 Realm DB에 저장하고 이후의 채팅을 보내고 보낸내용은 Local Realm DB에서 저장하고 불러오는형태로 서버에 Send만 보내는 request만 보내고 chatPostList요청은 처음 viewDidload시 한번만 불러온다! 
<br>
```swift
// chatPostList를 통해 서버에서 대화목록을 가져와서 Realm에 저장한다.
class ChattingViewController {
    override func viewDidLoad() {
        chatPostList(lastchatDate: lastchatDate, from: UserDefaults.standard.string(forKey: "otheruid")!) { [weak self] data in
            self?.recentChattingInfo = data
            do {
                print(self?.repository.localRealm.configuration.fileURL! as Any)
                try self?.repository.localRealm.write {
                    self?.repository.localRealm.deleteAll()
                    self?.test = (data?.payload.count)!
                    data?.payload.forEach{
                        let value = ChatData(to: $0.to!, from: $0.from!, chat: $0.chat!, createdAt: $0.createdAt!)
                        self?.repository.localRealm.add(value)
                    }
                }
                self?.configureTableView()
                self?.collectionViewConfigure()
            }catch let error {
                 print(error)
              }
        }
}

extension ChattingViewController {
    func bind() {
        // 메세지 전송전송후 DB와 chatPostSend메소드로 네트워크 요청
        chattingView.sendButton.rx
            .tap
            .map {self.chattingView.sendTextView.text}
            .withUnretained(self)
            .bind { (vc,val) in
                vc.chatPostSend(chat: val!, to: UserDefaults.standard.string(forKey: "otheruid")!)
                vc.chattingView.sendTextView.text = ""
                let chatContent = ChatData(to:UserDefaults.standard.string(forKey: "otheruid")! , from: UserDefaults.standard.string(forKey: "Myuid")!, chat: val!, createdAt: "")
                self.repository.addChat(item: chatContent)
                
                vc.chattingView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
      }
}
```

</details>

<details> <summary>이슈 5. 네트워크 요청시 배열로 요청할떄 bracket 문제</summary><br>
🔴 이슈 <br><br>
alamofire는 request 배열을 보낼떄 [](브라켓)을 달고 보내지는데 이 때문에 서버쪽에서 거부하는 상황<br>
<br>

🔵 해결<br><br>
Alamofire 공식문서를 보고 참고하여 브라켓을 제거하는 방법을 시도
<br>
```swift
/func queueRequest(lat: Double, long: Double, studylist: [String], completionHandler: @escaping QueuPostHandler ) {
        let api = APIHeader.queue(lat: lat, long: long, studylist: studylist)
        AF.request(api.url, method: api.method, parameters: api.parameters , encoding: URLEncoding(arrayEncoding: .noBrackets), headers: api.headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure :
                guard let customError = queuePostErorr(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(queuePostErorr(rawValue: customError.rawValue)!))
            }
        }
    }
```

🟢 참고 <br><br>
[Alamofire 링크](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#configuring-the-encoding-of-array-parameters) <br>
<img width="932" alt="스크린샷 2022-12-23 오후 3 10 22" src="https://user-images.githubusercontent.com/55547933/209281719-5c242a2d-1b18-4b02-b0a7-b66678c885a3.png">

</details>

