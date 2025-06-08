//
//  Question.swift
//  CampusNavigatorApp
//
//

struct Question: Identifiable {
    let id: Int
    let title: String
    let preview: String
    let tags: [String]
    let userName: String
    let timeAgo: String
    let answerCount: Int
}
