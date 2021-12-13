//
//  SearchPresenter.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 30/11/2021.
//

import UIKit

class SearchPresenter: SearchPresenterProtocol, SearchInteractorOutputProtocol {
    
    var search: SearchViewProtocol?
//    var detail: SearchDetailViewProtocol?
    
    var wireframe: SearchWireframeProtocol?
    var interactor: SearchInteractorInputProtocol?
    
    func perform(action: SearchAction) {
        switch action {
        case .textEntered(let input):
            interactor?.perform(.requestMovies(text: input))
        case .scrollTo(let index):
            interactor?.perform(.requestPage(index: index))
        case .itemSelected(let index):
            interactor?.perform(.requestMovieDetail(index: index))
            wireframe?.navigate(to: .detail)
        }
    }
    
    func handle(_ result: SearchInteractorResult) {
        switch result {
        case .moviesSuccess(let entity):
            ViewDispatcher.shared.execute {
                self.search?.populate(.success(entity: entity))
            }
        case .detailSuccess(let entity): print(entity)
//            self.detail?.populate(.success(entity: entity))
        case .error(let error): print(error)
//            self.search?.populate(.error(error: error))
        }
    }
}
