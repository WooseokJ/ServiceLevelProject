
import UIKit

class FirstViewController: BaseViewController {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 0
        
//        titleLabel.text = "위치 기반으로 빠르게 주위친구를 확인"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        
        let fullText = "위치 기반으로 빠르게 \n주위친구를 확인"
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "위치 기반")
        
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.green, range: range)
        titleLabel.attributedText = attribtuedString
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(100)
        }
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.trailing.leading.equalToSuperview()
        }
        imageView.image = UIImage(named: "onboarding_img1.png")

    }
    
}
