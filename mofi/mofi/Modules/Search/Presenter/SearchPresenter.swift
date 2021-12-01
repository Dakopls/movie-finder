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
        case .searchPressed(let input):
            interactor?.perform(.requestMovies(text: input))
        case .itemSelected(let index):
            interactor?.perform(.storeSelectedMovie(index: index))
            wireframe?.navigate(to: .detail)
        case .detailRequested:
            interactor?.perform(.requestMovieDetail)
        }
    }
    
    func handle(_ result: SearchInteractorResult) {
        switch result {
        case .moviesSuccess(let entity):
            self.search?.populate(.success(entity: entity))
        case .detailSuccess(let entity): print(entity)
//            self.detail?.populate(.success(entity: entity))
        case .error(let error): print(error)
//            self.search?.populate(.error(error: error))
        }
    }
}
