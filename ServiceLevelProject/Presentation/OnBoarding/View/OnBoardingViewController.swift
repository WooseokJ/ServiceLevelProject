import UIKit

class OnBoardingViewController: BaseViewController {
    

    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("버튼 시작", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    
    private lazy var pageControl: UIPageControl = {
         let pageControl: UIPageControl = UIPageControl()
         pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0

         pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .black
//         pageControl.translatesAutoresizingMaskIntoConstraints = false
         return pageControl
     }()
    
    let vc1 = FirstViewController()
    let vc2 = SecondViewController()
    let vc3 = ThirdViewController()
    
    
    lazy var pageViewController: UIPageViewController = {
            let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            return vc
        }()
    
    lazy var viewControllersArray: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstVC = viewControllersArray.first {
                pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        configure()
        setupDelegate()
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = LoginViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    
    private func configure() {
        addChild(pageViewController)
        [pageViewController.view,pageControl,startButton].forEach {
            self.view.addSubview($0)
        }
           pageViewController.view.snp.makeConstraints { make in
               make.top.equalTo(100)
               make.leading.trailing.equalToSuperview()
               make.bottom.equalTo(startButton.snp.top).offset(-20)
           }
           pageViewController.didMove(toParent: self)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(60)
        }
        
        startButton.snp.makeConstraints { make in
//            make.top.equalTo(pageControl.snp.bottom).offset(50)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-70)
            make.top.equalTo(pageControl.snp.bottom).offset(15)
        }

       }
    
    private func setupDelegate() {
          pageViewController.dataSource = self
          pageViewController.delegate = self

      }
}
extension OnBoardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }

        var index = viewController.view.tag
//        pageControl.currentPage = index
        index -= 1
        if index < 0 {
            return nil
        }

        return viewControllersArray[index]
        


            


    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //        guard let index = viewControllersArray.firstIndex(of: viewController) else { return nil }
        
        var index = viewController.view.tag
//        pageControl.currentPage = index
        if index == viewControllersArray.count - 1 {
            return nil
        }
        index += 1
        return viewControllersArray[index]
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed {
                // 애니메이션 or 버튼 강조효과 or 변경 후 적용할 부분들 적용
              // 저는 pageControl 의 currentPage값 변경을 위해 넣어봤습니당
              if let currentViewController = pageViewController.viewControllers?[0] as? FirstViewController {
                  pageControl.currentPage = currentViewController.view.tag
                } else if let currentViewController = pageViewController.viewControllers?[0] as? SecondViewController {
                    pageControl.currentPage = currentViewController.view.tag
                } else if let currentViewController = pageViewController.viewControllers?[0] as? ThirdViewController {
                    pageControl.currentPage = currentViewController.view.tag
                }
            }
        }
    



    
}


