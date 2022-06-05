//
//  BaseProtocols.swift
//  Viper
//
//  Created by Gilberto vieira on 05/06/22.
//

import Foundation
import SwiftUI

protocol ViewToPresenterProtocol: AnyObject {
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingNotice()

}

protocol PresenterToViewProtocol: AnyObject {
    func loadEndpointsInfo(noticeArray:Array<StructDecoder>)
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchNotice()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func endpointsInfoFetchedSuccess(noticeModelArray:Array<StructDecoder>)
    func noticeFetchFailed()
}
