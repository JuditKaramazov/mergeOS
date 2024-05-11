//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import Foundation
import SwiftUI

extension NSImage {
    convenience init?(named: String, color: NSColor) {
        let img = NSImage.init(named: named)!
        let newImg = img.tint(color: color)
        self.init(data: newImg.tiffRepresentation!)
    }
    
    static func imageFromUrl(fromURL url: URL) -> NSImage? {
        guard let data = try? Foundation.Data(contentsOf: url) else { return nil }
        guard let image = NSImage(data: data) else { return nil }
        return image
    }
    
    func tint(color: NSColor) -> NSImage {
        let newImage = NSImage(size: self.size)
        newImage.lockFocus()

        let imageRect = NSRect(origin: .zero, size: self.size)
        self.draw(in: imageRect, from: imageRect, operation: .sourceOver, fraction: color.alphaComponent)

        color.withAlphaComponent(1).set()
        imageRect.fill(using: .sourceAtop)

        newImage.unlockFocus()
        return newImage
    }
    
}
