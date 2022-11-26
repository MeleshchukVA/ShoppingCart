//
//  OnboardingViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

// MARK: - OnboardingViewController + Appearence

extension OnboardingViewController {
    
    struct Appearence {
        
        let bottomMargin: CGFloat = 50
        let regular20 = Font.sber(ofSize: Font.Size.twenty, weight: .regular)
        let backgroundColor = Colors.purple
        let foregroundColor = Colors.lightWhite
        let unselectedForegroundColor = Colors.lightGray
    }
}

// MARK: - OnboardingViewController class

final class OnboardingViewController: UIPageViewController {
    
    // MARK: Properties
    var currentPage = 0
    
    private let appearence = Appearence()
    private var pages = [UIViewController]()
    private var onboardingCompletion: (_ success: Bool) -> Void

    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip and go!", for: .normal)
        button.titleLabel?.font = appearence.regular20
        button.tintColor = appearence.foregroundColor
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        onboardingCompletion: @escaping (Bool) -> Void
    ) {
        self.onboardingCompletion = onboardingCompletion
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
        setupView()
        setupSubviews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startSkipButtonPulseAnimation()
    }
}

// MARK: - Private extension

private extension OnboardingViewController {
    
    // MARK: Methods
    func setupPageController() {
        setupPageControl()
        
        dataSource = self
        delegate = self

        let page1 = PageViewController(
            imageType: ImageType.welcome,
            text: "Welcome to \n my final project \n for Gazprombank!"
        )
        let page2 = PageViewController(
            imageType: ImageType.search,
            text: "Search for products \n and add to cart"
        )
        let page3 = PageViewController(
            imageType: ImageType.stored,
            text: "Products are stored \n in Core Data"
        )
        let page4 = PageViewController(
            imageType: ImageType.image,
            text: "Images \n are loaded and saved \n in the cache"
        )
        
        [page1, page2, page3, page4].forEach { pages.append($0) }

        setViewControllers([pages[currentPage]], direction: .forward, animated: true)
    }

    func setupPageControl() {
        let pageControllAppesrence = UIPageControl.appearance()
        pageControllAppesrence.currentPageIndicatorTintColor = appearence.foregroundColor
        pageControllAppesrence.pageIndicatorTintColor = appearence.unselectedForegroundColor
    }

    func startSkipButtonPulseAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.7
        scaleAnimation.repeatCount = Float.infinity
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.1
        scaleAnimation.toValue = 0.9
        skipButton.layer.add(scaleAnimation, forKey: "scale")
    }
    
    // MARK: Actions
    @objc func skipButtonTapped() {
        onboardingCompletion(true)
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension OnboardingViewController: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        self.view.backgroundColor = appearence.backgroundColor
    }

    func setupSubviews() {
        self.view.addSubview(skipButton)
    }

    func setupConstraints() {
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            skipButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -appearence.bottomMargin)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentPage
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        currentPage = currentIndex
    }
}
