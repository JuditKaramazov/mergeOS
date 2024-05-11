//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import Foundation
import Defaults
import SwiftUI

extension Defaults.Keys {
    static let buildType = Key<BuildType>("buildType", default: .none)
    static let counterType = Key<CounterType>("counterType", default: .reviewRequested)

    static let githubApiBaseUrl = Key<String>("githubApiBaseUrl", default: "https://api.github.com")
    static let githubUsername = Key<String>("githubUsername", default: "")
    
    static let menuIcon = Key<String>("menuIcon", default: "pull-request")
    static let refreshKey = Key<String>("refreshKey", default: "r")
    static let settingsKey = Key<String>("settingsKey", default: "s")
    static let quitKey = Key<String>("quitKey", default: "q")
    
    static let showAssigned = Key<Bool>("showAssigned", default: false)
    static let showCreated = Key<Bool>("showCreated", default: false)
    static let showRequested = Key<Bool>("showRequested", default: true)  
    static let showAvatar = Key<Bool>("showAvatar", default: false)
    static let showLabels = Key<Bool>("showLabels", default: true)
    static let refreshRate = Key<Int>("refreshRate", default: 5)
}

extension KeychainKeys {
    static let githubToken: KeychainAccessKey = KeychainAccessKey(key: "githubToken")
}

enum BuildType: String, Defaults.Serializable, CaseIterable, Identifiable {
    case checks
    case commitStatus
    case none
    
    var id: Self { self }

    var description: String {

        switch self {
        case .checks:
            return "checks"
        case .commitStatus:
            return "commit statuses"
        case .none:
            return "none"
        }
    }
}

enum CounterType: String, Defaults.Serializable, CaseIterable, Identifiable {
    case assigned
    case created
    case reviewRequested
    case none
    
    var id: Self { self }

    var description: String {

        switch self {
        case .assigned:
            return "assigned"
        case .created:
            return "created"
        case .reviewRequested:
            return "review requested"
        case .none:
            return "none"
        }
    }
}

enum MenuIcon: String, CaseIterable {
    case gitPullRequest = "pull-request"
    case github = "github"
    case octocat = "octocat"
    case suitcase = "suitcase"
    
    var image: Image {
        switch self {
        case .gitPullRequest: 
            return Image("pull-request")
        case .github: 
            return Image("github")
        case .octocat: 
            return Image("octocat")
        case .suitcase: 
            return Image("suitcase")
        }
    }
}
