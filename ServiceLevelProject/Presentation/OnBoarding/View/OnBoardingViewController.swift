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
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
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


