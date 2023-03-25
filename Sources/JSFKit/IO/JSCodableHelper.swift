//
//  JSCodableHelper.swift
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

public typealias EncodeResult = (data: Data?, error: Error?)

enum JSDateError: String, Error {
    case invalidDate
}

public class JSCodableHelper {

    public static var dateformatter: DateFormatter?

    @available(*, deprecated, renamed: "decode(type:from:)")
    open class func decode<T>(_ type: T.Type, from data: Data) throws -> (decodableObj: T?, error: Error?) where T : Decodable {
        let result = try decode(type: type, from: data)
        switch result {
        case .success(let success):
            return (success, nil)
        case .failure(let failure):
            return (nil, failure)
        }
    }
    
    open class func decode<T>(type: T.Type, from data: Data) throws -> Result<T, Error> where T : Decodable {
        
        let decoder = JSONDecoder()

        if let df = self.dateformatter {
            decoder.dateDecodingStrategy = .formatted(df)
        } else {
            decoder.dataDecodingStrategy = .deferredToData
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)

                let formatters = [
                    "yyyy-MM-dd",
                    "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                    "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                    "yyyy-MM-dd'T'HH:mm:ss'Z'",
                    "yyyy-MM-dd'T'HH:mm:ss.SSS",
                    "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                    "yyyy-MM-dd HH:mm:ss"
                    ].map { (format: String) -> DateFormatter in
                        let formatter = DateFormatter()
                        formatter.locale = Locale(identifier: "en_US_POSIX")
                        formatter.dateFormat = format
                        return formatter
                }

                for formatter in formatters {

                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                }

                throw JSDateError.invalidDate
            })
        }

        do {
            let returnedDecodable = try decoder.decode(type, from: data)
            return .success(returnedDecodable)
        } catch {
            return .failure(error)
        }
    }

    @available(*, deprecated, renamed: "encoded(value:prettyPrint:)")
    open class func encode<T>(_ value: T, prettyPrint: Bool = false) -> EncodeResult where T : Encodable {
        let result = encode(value: value, prettyPrint: prettyPrint)
        switch result {
        case .success(let success):
            return (success, nil)
        case .failure(let failure):
            return (nil, failure)
        }
    }
    
    open class func encode<T>(value: T, prettyPrint: Bool = false) -> Result<Data, Error> where T : Encodable {

        let encoder = JSONEncoder()
        if prettyPrint {
            encoder.outputFormatting = .prettyPrinted
        }
        encoder.dataEncodingStrategy = .base64
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        encoder.dateEncodingStrategy = .formatted(formatter)

        do {
            let returnedData = try encoder.encode(value)
            return .success(returnedData)
        } catch {
            return .failure(error)
        }
    }
}
