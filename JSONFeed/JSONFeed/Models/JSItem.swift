//
//  JSItem.swift
//  JSONFeed
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

public struct JSItem: Decodable {
    public let id: String
    public let url: URL?
    public let external: URL?
    public let title: String?
    public let text: String?
    public let html: String?
    public let summary: String?
    public let image: URL?
    public let banner: URL?
    public let published: Date
    public let modified: Date?
    public let author: JSAuthor?
    public let tags: [String]?
    public let attachments: [JSAttachment]
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case external = "external_url"
        case title
        case text = "content_text"
        case html = "content_html"
        case summary
        case image
        case banner = "banner_image"
        case published = "date_published"
        case modified = "date_modified"
        case author
        case tags
        case attachments
    }
}

