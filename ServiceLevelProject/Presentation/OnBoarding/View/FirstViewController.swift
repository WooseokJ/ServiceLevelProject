
import UIKit

class FirstViewController: BaseViewController {
    
    private let imageView = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        
        let fullText = "위치 기반으로 빠르게 \n주위친구를 확인"
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "위치 기반")
        attribtuedString.addAttribute(.foregroundColor, value: BrandColor.green, range: range)
        label.attributedText = attribtuedString
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 0
        
        configure()
        setConstrains()
        
        
    }
    
    private func configure() {
        [titleLabel,imageView].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    private func setConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(70)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.bottom.trailing.leading.equalToSuperview()
        }
        imageView.image = UIImage(named: "onboarding_img1.png")
    }
    
}
