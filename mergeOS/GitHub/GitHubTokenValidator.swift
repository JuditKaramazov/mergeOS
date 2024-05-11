//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import Foundation
import SwiftUI

class GitHubTokenValidator: ObservableObject {
    @Published var iconName: String!;
    @Published var iconColor: Color!;
    
    init() {
        setLoading()
    }
    
    func setLoading() {
        
        self.iconName = "clock.fill"
        self.iconColor = Color(.systemGray)
    }
    
    func setInvalid() {
        self.iconName = "exclamationmark.circle.fill"
        self.iconColor = Color(.systemRed)
    }
    
    func setValid() {
        self.iconName = "checkmark.circle.fill"
        self.iconColor = Color(.systemGreen)
        
    }
    
    func validate() {
        self.setLoading()
        
        GitHubClient().getUser() { user in
            if user != nil {
                self.setValid()
            } else {
                self.setInvalid()
            }
        }
    }
}
