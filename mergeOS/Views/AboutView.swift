//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) var openURL
    
    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    private var links: NSMutableAttributedString {
        let string = NSMutableAttributedString(string: "Website │ GitHub │ Support",
                                               attributes: [NSAttributedString.Key.foregroundColor: NSColor.labelColor])
        string.addAttribute(.link, value: "https://karamazfolio.xyz", range: NSRange(location: 0, length: 7))
        string.addAttribute(.link, value: "https://github.com/JuditKaramazov/mergeOS", range: NSRange(location: 8, length: 6))
        string.addAttribute(.link, value: "mailto:j.lazaromoyano7@gmail.com", range: NSRange(location: 18, length: 8))
        return string
    }
    
    var body: some View {
        VStack {
            Image(nsImage: NSImage(named: "AppIcon")!)
            Text("mergeOS").font(.title)
            Text("Version " + currentVersion).font(.footnote)
            Divider()
            
            Text(AttributedString(links))
                .lineLimit(1)
                .onTapGesture { 
                    if let urlString = self.links.attribute(.link, at: 0, effectiveRange: nil) as? String,
                       let url = URL(string: urlString) {
                        openURL(url)
                    }
                }
                .onHover { isHovering in
                    NSCursor.pointingHand.set()
                }
                .padding(.top, 3)

            Button(action: {
                openURL(URL(string:"https://github.com/JuditKaramazov/mergeOS/issues/new?assignees=&labels=bug&projects=&template=bug_report.md&title=")!)
            }) {
                HStack {
                    Image(systemName: "ladybug.fill")
                    Text("Bug Report")
                }
            }
            .padding(.top, 4)
            .padding(.bottom, 3)
            
            Divider()

            Link(destination: URL(string: "https://www.buymeacoffee.com/JuditKaramazov")!) {
                Image("buymeacoffee")
                    .resizable()
                    .scaledToFit()
            }
            
            Text("Judit Lázaro, 2024").font(.caption)
        }
        .padding()
    }
}

struct AboutTab_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
