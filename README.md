# 🍸 집에서 칵테일을 만들어보자! Drinkin!
>Drinkin은 맛있는 칵테일을 집에서 직접 즐길 수 있도록 도와주는 홈텐딩 도우미 앱입니다. 개인이 가지고 있는 재료에 맞게 칵테일에 대한 추천을 받고, 추천 받은 칵테일들에 대한 상세 설명 및 제조법을 알려드립니다. 

## ⚒️ 기능 소개
홈텐딩 도우미가 되겠습니다!

사용자에게 맞는 칵테일을 추천해드려요!

칵테일 제조법뿐만 아니라 기법, 도구 등 상세하게 설명해드릴게요!

만들어보고 싶은 칵테일, 만들어본 칵테일을 저장할 수 있답니다!

|마셔봤던 칵테일 선택|칵테일 추천|칵테일 상세정보|
|:----:|:----:|:----:|
|<img src="https://github.com/kimseongj/TIL/assets/88870642/d9a2bc32-395c-48d9-9d5a-1bfebef39c60" width=200>|<img src="https://github.com/kimseongj/TIL/assets/88870642/a834a572-1086-4c85-9c96-425dc646b3c7" width=200>|<img src="https://github.com/kimseongj/TIL/assets/88870642/0b0c975b-3b8d-44d1-b3d9-a8a36a82cf73" width=200>|
|마셔봤었던 칵테일을 선택하고, 선택된 칵테일과 비슷한 칵테일을 추천해드립니다.|10가지의 추천 칵테일을 표시해주고, 칵테일 재료 보유 유무를 알 수 있습니다.|칵테일에 대한 레시피, 재료들을 나열해주고 클릭시 상세정보를 확인할 수 있습니다.|
|**칵테일 필터**|**나의 홈바**|**만들어본 칵테일 목록**|
|<img src="https://github.com/kimseongj/TIL/assets/88870642/c099b3e7-d3da-4402-bde3-96905ee2f806" width=200>|<img src="https://github.com/kimseongj/TIL/assets/88870642/44a66f53-c92c-4881-92e1-f1fc26504c44" width=200>|<img src="https://github.com/kimseongj/TIL/assets/88870642/f6fb0a5b-bacb-48a6-a70c-87c5a225ca47" width=200>|
|상세한 필터를 통해 원하는 칵테일을 찾아볼 수 있습니다.|나의 홈바에서 칵테일 저장목록, 가지고 있는 재료 등을 수정할 수 있습니다.|내가 만든 칵테일 목록을 확인해볼 수 있습니다.|

## ⚙️ 기술 스택
<img src="https://img.shields.io/badge/CleanArchitecture-0080FF?style=flat-square"/> <img src="https://img.shields.io/badge/MVVM-100AF?style=flat-square"/> <img src="https://img.shields.io/badge/Coordinator-019999?style=flat-square"/> <img src="https://img.shields.io/badge/Combine-AAA1AF?style=flat-square"/> <img src="https://img.shields.io/badge/Network-100000?style=flat-square"/> <img src="https://img.shields.io/badge/ModernCollectionView-FF0000?style=flat-square"/> <img src="https://img.shields.io/badge/KeyChain-EEE6C4?style=flat-square"/> <img src="https://img.shields.io/badge/SPM-DDA2FF?style=flat-square"/>

## 📝 아키텍쳐
### CleanArchitecture + MVVM-C

## 🏃기술적 도전
<details>
    <summary><big>Clean Architecture</big></summary> 
    
### Clean Architecture

>   Clean Architecture를 저만의 해석을 바탕으로 이해하려고 노력했습니다.
>
> 일단, Clean Architeture를 사용하면서 느낀 것은 객체의 모듈화가 정말 잘되어있는 아키텍쳐 디자인이라고 생각됩니다. MVVM의 경우 ViewModel에서 비즈니스 로직을 담당하고,  Model과 상호작용하여 데이터를 주고 받습니다. 그렇다면 여러 비즈니스 로직이 하나의 ViewModel에서 구현되어 ViewModel의 부피가 커지게 되며, 복잡성이 생길 수 있습니다. Clean Architecture는 ViewModel의 비즈니스 로직마저, Usecase라는 객체를 생성하여 하나씩 분리합니다. 즉, 모듈성이 극대화된다고 생각합니다. 모듈성이 강해지면, unit test와 refactoring 시 유리할 것 같습니다. 하지만 Clean Architecture를 사용하면 나쁜 것은 아니지만 코드의 양이 늘어납니다. 특히, Repository를 불가피하게 usecase에서 사용하게 되는 경우가 있는데 이 때, 의존성 역전을 통해서 Usecase가 직접 Repository를 의존하는 것을 방지해줘야 합니다. 
>
> 결론은 Clean Architecture는 유지보수성, 테스트 용이성, 확장성을 보장하기 위한 아키텍쳐 패턴이라고 생각합니다.



:fire: **Clean Architecture의 이해**

![스크린샷 2022-09-26 오후 2 57 24](https://user-images.githubusercontent.com/88870642/192203620-6586d83a-ef97-4076-844b-44650f7bf213.png)

> 내부 레이어(Entity, Useacase)는 외부 레이어(framework 및 UI)에 종속되어서는 안 됩니다. 즉, 내부 원으로 들어가는 형태로 의존성을 지녀야 합니다.



<img width="711" alt="image" src="https://github.com/kimseongj/TIL/assets/88870642/6a5d9f18-4756-4590-b0ee-ddc9d19096d7">

### 🟡Domain

- Entity
  - Entity는 다른 프로젝트에서 재사용될 수 있으며, 절대적으로 다른 계층으로부터 영향을 받으면 안됩니다.
  - 주로 데이터 구조의 집합이며 객체, 함수의 집합일 수도 있습니다.
- Usecase 
  - 시스템의 동작을 사용자의 입장에서 표현한 시나리오라고 할 수 있습니다.
  - 즉, 애플리케이션 고유 비즈니스 로직을 관리하는 객체입니다.

### 🟡Data

- Data Source를 포함합니다.
- Repository
  - Repository는 외부 혹은 내부의 데이터를 받아오고 저장하는 역할을 합니다.
  - Domain에서 Data의 Repository의 request와 response를 받아야 하는데, 이것은 Domain을 의존하는 관계가 아닌것이 되며, 이를 해결하기 위해 의존성 역전을 사용해야 합니다.
  - 즉 Data의 Data Repository는 Domain의 프로토콜을 따라야합니다.


:fire: **의존성 역전이란?**

> SOLID 원칙 중 하나로, 의존 관계 역전 법칙은 상위 계층이 하위 계층에 의존하 의존관계를 반전시켜 상위 계층이 하위 계층의 구현으로부터 독립되게 할 수 있는 구조입니다.

1. 상위 모듈은 하위 모듈에 의존해서는 안된다. 상위 모듈과 하위 모듈 모두 추상화에 의존하여 상위 모듈이 하위 모듈에 의존하지 않게 연결할 수 있습니다.
2. A -> B 의존성을 A -> 추상화(Protocol) <- B와 같은 형태로 바꾼다고 생각하면 됩니다.

### 🟡Presenter

- 프레젠테이션 레이어에는 UI(View)가 포함되어 있습니다.
- View는 하나 이상의 유즈케이스를 실행하고, MVVM 패턴에서 ViewModel에 의해 조정됩니다.
- View, ViewModel을 가지고 있습니다.
  - ViewModel에서 Usecase를 실행하는 형태입니다.
 </details>

    
<details>
    <summary><big>Coordinator 패턴의 적용</big></summary>
    
### Coordinator 패턴의 적용

> Coordinator 패턴은 ViewController 간의 흐름을 관리하는 디자인 패턴으로 사용됩니다. 하나의 ViewController의 화면 전환 및 인스턴스를 관리하는 역할을 할 수 있습니다.

:fire: **Coordinator 패턴을 적용했을 때 느낀점**

1. 한개의 `ViewController`가 앱 흐름에 따라 여러 곳에서 호출될 때, `Coordinator`를 구현하면,  `Coordinator`를 재사용하여 쉽게 앱의 흐름을 구현할 수 있습니다.
2. `ViewController` 내부에 다음 UI에 대한 `ViewController`를 인스턴스로 만들어서 화면 전환을 하면 제 3자의 입장에서 앱 흐름을 파악하는데 ViewController를 하나씩 다 열람하는 번거로움이 생길 것 같습니다. `Coordinator`를` 통해 화면 전환을 구현하면, 가독성 측면에서 상당한 이점을 갖을 수 있을 것입니다.
3. 테스트를 실제 진행하지 않았지만, `Coordinator `패턴을 사용할 경우 테스트할 때 전체 앱을 탐색할 필요 없이 모의 `Coordinator`를 만들어 독립 테스트가 가능할 것 같습니다.
4. 하지만 결국 `ViewController`마다 `Coordinator`를 만들기 때문에 화면 수가 적은 앱에서는 필요 이상의 코드들이 생성될 수 있습니다.

:fire:**결론** : 결론적으로 코디네이터 패턴은 복잡한 탐색과 앱 흐름이 있는 앱의 경우 iOS 앱 아키텍처에 효율적인 디자인 패턴이 될 것입니다. 그러나 모든 앱에 필요하거나 소규모 앱에는 적합하지 않을 수 있고, 요구 사항과 복잡성에 따라 채택을 고려해야 할 것 같습니다.




**현재 프로젝트의 `Coordinator` 프로토콜**

```swift
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
		// childCoordinators를 담아주는 역할
    func start()
    func childDidFinish(_ child: Coordinator?)
  // childCoordinator가 deinit됐을 때, childCoordinators에서 해당 childCoordinator삭제해주는 메서드
}
```

:fire: **childCoordinators에 Coordinator를 저장하는 이유**

1. 하위 `Coordinator`를 추적하기 용이합니다. 로직을 확인할 때, 쉽게 흐름을 파악할 수 있습니다.
2. 하위 `Coordinator`의 의도치 않은 `deinit`에도 인스턴스가 유지될 수 있습니다.
</details>
 
<details>
    <summary><big>Dependency Injection</big></summary> 
    
### Dependency Injection

> 의존성 주입은 클래스 간 결합을 줄이기 위해 외부에서 개체를 생성하여 해당 개체를 필요로 하는 다른 개체에 주입해주는 것입니다. 코드의 분리성, 독립 테스트 용이성 등을 향상시킬 수 있는 좋은 방법입니다. 제 프로젝트에서는 `init()`을 통해 의존성을 주입하는 방법을 선택했습니다. 

:fire: **Dependency Injection을 적용했을 때 느낀 점**

1. DI를 적용하면 코드에 대한 리팩토링을 할 때, 여러 객체들을 찾아가서 의존성을 가지는 인스턴스들을 수정할 필요가 없습니다. 이는 코드 분리성에 있어 이점을 가져갑니다.
2. 독립적인 Test가 가능합니다.
3. 코드의 양이 많아지긴 하지만 협력하는 과정에서 코드를 한층 더 쉽게 이해할 수 있을 것 같습니다. 

:fire: **결론** : DI는 코드의 양이 늘어날 뿐 그 이상의 단점이 없고, 느슨할 결합을 이뤄낼 수 있게 해주며, 유지보수 시에도 편리할 것 같습니다.


**현재 프로젝트의 의존성 주입** 

```swift
final class BriefDescriptionDIContainer {
    func makeBriefDescriptionRepository() -> BriefDescriptionRepository {
        return DefaultBriefDescriptionRepository()
    }
    
    func makeFetchBriefDescriptionUsecase() -> FetchBriefDescriptionUsecase {
        return DefaultFetchBriefDescriptionUsecase(briefDescriptionRepository: makeBriefDescriptionRepository())
    }
    
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        return DefaultCocktailRecommendViewModel(fetchBriefDescriptionUseCase: makeFetchBriefDescriptionUsecase())
    }
}
```
</details>

<details>
    <summary><big>MVVM 패턴을 적용하면서 Binding에 대한 고민</big></summary> 
    
### MVVM 패턴을 적용하면서 Binding에 대한 고민

> MVVM 패턴의 경우 `ViewModel`과 `View`를 분리하여 비즈니스로직과 UI로직을 분리해놓습니다. 이 때, `View`에서 사용자와 상호작용을 통해 UI가 변하거나, 시간에 따라 서버에서 새로운 데이터를 보내지 않는 상황에서도 `Binding`을 쓰는게 의미가 있을까 라는 고민이 생겼습니다.

:fire:**결론**: 구현하는 `View`가 단순 데이터를 받아와서 UI를 그리고 `ViewModel`과 양방향 통신을 하지 않는다면 Binding의 의미가 없어진다고 생각이 듭니다. Binding의 목적은 `ViewModel`의 값과 `View`의 속성을 연결하여 데이터 변경에 자동으로 업데이트되도록 하는 것이기 때문입니다. 유연성 있는 코드를 작성하기 위해서 Binding이 필요없는 UI의 경우 Binding을 하지 않는 방향성을 고려해볼 필요가 있다고 생각합니다.
</details>

<details>
    <summary><big>Combine</big></summary> 

### Combine 활용
> Combine을 활용하여 Data Fetch, Binding했습니다. 비동기적 기능을 구현하기 위해 사용되며, 비동기적 프로그래밍을 위해 Delegate, Callback함수 , Completion 클로저 등을 활용하는 방법이 있지만, 코드의 가독성이 낮아지고, 예외처리의 어려움이 있는데 이것을 해결할 수 있습니다.
    
:fire: **Combine**에 대한 이해 
- Publisher
    - 프로토콜로, 자신을 구독하고 있는 Subscriber 객체에 시간이 흐름에 따라 값을 내보낼 수 있도록 타입을 선언합니다.
    - `Output`과 `Failure`타입으로 제네릭으로 구현되어 있습니다.
- Subscriber
    - Publisher에게 값을 받을 수 있는 타입을 선언하기 위한 프로토콜입니다.
    - `input`, `failure` 타입이 제네릭으로 구현되어 있습니다.
    - 주로 `sink`를 사용하여 `Subscriber`를 직접 생성하지 않았습니다.
- Operator
    - Operator는 Publisher를 반환하는 Publisher 프로토콜에 정의된 메서드입니다.
    - 여러 종류의 Operator를 Combine 하여 사용하여 Publisher가 내보내는 값을 처리합니다.
- Subscription
    - Subscription은 Publisher와 Subscriber의 연결을 나타내는 프로토콜입니다.
    - Publisher + Operator + Subscriber로 이뤄진 하나의 작업이 Subscription이라고 할 수 있습니다.

:fire: **코드 구현**
- **dataTaskPublisher를 API 호출**
```swift
struct Provider {
    func fetchData<T: Decodable>(endpoint: EndpointMakeable)  -> AnyPublisher<T, Error> {
        let request = endpoint.makeURLRequest()

        return URLSession.shared.dataTaskPublisher(for: request!)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
```
    
- **Combine을 통해 Binding**
```swift
private func binding() {
        viewModel?.cocktailDescriptionPublisher.receive(on: RunLoop.main).sink {
            self.fill(with: $0)
        }.store(in: &cancelBag)
    }
```
</details>
    
<details>
    <summary><big>Diffable Data Source 적용</big></summary> 
    
### Diffable Data Source 적용

> Diffable DataSource는 CollectionView, TableView의 Cell들이 데이터의 변화에 따라 cell들을 재구성하는 역할을 합니다. 이는 물론 DataSource에 존재하는 기능입니다. 하지만 DataSource를 사용할 경우 애니메이션 효과 부분에서 사용자의 UX를 저하시킬 수 있습니다. 이런 부분을 해결하기 위해 DiffableDataSource는 데이터의 달라진 부분을 추적하고 자연스러운 애니메이션을 통해 UI를 업데이트 합니다.



:fire: **주의 사항**
- IndexPath를 사용하지 않고, Hashable을 기반으로 동작합니다.
- UIState의 Truth이며 IndexPath 대신 Section과 Item의 Unique Identifier를 사용합니다. `DiffableDataSource`은 제네릭 타입으로 `Section`과 `item`타입을 받습니다. 이 때 제네릭 타입들은 `Hashable`을 준수해야 합니다. 



:fire: **사용원리**

1. **Connect a diffable data source to your collection view**
   - `DiffableDataSource`를 `CollectionView`가 있는 `ViewController`에 만들어줍니다.

2. **Implement a cell provider to configure your collection view's cells**
   - `CellProvider`를 구현하여, `cell`을 만드는 방식을 구현합니다.

3. **Generate the current state of the data**
   - 데이터에 대한 `snapshot`을 찍어 `DiffableDataSource`에 적용하고 상태를 변화시킵니다.

4. **Display the data in the UI**
   - `UI`에 변화된 상태의 `CollectionView`를 보여줍니다.

(Apple 공식문서 인용)
</details>
        
<details>
    <summary><big>Extension, Enum 활용</big></summary> 
    
### Extension, Enum 활용
:fire: **Extension**
> Extension을 활용하여 UIImageView, UIViewController을 사용할 때 필요한 메서드를 구현하였고, 이를 바탕으로 UIImageView, UIViewController가 사용되는 어느 곳에서든 구현된 메서드를 사용할 수 있게 했습니다.

- UIIMageView
```swift
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
```

- UIViewController
```swift
extension UIViewController {
    func makeBlackBackBarButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
```

:fire: **Enum**
> Enum을 활용하여 여러 케이스를 분리하고, static let과 같은 type property를 만들어서 NameSpace, Color, Image등을 관리할 수 있는 enum을 구현했습니다.

- HTTPMethod
```swift
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
```

- CategoryListStrings
```swift
enum CategoryListStrings {
    static let whole: String = "전체"
    static let whiskey: String = "위스키 베이스"
    static let liqueur: String = "리큐르 베이스"
    static let vodka: String = "보드카 베이스"
    static let gin: String = "진 베이스"
    static let rum: String = "럼 베이스"
    static let tequila: String = "데킬라 베이스"
    static let nonAlcoholic: String = "논알콜"
    static let mixing: String = "혼합"
}
```
</details>

<details>
    <summary><big>CollectionView LeftAlignmentLayout 구현</big></summary> 
    
### CollectionView LeftAlignmentLayout 구현

> 디자인에 따라 구현함에 있어 CollectionViewCell들이 왼쪽 정렬이 되도록 구현해야 하는 과정이 있었습니다. 왼쪽 정렬을 구현하려면 flowLayout을 커스텀 제작이 필요했습니다. 따라서 아래와 같이 구현했습니다.

:fire: **코드 & 설명**

```swift
class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
```

- `minimumLineSpacing`을 통해 cell간 최소간격을 표현합니다.
- `sectionInset`으로 Section간 여백을 0으로 설정합니다.
- `super.layoutAttributesForElements(in: rect)`을 사용하여 현재 영역에 있는 `attributes`(각 셀의 크기와 위치 정보)를 가져옵니다.
- `attributes?.forEach`를 통해 각 `cell`의 특성에 접근합니다.
- `maxY`를 -1로 하여 cell의 첫 행일 때, `maxY`보다 값이 크면 `leftMargin`을 `sectionInset.left `(x == 0)인 부분으로 바꿔줍니다.
- 그 이후에 `leftMargin`을 `layoutAttribute.frame.origin.x`에 넣어줌으로써 `cell`의 x위치를 `leftMargin`으로 바꿔줍니다.
- `leftMargin`에 현재 `cell`의 크기 더하기 `leftMargin`을 해서 다시 `leftMargin`에 넣어줍니다.
- `maxY`를 현재 `cell`의 y좌표값과 비교하여 더 큰값을 다시 `maxY`에 넣어줍니다.
</details>
