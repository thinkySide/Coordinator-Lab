## Coordinator 패턴 연구소

### 🤔 이녀석은 어떤 패턴인가요?
간단하게 설명하자면, `ViewController의 화면 전환 로직을 Coordinator로 분리하는 것!`   
몇번 들어봤던 MVVM-C 패턴에서의 C가 바로 이 Coordinator를 뜻한다고 한다.

### 👀 그럼 왜 사용하게 되었을까요?
- 우리가 평소 사용하는 ViewController는 레이아웃, 사용자 이벤트 처리, 데이터 바인딩 등 너무 많은 로직을 소유하고 있었고, 관심사 분리를 위해 그 중 `'화면 전환' 로직을 분리`하기 위함이다.
- 기존의 ViewController가 ChildViewController 객체의 생성, 즉 정보를 알고 있어야 했기 때문에 `일일이 새로운 인스턴스를 생성`해주고, `결합도 또한 높아지는 문제점`을 가지고 있었다.
- Coordinator 패턴을 사용함으로써 `불필요한 ViewController 객체의 생성을 막고, 느슨한 결합으로 유지보수에 이점`을 얻을 수 있다.

~~~swift
class 첫번째뷰컨트롤러: UIViewController {

...

/// 우리에게 정말 익숙한 코드다.
/// 원래는 첫번째 뷰컨이 두번째 뷰컨의 정보를 꼭 알아야 했고, 생성까지 해줘야 했다!
@objc func 다음화면으로이동() {
  let secondVC = 두번째뷰컨트롤러()
   navigationController?.pushViewController(secondVC, animated: true)
}

...

}
~~~

### 👍 장점
- 앞서 말했듯이, 화면 전환 로직을 분리시킬 수 있음.
- 느슨한 결합으로 유지보수에 이점을 얻을 수 있음.

### 👎 단점
- ViewController 하나당, Coordinator 파일도 하나 늘어나는 구조. (작업량 증가)
- 화면이 사라질 때 Coordinator도 함께 해제해줘야하기 때문에 신경써서 사용해야 함.

### 💁‍♂️ 사용 방법

#### 1. Coordinator 타입 만들기

~~~swift
import UIKit

protocol Coordinator: AnyObject {
    
    /// ViewController의 Push, Pop을 위한 NavigationController
    var navigationController: UINavigationController { get }
    
    /// 현재 코디네이터의 상위 객체 (부모)
    var parentCoordinator: Coordinator? { get set }
    
    /// 현재 코디네이터의 하위(자식) 객체들
    var childCoordinators: [Coordinator] { get set }
    
    /// Coordinator 기본 설정 메서드
    func start()
    
    /// 화면이 사라질 때 메모리에서 삭제하기 위한 메서드
    func remove()
}

extension Coordinator {
    
    /// 자식 코디네이터의 메모리 해제를 위한 메서드
    func removeChildCoordinator(child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
}
~~~

#### 2. 최상위 Coordinator - AppCoordinator 생성

~~~swift
import UIKit

/// 최상위 Coordinator
final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    /// 메모리 누수 방지를 위한 weak 선언
    weak var parentCoordinator: Coordinator?

    /// 기본 자식 배열 초기화
    var childCoordinators: [Coordinator] = []

    /// 생성자를 이용한 NavigationController 주입
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// RootViewController로 보일 화면 지정
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        
        /// 홈화면의 부모는 자신
        homeCoordinator.parentCoordinator = self
        
        /// 자신의 자식 목록에 홈 화면 추가
        childCoordinators.append(homeCoordinator)
        
        /// 홈 화면 코디네이터 세팅 완료
        homeCoordinator.start()
    }
    
    /// 최상위 Coordinaotr는 해제되면 안됨
    /// 프로토콜 필수 구현 메서드라 선언만 해둔 것!
    /// (이부분은 메모리 해제에 신경써야하는 Coordinator 패턴 특성상 이렇게 구현해봤는데, 더 좋은 방법이 있을지도?)
    func remove() {}
}
~~~

#### 3. 실제 사용할 최상위 Coordinator - HomeCoordinator 생성

~~~swift
import UIKit

/// 최상위 바로 아래 코디네이터(Home)
final class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        /// 여기서 HomeVC 생성해주고, coordinator도 위임받음.
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self

        /// 실제 화면 전환 메서드
        /// 여기서는 Home화면이라 애니메이션 꺼줬음.
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    /// 마찬가지로 Home화면은 계속 떠있을 거기 때문에, Coordinator는 해제되면 안됨
    func remove() {}
}

// MARK: - 화면 전환 메서드
extension HomeCoordinator {
    
    /// 트래킹 뷰로 Push 메서드
    func pushTrackingView() {

        /// 다른 화면으로 넘어갈 동작 설정해주기.
        let trackingCoordinator = TrackingCoordinator(navigationController: navigationController)

        /// HomeCoordinator의 자식은 -> TrackingCoordinator
        childCoordinators.append(trackingCoordinator)

        /// TrackingCoordinator의 부모는 -> 바로 나~!
        trackingCoordinator.parentCoordinator = self

        /// 설정 완료 후 시작! (trackingCoordinator에서 화면 전환 시켜줄거)
        trackingCoordinator.start()
    }
    
    /// 캘린더 뷰로 Push 메서드
    func pushCalendarView() {
        let calendarCoordinator = CalendarCoordinator(navigationController: navigationController)
        childCoordinators.append(calendarCoordinator)
        calendarCoordinator.parentCoordinator = self
        calendarCoordinator.start()
    }
}
~~~

#### 4. SceneDelegate에서 RootViewController 지정해주기

~~~swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /// 코디네이터 변수 선언
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        /// RootViewController 설정
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationController)

        /// AppCoordinator 설정 완료 -> HomeCoordinator도 실행 후 설정 -> 화면 정상적으로 노출!
        coordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
~~~

#### 5. HomeViewController 에서 실제 화면 전환 사용해보기

~~~swift
import UIKit

final class HomeViewController: TestViewController {
    
    /// Home Coordinator 생성
    /// 마찬가지로 메모리 누수 방지를 위한 weak 키워드 붙이기
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvent()
        viewLabel.text = "HomeViewController"
    }
    
    private func setupEvent() {
        firstButton.setTitle("Tracking", for: .normal)
        firstButton.addTarget(
            self,
            action: #selector(pushTrackingView),
            for: .touchUpInside
        )
        
        secondButton.setTitle("Calendar", for: .normal)
        secondButton.addTarget(
            self,
            action: #selector(pushCalendarView),
            for: .touchUpInside
        )
    }
}

// MARK: - Event Method
extension HomeViewController {

    /// 이렇게 간단하게 Coordinator에 화면 전환 요청만 해주면 됨!
    @objc private func pushTrackingView() {
        coordinator?.pushTrackingView()
    }
    
    @objc private func pushCalendarView() {
        coordinator?.pushCalendarView()
    }
}
~~~

### 💌 Ref.
- [Esiwon님의 tistoy](https://siwon-code.tistory.com/38)
