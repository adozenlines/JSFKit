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
    func read() async throws -> JSFeed?
}


public struct JSReader: JSReaderProtocol {
    let session: URLSession
    let url: URL?
    
    public init(url: URL?, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.url = url
        self.session = session
    }
    
    public func read() async throws -> JSFeed? {
        guard let url = url else { throw JSError.invalidURL }
        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse,
              (200..<400).contains(response.statusCode) else {
            throw JSReaderError.serverError
        }
        guard let mimeType = response.mimeType, mimeType.contains(JSMimeTypes.appFeedJson.value) ||
            mimeType.contains(JSMimeTypes.appJson.value) else {
                 throw JSReaderError.dataFormat
        }
        let result = try? JSCodableHelper.decode(type: JSFeed.self, from: data)
        switch result {
        case .success(let success)?:
            return success
        case .failure(let failure)?:
            throw failure
        case .none:
            return nil
        }
    }
    
    public func read(completion: @escaping (JSFeed?, Error?) -> Void) {
        Task {
            do {
                let result = try await read()
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
