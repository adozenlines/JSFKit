//
//  JSFeed.swift
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

public struct JSFeed: Decodable {
    public let version: URL
    public let title: String
    public let homePage: URL?
    public let feed: URL?
    public let description: String?
    public let userComment: String?
    public let next: URL?
    public let icon: URL?
    public let favicon: URL?
    public let author: JSAuthor?
    public let hasExpired: Bool
    public let hubs: [JSHub]?
    public let items: [JSItem]
    
    enum CodingKeys: String, CodingKey {
        case version
        case title
        case homePage = "home_page_url"
        case feed = "feed_url"
        case description
        case userComment = "user_comment"
        case next = "next_url"
        case icon
        case favicon
        case author
        case hasExpired = "expired"
        case hubs
        case items
    }
}
