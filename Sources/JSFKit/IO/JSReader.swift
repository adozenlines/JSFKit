//
//  JSReader.swift
//  JSFKit
//
//  MIT License
//
//  Copyright (c) 2020 Sean Batson
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

protocol JSReaderProtocol {
    var session: URLSession { get }
    var url: URL? { get }
    func read(completion: @escaping (JSFeed?, Error?) -> Void)
}


open struct JSReader: JSReaderProtocol {
    let session: URLSession
    let url: URL?
    
    open init(url: URL?, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.url = url
        self.session = session
    }
    
    open func read(completion: @escaping (JSFeed?, Error?) -> Void) {
        guard let url = url else { completion(nil, JSError.invalidURL); return }
        let operation = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                (200..<400).contains(response.statusCode) else {
                    completion(nil, JSReaderError.serverError)
                return
            }
            guard let mimeType = response.mimeType, mimeType.contains(JSMimeTypes.appFeedJson.value) ||
                mimeType.contains(JSMimeTypes.appJson.value) else {
                    completion(nil, JSReaderError.dataFormat)
                return
            }
            if error != nil {
                completion(nil, error)
            } else {
                guard let data = data else { completion(nil, JSReaderError.emptyResponseData); return }
                let model = JSCodableHelper.decode(JSFeed.self, from: data)
                completion(model.decodableObj, model.error)
            }
        }
        operation.resume()
    }
}
