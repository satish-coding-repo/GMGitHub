//
//  GMCommit.swift
//  GMGitProject
//
//  Created by Satish on 17/01/21.
//

import Foundation

// MARK: - CommitsBase Element
struct GMCommit: Codable {
    let sha: String
    let commit: Commit
}

// MARK: - Commit
struct Commit: Codable {
    let author, committer: CommitAuthor
    let message: String
}

// MARK: - CommitAuthor
struct CommitAuthor: Codable {
    let name: String
    let email: String
    let date: String
}

typealias GMCommits = [GMCommit]

