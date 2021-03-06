//
//  SearchWireframeProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import UIKit

class SearchWireframe: SearchWireframeProtocol {
    
    var search: UIViewController!
    var detail: UIViewController?
    
    var presenter: SearchPresenter?
    
    init() {
        self.presenter = SearchPresenter()
        let search = SearchView()
        let interactor = SearchInteractor()
        search.presenter = presenter
        self.presenter?.search = search
        self.presenter?.wireframe = self
        self.presenter?.interactor = interactor
        interactor.presenter = presenter
        self.search = search
    }
    
    func navigate(to page: SearchPage) {
        switch page {
        case .search:
            detail?.dismiss(animated: true, completion: nil)
        case .detail:
            pushDetail()
        }
    }
    
    private func pushDetail() {
//        let detail = SearchDetailViewController()
        let detail = UIViewController()
//        detail.presenter = self.presenter
//        presenter?.detail = detail
//        self.detail = detail as UIViewController
//        search.show(self.detail!, sender: self.search)
        search.show(detail, sender: self.search)
    }
}
