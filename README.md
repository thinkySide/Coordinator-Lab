## Coordinator 패턴 연구소

### 1. 이녀석은 어떤 패턴인가요?
간단하게 설명하자면, `ViewController의 화면 전환 로직을 Coordinator로 분리하는 것!`   
몇번 들어봤던 MVVM-C 패턴에서의 C가 바로 이 Coordinator를 뜻한다고 한다.

### 2. 그럼 왜 사용하게 되었을까요?
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
