//
//  CatalogueViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import UIKit

// MARK: - ViewController

final class CatalogueViewController: UIViewController {
    
    // MARK: Properties
	private let output: CatalogueViewControllerOutput
    private let searchController = UISearchController(searchResultsController: nil)

    // Чтобы иметь доступ к activityIndecator'у.
    lazy var catalogueView = self.view as? CatalogueView

    // MARK: Init
    init(output: CatalogueViewControllerOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func loadView() {
        let view = CatalogueView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        output.viewDidLoad()
        setupSearchController()
	}
}

// MARK: - ViewControllerInput

extension CatalogueViewController: CatalogueViewControllerInput {
    
    func startActivityIndicator() {
        catalogueView?.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        catalogueView?.activityIndicator.stopAnimating()
    }
}

// MARK: - UISearchBarDelegate, UISearchResultsUpdating

extension CatalogueViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.compatibleSearchTextField.textColor = .white
        searchController.searchBar.compatibleSearchTextField.backgroundColor = Colors.searchBarBackground
        searchController.searchBar.searchTextField.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular) as Any
        ]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .title = "Отменить"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .tintColor = .white
        
        let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
        
        let glassIconView = textField?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .white
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {}
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {}
}
