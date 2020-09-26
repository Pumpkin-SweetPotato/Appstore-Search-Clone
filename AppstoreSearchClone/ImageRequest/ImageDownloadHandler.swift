//
//  ImageDownloadHandler.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import RxSwift

typealias ImageDownloadHandler = (_ image: UIImage?, _ imageUrl: String, _ IndexPath: IndexPath?, _ error: Error?) -> Void

typealias ImageDownloadResult = (image: UIImage?, imageUrlString: String, indexPath: IndexPath?, error: Error?)

final class ImageDownloadManager {
    private var completionHandler: ImageDownloadHandler?
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "net.eazel.Eazel.imageDownloadQueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    let imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageDownloadManager()
    private init () {}
    
    func downloadImage(_ imageUrl: String, indexPath: IndexPath?, handler: ImageDownloadHandler?) {
//        self.completionHandler = handler
        
        if let cachedImage = imageCache.object(forKey: imageUrl as NSString) {
            // check for the cached image for url, if YES then return the cached image
//            print("Return cahced Image for \(imageUrl)    \(String(describing: indexPath?.row))")
//            self.completionHandler?(cachedImage, imageUrl, indexPath, nil)
            handler?(cachedImage, imageUrl, indexPath, nil)
        } else {
            if let operations = imageDownloadQueue.operations as? [PGOperation],
                let operation = operations.filter({ $0.imageUrlString == imageUrl && !$0.isFinished && $0.isExecuting }).first {
                
//                print("Increase the priority for \(imageUrl)   \(String(describing: indexPath?.row))")
                operation.queuePriority = .high
            } else {
//                print("Create a new task for \(imageUrl)")
                let operation = PGOperation(url: imageUrl, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .veryHigh
                }
                operation.downloadHandler = { (image, url, indexPath, error) in
                    if error != nil {
                        print("image downloading error \(url) \(error!.localizedDescription)")
                    }
                    if let newImage = image {
//                        print("setCache image \(url) , \(indexPath?.row ?? 0)")
                        self.imageCache.setObject(newImage, forKey: url as NSString)
                    }
                    
                    handler?(image, url, indexPath, error)
//                    if self.completionHandler == nil {
//                        print("completionHandler is nil \(imageUrl)")
//                    }
//                    self.completionHandler?(image, url, indexPath, error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    func downloadImage(_ imageUrl: String, indexPath: IndexPath?) -> Observable<ImageDownloadResult> {
        return Observable.create { observer in
            var _operation: PGOperation?
            
            if let cachedImage = self.imageCache.object(forKey: imageUrl as NSString) {
                // check for the cached image for url, if YES then return the cached image
                print("Return cahced Image for \(imageUrl)    \(String(describing: indexPath?.row))")
//                self.completionHandler?(cachedImage, imageUrl, indexPath, nil)
                observer.onNext((cachedImage, imageUrl, indexPath, nil))
                observer.onCompleted()
            } else {
                if let operation = self.getOperation(with: imageUrl) {
                    
                    _operation = operation
                    operation.downloadHandler = { (image, imageUrl, indexPath, error) in
                        if let error = error {
                            observer.onError(error)
                            return
                        }
                        
                        observer.onNext((image, imageUrl, indexPath, error))
                        observer.onCompleted()
                    }
                    
//                    print("Increase the priority for \(imageUrl)   \(String(describing: indexPath?.row))")
                    operation.queuePriority = .high
                } else {
//                    print("Create a new task for \(imageUrl)")
                    let operation = PGOperation(url: imageUrl, indexPath: indexPath)
                    if indexPath == nil {
                        operation.queuePriority = .veryHigh
                    }
                    _operation = operation
                    
                    operation.downloadHandler = { (image, imageUrl, indexPath, error) in
                        if let error = error {
                            observer.onError(error)
                            return
                        }
                        
                        observer.onNext((image, imageUrl, indexPath, error))
                        observer.onCompleted()
//                        if error != nil {
//                            print("image downloading error \(url) \(error!.localizedDescription)")
//                        }
//                        if let newImage = image {
//                            print("setCache image \(url) , \(indexPath?.row ?? 0)")
//                            self.imageCache.setObject(newImage, forKey: url as NSString)
//                        }
//                        if self.completionHandler == nil {
//                            print("completionHandler is nil \(imageUrl)")
//                        }
//                        self.completionHandler?(image, url, indexPath, error)
                    }
                    self.imageDownloadQueue.addOperation(operation)
                }
            }
            
            return Disposables.create {
                _operation?.cancelDownloadImageTask()
            }
        }
    }
    
    func cancelDownloadImage(_ imageUrlString: String, indexPath: IndexPath?) {
        guard let operation = getOperation(with: imageUrlString) else { return }
        
        operation.downloadHandler = nil
        operation.cancelDownloadImageTask()
    }
    
    func getOperation(with imageUrlString: String) -> PGOperation? {
        guard let operations = imageDownloadQueue.operations as? [PGOperation],
        let operation = operations.filter({ $0.imageUrlString == imageUrlString && !$0.isFinished && $0.isExecuting }).first else { return nil }
        
        return operation
    }
}

