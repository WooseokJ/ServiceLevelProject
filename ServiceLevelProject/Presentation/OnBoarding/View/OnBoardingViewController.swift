import UIKit

class OnBoardingViewController: BaseViewController {
    
    
    
    let onboardingView = OnBoardingView()
    
    override func loadView() {
        super.view = onboardingView
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstVC = onboardingView.viewControllersArray.first {
            onboardingView.pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        setupDelegate()
        self.addChild(onboardingView.pageViewController)
        onboardingView.pageViewController.didMove(toParent: self)

        onboardingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = LoginViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    
  
    
    private func setupDelegate() {
        onboardingView.pageViewController.dataSource = self
        onboardingView.pageViewController.delegate = self
    }
}
extension OnBoardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        index -= 1
        if index < 0 {
            return nil
        }
        return onboardingView.viewControllersArray[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //        guard let index = viewControllersArray.firstIndex(of: viewController) else { return nil }
        
        var index = viewController.view.tag
        //        pageControl.currentPage = index
        if index == onboardingView.viewControllersArray.count - 1 {
            return nil
        }
        index += 1
        return onboardingView.viewControllersArray[index]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // 애니메이션 or 버튼 강조효과 or 변경 후 적용할 부분들 적용
            // 저는 pageControl 의 currentPage값 변경을 위해 넣어봤습니당
            if let currentViewController = pageViewController.viewControllers?[0] as? FirstViewController {
                onboardingView.pageControl.currentPage = currentViewController.view.tag
            } else if let currentViewController = pageViewController.viewControllers?[0] as? SecondViewController {
                onboardingView.pageControl.currentPage = currentViewController.view.tag
            } else if let currentViewController = pageViewController.viewControllers?[0] as? ThirdViewController {
                onboardingView.pageControl.currentPage = currentViewController.view.tag
            }
        }
    }
    
    
    
    
    
}


