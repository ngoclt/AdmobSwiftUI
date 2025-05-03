import GoogleMobileAds
import UIKit

class AdMobNativeLargeBannerView: NativeAdView {
    /// required
    private lazy var myMediaView = {
        let mediaView = MediaView()
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        mediaView.widthAnchor.constraint(equalTo: mediaView.heightAnchor, multiplier: 16/9).isActive = true
        mediaView.contentMode = .scaleAspectFill
        mediaView.clipsToBounds = true
        return mediaView
    }()

    private lazy var headlineLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    private lazy var adTag = {
        let label = UILabel()
        label.text = NSLocalizedString("AD", bundle: .module, comment: "Ad tag label")
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var advertiserLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var bodyLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var callToActionButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .systemBlue
        button.isUserInteractionEnabled = false
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()

    private lazy var leftStack = {
        let stackView = UIStackView(arrangedSubviews: [headlineLabel, advertiserLabel, bodyLabel, callToActionButton, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [myMediaView, leftStack])
        stackView.axis = .horizontal
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
        self.mediaView = myMediaView
        self.headlineView = headlineLabel
        self.advertiserView = advertiserLabel
        self.bodyView = bodyLabel
        self.callToActionView = callToActionButton

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

        addSubview(adTag)
        adTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adTag.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            adTag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            adTag.widthAnchor.constraint(greaterThanOrEqualToConstant: 25),
            adTag.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
