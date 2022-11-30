//
//  CatalogueViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//
//

import UIKit

// MARK: - CatalogueViewController

final class CatalogueViewController: BaseViewController {
    
    // MARK: Properties
    private let output: CatalogueViewOutput
    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var catalogueView = self.view as? CatalogueView
    
    // MARK: Init
    init(output: CatalogueViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    override func loadView() {
        let view = CatalogueView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarUIView?.backgroundColor = Colors.purple
        
        output.viewDidLoad()
        setupSearchController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }
}

// MARK: - CatalogueViewInput

extension CatalogueViewController: CatalogueViewInput {
    
    func updateCollectionViewData(adapter: ProductCollectionViewAdapter, isEmpty: Bool) {
        guard let catalogueView = catalogueView else { return }
        catalogueView.collectionView.isHidden = false
        adapter.boundsWidth = catalogueView.bounds.width
        catalogueView.updateCollectionViewData(
            delegate: adapter,
            dataSource: adapter,
            isEmptyCollectionData: isEmpty
        )
    }
    
    func hideTableView(isHidden: Bool) {
        catalogueView?.hideTableView(isHidden: isHidden)
    }
    
    func hideCollectionView() {
        catalogueView?.hideCollectionView(isHidden: true)
    }
    
    func startActivityIndicator() {
        catalogueView?.startActivityIndicator()
    }
    
    func stopActivityIndicator() {
        catalogueView?.stopActivityIndicator()
    }
}

// MARK: - UISearchBarDelegate, UISearchResultsUpdating

extension CatalogueViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    private func setupSearchController() {
        if #available(iOS 13.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
            
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            searchController.searchBar.placeholder = "Search"
            searchController.searchBar.compatibleSearchTextField.textColor = .white
            searchController.searchBar.compatibleSearchTextField.backgroundColor = Colors.searchBarBackground
            
            let textFieldInsideUISearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.textColor = Colors.lightGray
            textFieldInsideUISearchBar?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)

            let labelInsideUISearchBar = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            labelInsideUISearchBar?.textColor = UIColor.red
            labelInsideUISearchBar?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
            searchController.obscuresBackgroundDuringPresentation = false
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular) as Any
            ]
            UIBarButtonItem.appearance(
                whenContainedInInstancesOf: [UISearchBar.self]
            ).setTitleTextAttributes(attributes, for: .normal)
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
            
            let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
            if let clearButton = textField?.value(forKey: "clearButton") as? UIButton {
                let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(templateImage, for: .normal)
                clearButton.tintColor = .white
            }
            textField?.attributedPlaceholder = NSAttributedString(
                string: textField?.placeholder ?? "",
                attributes: [.foregroundColor: UIColor.white]
            )
            textField?.textColor = .white
            
            UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
            UITextField.appearance(
                whenContainedInInstancesOf: [UISearchBar.self]
            ).defaultTextAttributes = [.foregroundColor: UIColor.white]
            
            let glassIconView = textField?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .white
        } else {
            searchController.searchBar.delegate = self
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchResultsUpdater = self
            searchController.definesPresentationContext = true
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search"
            searchController.searchBar.tintColor = .white
            searchController.searchBar.backgroundColor = Colors.purple
            navigationItem.searchController = searchController
            
            let textFieldInsideUISearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.textColor = Colors.lightGray
            textFieldInsideUISearchBar?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)

            let labelInsideUISearchBar = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            labelInsideUISearchBar?.textColor = UIColor.red
            labelInsideUISearchBar?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
            searchController.obscuresBackgroundDuringPresentation = false
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular) as Any
            ]
            UIBarButtonItem.appearance(
                whenContainedInInstancesOf: [UISearchBar.self]
            ).setTitleTextAttributes(attributes, for: .normal)
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
            
            let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
            if let clearButton = textField?.value(forKey: "clearButton") as? UIButton {
                let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(templateImage, for: .normal)
                clearButton.tintColor = .white
            }
            textField?.attributedPlaceholder = NSAttributedString(
                string: textField?.placeholder ?? "",
                attributes: [.foregroundColor: UIColor.white]
            )
            textField?.textColor = .white
            
            UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
            UITextField.appearance(
                whenContainedInInstancesOf: [UISearchBar.self]
            ).defaultTextAttributes = [.foregroundColor: UIColor.white]
            
            let glassIconView = textField?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .white
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        if !query.isEmpty {
            output.searchBarTextDidEndEditing(with: query)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output.searchBarCancelButtonClicked()
    }
}
