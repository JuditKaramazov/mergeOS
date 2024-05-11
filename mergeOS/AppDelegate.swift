//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import Cocoa
import Defaults
import SwiftUI
import Foundation
import KeychainAccess

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    // Defaults
    @Default(.showAssigned) var showAssigned
    @Default(.showCreated) var showCreated
    @Default(.showRequested) var showRequested
    @Default(.showAvatar) var showAvatar
    @Default(.showLabels) var showLabels
    @Default(.refreshRate) var refreshRate
    @Default(.buildType) var buildType
    @Default(.counterType) var counterType
    @Default(.githubUsername) var githubUsername
    @FromKeychain(.githubToken) var githubToken
    
    // Properties
    let ghClient = GitHubClient()
    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu: NSMenu = NSMenu()
    var settingsWindow: NSWindow!
    var aboutWindow: NSWindow!
    var timer: Timer? = nil

    // Methods
    func updateStatusBarIcon() {
        guard let statusButton = statusBarItem.button else { 
            return
        }
        let selectedMenuIcon = Defaults[.menuIcon]
        
        let icon = NSImage(named: selectedMenuIcon)
        let size = NSSize(width: 16, height: 16)
        icon?.isTemplate = true
        icon?.size = size

        statusBarItem.button?.image = icon
        statusButton.imagePosition = NSControl.ImagePosition.imageLeft
        statusBarItem.menu = menu
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.windowClosed), name: NSWindow.willCloseNotification, object: nil)

        NSApp.setActivationPolicy(.regular)
                
        timer = Timer.scheduledTimer(
            timeInterval: Double(refreshRate * 60),
            target: self,
            selector: #selector(refreshMenu),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
        RunLoop.main.add(timer!, forMode: .common)
        
        updateStatusBarIcon()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {

    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc
    func openLink(_ sender: NSMenuItem) {
        NSWorkspace.shared.open(sender.representedObject as! URL)
    }
    
}

extension AppDelegate {
    // MARK: - Refreshes menu.
    @objc
    func refreshMenu() {
        self.menu.removeAllItems()

        // If there is no GitHub username or token, adds footer items and returns.
        if (githubUsername == "" || githubToken == "") {
            addMenuFooterItems()
            return
        }

        // Initializes pull request arrays.
        var assignedPulls: [Edge]? = []
        var createdPulls: [Edge]? = []
        var reviewRequestedPulls: [Edge]? = []

        // Creates a dispatch group for async tasks.
        let group = DispatchGroup()

        // Fetches assigned pull requests if the option is enabled.
        if showAssigned {
            group.enter()
            ghClient.getAssignedPulls() { pulls in
                assignedPulls?.append(contentsOf: pulls)
                group.leave()
            }
        }

        // Fetches created pull requests if the option is enabled.
        if showCreated {
            group.enter()
            ghClient.getCreatedPulls() { pulls in
                createdPulls?.append(contentsOf: pulls)
                group.leave()
            }
        }

        // Fetches review requested pull requests if the option is enabled.
        if showRequested {
            group.enter()
            ghClient.getReviewRequestedPulls() { pulls in
                reviewRequestedPulls?.append(contentsOf: pulls)
                group.leave()
            }
        }

        // Processes all pull requests once they are fetched.
        group.notify(queue: .main) {
            if let assignedPulls = assignedPulls, let createdPulls = createdPulls, let reviewRequestedPulls = reviewRequestedPulls {
                self.statusBarItem.button?.title = ""

                if self.showAssigned && !assignedPulls.isEmpty {
                    if self.counterType == .assigned {
                        self.statusBarItem.button?.title = String(assignedPulls.count)
                    }

                    self.menu.addItem(NSMenuItem(title: "Assigned (\(assignedPulls.count))", action: nil, keyEquivalent: ""))
                    for pull in assignedPulls {
                        self.menu.addItem(self.createMenuItem(pull: pull))
                    }
                    self.menu.addItem(.separator())
                }
                
                if self.showCreated && !createdPulls.isEmpty {
                    if self.counterType == .created {
                        self.statusBarItem.button?.title = String(createdPulls.count)
                    }

                    self.menu.addItem(NSMenuItem(title: "Created (\(createdPulls.count))", action: nil, keyEquivalent: ""))
                    for pull in createdPulls {
                        self.menu.addItem(self.createMenuItem(pull: pull))
                    }
                    self.menu.addItem(.separator())
                }

                if self.showRequested && !reviewRequestedPulls.isEmpty {
                    if self.counterType == .reviewRequested {
                        self.statusBarItem.button?.title = String(reviewRequestedPulls.count)
                    }

                    self.menu.addItem(NSMenuItem(title: "Review Requested (\(reviewRequestedPulls.count))", action: nil, keyEquivalent: ""))
                    for pull in reviewRequestedPulls {
                        self.menu.addItem(self.createMenuItem(pull: pull))
                    }
                    self.menu.addItem(.separator())
                }
                self.addMenuFooterItems()
            }
        }
    }
    
    // MARK: - Creates Pull Request menu item.
    func createMenuItem(pull: Edge) -> NSMenuItem {
        let issueItem = NSMenuItem(title: "", action: #selector(self.openLink), keyEquivalent: "")
        
        let issueItemTitle = NSMutableAttributedString(string: "")
            .appendString(string: pull.node.isReadByViewer ? "" : "⏺ ", color: .systemBlue)
        
        if (pull.node.isDraft) {
            issueItemTitle
                .appendIcon(iconName: "git-draft-pull-request", color: NSColor.secondaryLabelColor)
        }
        // Appends the pull request title, number, and other details to the title.
        issueItemTitle
            .appendString(string: pull.node.title.trunc(length: 50), color: NSColor(.primary))
            .appendString(string: " #" +  String(pull.node.number))
            .appendSeparator()
        
        issueItemTitle
            .appendNewLine()
        // Appends repository and author details.
        issueItemTitle
            .appendIcon(iconName: "repo")
            .appendString(string: pull.node.repository.name)
            .appendSeparator()
            .appendIcon(iconName: "person")
            .appendString(string: pull.node.author.login)
        // Appends labels - if they exist.
        if !pull.node.labels.nodes.isEmpty && self.showLabels {
            issueItemTitle
                .appendNewLine()
                .appendIcon(iconName: "tag", color: NSColor(.secondary))
            for label in pull.node.labels.nodes {
                issueItemTitle
                    .appendString(string: label.name, color: hexColor(hex: label.color), fontSize: NSFont.smallSystemFontSize)
                    .appendSeparator()
            }
        }
        
        issueItemTitle.appendNewLine()
        // Appends review and changes details.
        let approvedByMe = pull.node.reviews.edges.contains{ $0.node.author.login == githubUsername }
        issueItemTitle
            .appendIcon(iconName: "check-circle", color: approvedByMe ? NSColor(named: "green")! : NSColor.secondaryLabelColor)
            .appendString(string: " " + String(pull.node.reviews.totalCount))
            .appendSeparator()
            .appendString(string: "+" + String(pull.node.additions ?? 0), color: NSColor(named: "green")!)
            .appendString(string: " -" + String(pull.node.deletions ?? 0), color: NSColor(named: "red")!)
            .appendSeparator()
            .appendIcon(iconName: "calendar")
            .appendString(string: pull.node.createdAt.getElapsedInterval())
        
        if showAvatar {
        var image = NSImage()
        if let imageURL = pull.node.author.avatarUrl {
            image = NSImage.imageFromUrl(fromURL: imageURL) ?? NSImage(named: "person")!
        } else {
            image = NSImage(named: "person")!
        }
        image.cacheMode = .always
        if ((image.size.height != 36) || (image.size.width != 36)) {
            image.size = NSSize(width: 36.0, height: 36.0)
        }

        let avatarImage = NSImage(size: NSSize(width: 36.0, height: 36.0), flipped: false) { rect in
            let clippingPath = NSBezierPath(ovalIn: rect)
            clippingPath.addClip()
            image.draw(in: rect)
            return true
        }
            issueItem.image = avatarImage
        }
        
        // Adds checkSuites to submenu - if they exist.
        if let commits = pull.node.commits {
            if let checkSuites = commits.nodes[0].commit.checkSuites {
                if checkSuites.nodes.count > 0 {
                    issueItem.submenu = NSMenu()
                    issueItemTitle
                        .appendSeparator()
                        .appendIcon(iconName: "checklist", color: NSColor.secondaryLabelColor)
                }
                for checkSuite in checkSuites.nodes {
                    if checkSuite.checkRuns.nodes.count > 0 {
                        issueItem.submenu?.addItem(withTitle: checkSuite.app?.name ?? "empty", action: nil, keyEquivalent: "")
                    }
                    for check in checkSuite.checkRuns.nodes {
                        let buildItem = NSMenuItem(title: check.name, action: #selector(self.openLink), keyEquivalent: "")
                        buildItem.representedObject = check.detailsUrl
                        buildItem.toolTip = check.conclusion
                        if check.conclusion  == "SUCCESS" {
                            buildItem.image = NSImage(named: "check-circle-fill")!.tint(color: NSColor(named: "green")!)
                            issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor(named: "green")!)
                        } else if check.conclusion  == "FAILURE" {
                            buildItem.image = NSImage(named: "x-circle-fill")!.tint(color: NSColor(named: "red")!)
                            issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor(named: "red")!)
                        } else if check.conclusion  == "ACTION_REQUIRED" {
                            buildItem.image = NSImage(named: "issue-draft")!.tint(color: NSColor(named: "yellow")!)
                            issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor(named: "yellow")!)
                        } else {
                            buildItem.image = NSImage(named: "question")!.tint(color: NSColor.gray)
                            issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor.gray)
                        }
                        issueItem.submenu?.addItem(buildItem)
                    }
                }
            }
            // Adds statusCheckRollup to submenu - if they exist.
            else if let statusCheckRollup = commits.nodes[0].commit.statusCheckRollup {
                if statusCheckRollup.contexts.nodes.count > 0 {
                    issueItem.submenu = NSMenu()
                    issueItemTitle
                        .appendSeparator()
                        .appendIcon(iconName: "checklist", color: NSColor.secondaryLabelColor)
                }
                for check in statusCheckRollup.contexts.nodes {
                    let itemTitle = NSMutableAttributedString()
                    itemTitle.appendString(string: check.name ?? check.context ?? "<empty>", color: NSColor(.primary))
                    itemTitle.appendNewLine()
                        .appendString(string: check.description ?? check.title ?? "<empty>", color: NSColor(.secondary))
                    
                    let buildItem = NSMenuItem(title: "", action: #selector(AppDelegate.openLink), keyEquivalent: "")

                    buildItem.attributedTitle = itemTitle
                    buildItem.representedObject = check.detailsUrl ?? URL.init(string:check.targetUrl ?? "")
                    buildItem.toolTip = check.conclusion ?? check.state ?? ""
                    
                    let status = check.conclusion ?? check.state ?? ""
                    switch status {
                    case "SUCCESS":
                        buildItem.image = NSImage(named: "check-circle-fill")!.tint(color: NSColor(named: "green")!)
                        issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor(named: "green")!)
                    case "FAILURE":
                        buildItem.image = NSImage(named: "x-circle-fill")!.tint(color: NSColor(named: "red")!)
                        issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor(named: "red")!)
                    case "PENDING":
                        buildItem.image = NSImage(named: "issue-draft")!.tint(color: NSColor(named: "yellow")!)
                        issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor(named: "yellow")!)
                    default:
                        buildItem.image = NSImage(named: "question")!.tint(color: NSColor.gray)
                        issueItemTitle.appendIcon(iconName: "dot-fill", color: NSColor.gray)
                        
                    }
                    issueItem.submenu?.addItem(buildItem)
                }
            }
        }
        
        // Sets the attributed title of the issue item.
        issueItem.attributedTitle = issueItemTitle
        if pull.node.title.count > 50 {
            issueItem.toolTip = pull.node.title
        }
        issueItem.representedObject = pull.node.url
        
        return issueItem
    }
    
    // MARK: - Adds footer items to main menu.
    func addMenuFooterItems() {
        self.menu.addItem(withTitle: "Refresh", action: #selector(self.refreshMenu), keyEquivalent: Defaults[.refreshKey])
        let showAvatarMenuItem = NSMenuItem(title: "Show Avatar", action: #selector(self.toggleShowAvatar), keyEquivalent: "t")
        if showAvatar {
            showAvatarMenuItem.title = "Show Avatar ✓"
        }
        self.menu.addItem(showAvatarMenuItem)
        self.menu.addItem(.separator())
        self.menu.addItem(withTitle: "Settings...", action: #selector(self.openSettingsWindow), keyEquivalent: Defaults[.settingsKey])
        self.menu.addItem(withTitle: "About...", action: #selector(self.openAboutWindow), keyEquivalent: "a")
        self.menu.addItem(withTitle: "Quit", action: #selector(self.quit), keyEquivalent: Defaults[.quitKey])
    }
    
    // MARK: - Opens Settings window.
    @objc
    func openSettingsWindow(_: NSStatusBarButton?) {
        let contentView = SettingsView()
        if settingsWindow != nil {
            settingsWindow.close()
        }
        settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 0, height: 0),
            styleMask: [.closable, .titled],
            backing: .buffered,
            defer: false
        )
        
        settingsWindow.title = "Settings"
        settingsWindow.contentView = NSHostingView(rootView: contentView)
        settingsWindow.makeKeyAndOrderFront(nil)
        settingsWindow.styleMask.remove(.resizable)
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        let controller = NSWindowController(window: settingsWindow)
        controller.showWindow(self)
        
        settingsWindow.center()
        settingsWindow.orderFrontRegardless()
    }

    // MARK: - Toggles avatar visibility.
    @objc
    func toggleShowAvatar() {
        showAvatar.toggle()
        refreshMenu()
    }

    // MARK: - Opens About window.
    @objc
    func openAboutWindow(_: NSStatusBarButton?) {
        let contentView = AboutView()
        if aboutWindow != nil {
            aboutWindow.close()
        }
        aboutWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 280, height: 350),
            styleMask: [.closable, .titled],
            backing: .buffered,
            defer: false
        )
        
        aboutWindow.title = "About"
        aboutWindow.contentView = NSHostingView(rootView: contentView)
        aboutWindow.makeKeyAndOrderFront(nil)
        aboutWindow.styleMask.remove(.resizable)
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        let controller = NSWindowController(window: aboutWindow)
        controller.showWindow(self)
        
        aboutWindow.center()
        aboutWindow.orderFrontRegardless()
    }
    
    // MARK: Handles window closed.
    @objc
    func windowClosed(notification: NSNotification) {
        let window = notification.object as? NSWindow
        if let windowTitle = window?.title {
            if (windowTitle == "Settings") {
                timer?.invalidate()
                timer = Timer.scheduledTimer(
                    timeInterval: Double(refreshRate * 60),
                    target: self,
                    selector: #selector(refreshMenu),
                    userInfo: nil,
                    repeats: true
                )
                timer?.fire()
            }
        }
        updateStatusBarIcon()
    }
    
    // MARK: - Quits the app.
    @objc
    func quit() {
        NSApplication.shared.terminate(self)
    }
}
