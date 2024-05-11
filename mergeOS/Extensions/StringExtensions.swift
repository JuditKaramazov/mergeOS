//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import Foundation

extension String {
  func trunc(length: Int, trailing: String = "…") -> String {
    return (self.count > length) ? self.prefix(length) + trailing : self
  }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
