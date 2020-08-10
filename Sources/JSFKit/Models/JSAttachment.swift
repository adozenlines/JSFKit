//
//  JSAttachment.swift
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

public struct JSAttachment: Decodable {
    public let url: URL
    public let mimeType: String
    public let title: String?
    public let bytes: Int?
    public let seconds: Int?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case mimeType = "mime_type"
        case title = "title"
        case bytes = "size_in_bytes"
        case seconds = "duration_in_seconds"
    }
}

extension JSAttachment {
    public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            url = try values.decode(URL.self, forKey: .url)
            mimeType = try values.decode(String.self, forKey: .mimeType)
            title = try values.decode(String.self, forKey: .title)
            bytes = try values.decode(Int.self, forKey: .bytes)
            seconds = try values.decode(Int.self, forKey: .seconds)
            
        } catch {
            throw error
        }
    }
}
