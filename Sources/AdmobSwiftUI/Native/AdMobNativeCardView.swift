import GoogleMobileAds
import UIKit

class AdMobNativeCardView: NativeAdView {

    private lazy var myMediaView = {
        let mediaView = MediaView()
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        mediaView.heightAnchor.constraint(equalTo: mediaView.widthAnchor, multiplier: 9.0/16.0).isActive = true
        return mediaView
    }()

    private lazy var headlineLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var adTag = {
        let label = UILabel()
        label.text = NSLocalizedString("AD", bundle: .module, comment: "AD")
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textAlignment = .center
        label.backgroundColor = .orange
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()

    private lazy var callToActionButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(hex: "#3871E0")
        button.isUserInteractionEnabled = false
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()

    private lazy var bodyLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 3
        label.numberOfLines = 2
        label.isUserInteractionEnabled = false
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var iconImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var starRatingImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        return imageView
    }()

    private lazy var advertiserLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var starRattingStack = {
        let stackView = UIStackView(arrangedSubviews: [adTag, starRatingImageView, advertiserLabel, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var headlineStarStack = {
        let stackView = UIStackView(arrangedSubviews: [headlineLabel, starRattingStack])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var iconHeadlineStack = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, headlineStarStack, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var buttonStack = {
        let stackView = UIStackView(arrangedSubviews: [callToActionButton])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 39).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var bottomStack = {
        let stackView = UIStackView(arrangedSubviews: [iconHeadlineStack, bodyLabel, buttonStack])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [myMediaView, bottomStack])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        self.headlineView = headlineLabel
        self.advertiserView = advertiserLabel
        self.mediaView = myMediaView
        self.callToActionView = callToActionButton
        self.iconView = iconImageView
        self.bodyView = bodyLabel
        self.starRatingView = starRatingImageView

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
