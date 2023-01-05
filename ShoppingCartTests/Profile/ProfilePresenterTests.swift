//
//  ProfilePresenterTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 18.12.2022.
//

import XCTest
@testable import ShoppingCart

final class ProfilePresenterTests: XCTestCase {

    var sut: ProfilePresenter!
    var interactorMock: ProfileInteractorMock!
    var viewControllerMock: ProfileViewControllerMock!
    var routerMock: ProfileRouterMock!
    var networkServiceMock: NetworkServiceMock!
    var imageLoaderMock: ImageLoaderMock!

    override func setUp() {
        super.setUp()
        setupMocks()
    }

    override func tearDown() {
        sut = nil
        interactorMock = nil
        viewControllerMock = nil
        routerMock = nil
        networkServiceMock = nil
        super.tearDown()
    }

    private func setupMocks(
        interactorMock: ProfileInteractorMock = ProfileInteractorMock(),
        viewControllerMock: ProfileViewControllerMock = ProfileViewControllerMock(),
        routerMock: ProfileRouterMock = ProfileRouterMock()
    ) {
        self.interactorMock = interactorMock
        self.viewControllerMock = viewControllerMock
        self.routerMock = routerMock

        sut = ProfilePresenter(
            router: routerMock,
            interactor: interactorMock
        )
        sut.view = viewControllerMock
        self.interactorMock.output = sut
        interactorMock.networkServiceMock = networkServiceMock
        interactorMock.imageLoaderMock = imageLoaderMock
    }
}

extension ProfilePresenterTests {

    func test_Did_Load_With_Success() {
        // Given
        self.networkServiceMock = NetworkServiceMock()
        let user = User(id: 1, image: "", firstName: "", lastName: "", email: "", username: "", password: "")

        setupMocks()

        networkServiceMock.resultForGetUsers = .success(user)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(viewControllerMock.user?.id == user.id)
    }

    func test_Did_Load_With_Failure() {
        // Given
        self.networkServiceMock = NetworkServiceMock()
        let error = NetworkErrors.dataIsEmpty

        setupMocks()

        networkServiceMock.resultForGetUsers = .failure(error)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(routerMock.text == "Please try again \nor check Internet connection")
        XCTAssert(viewControllerMock.isFalseActivityIndicator == true)
    }

    func test_Did_Load_Image_With_Success() {
        // Given
        self.imageLoaderMock = ImageLoaderMock()
        self.networkServiceMock = NetworkServiceMock()

        let user = User(id: 1, image: "", firstName: "", lastName: "", email: "", username: "", password: "")
        let image = UIImage()

        setupMocks()

        networkServiceMock.resultForGetUsers = .success(user)
        imageLoaderMock.resultForGetImage = .success(image)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(viewControllerMock.user?.image == user.image)
    }

    func test_Did_Load_Image_With_Failure() {
        // Given
        self.imageLoaderMock = ImageLoaderMock()
        self.networkServiceMock = NetworkServiceMock()

        let imageError = ImageLoaderError.failDownloadImage
        let user = User(id: 1, image: "", firstName: "", lastName: "", email: "", username: "", password: "")

        setupMocks()

        networkServiceMock.resultForGetUsers = .success(user)
        imageLoaderMock.resultForGetImage = .failure(imageError)
        
        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(viewControllerMock.isFalseToGetImage == true)
    }
}
