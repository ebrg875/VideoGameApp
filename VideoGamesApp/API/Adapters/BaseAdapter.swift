//
//  BaseAdapter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import RxSwift

protocol BaseAdapterProtocol {
    func call<DataModel,UIModel>(single: Single<DataModel>,
                                 converter: @escaping (DataModel) -> UIModel,
                                 onSuccess: @escaping (UIModel) -> Void,
                                 onError: @escaping (Error) -> Void) -> Disposable
}

class BaseAdapter: BaseAdapterProtocol {

    //    let disposeBag = DisposeBag()

    func call<DataModel,UIModel>(single: Single<DataModel>,
                                 converter: @escaping (DataModel) -> UIModel,
                                 onSuccess: @escaping (UIModel) -> Void,
                                 onError: @escaping (Error) -> Void) -> Disposable {
            return single.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: {
                    response in onSuccess(converter(response))
                }, onError: onError)
    }
}
