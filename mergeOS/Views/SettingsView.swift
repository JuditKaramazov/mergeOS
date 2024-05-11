//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import SwiftUI
import Defaults
import LaunchAtLogin

struct SettingsView: View {
    @Default(.buildType) var builtType
    @Default(.counterType) var counterType
    @Default(.showAssigned) var showAssigned
    @Default(.showCreated) var showCreated
    @Default(.showRequested) var showRequested
    @Default(.showLabels) var showLabels
    @Default(.refreshRate) var refreshRate

    @ObservedObject private var launchAtLogin = LaunchAtLogin.observable
    
    @State private var showGhAlert = false
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TabBarButton(imageName: "lock.shield", text: "Authentication", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                
                TabBarButton(imageName: "gear", text: "General", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }

                TabBarButton(imageName: "command", text: "Shortcuts", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
                
                TabBarButton(imageName: "paintbrush.fill", text: "Appearance", isSelected: selectedTab == 3) {
                    selectedTab = 3
                }
            }
            .padding()

            Divider()
                .padding(.bottom)
            
            switch selectedTab {
            case 0:
                AuthenticationForm()
            case 1:
                GeneralForm()
            case 2:
                ShortcutsForm()
            case 3: 
                AppearanceForm()
            default:
                EmptyView()
            }
        }
        .padding()
    }
}

struct TabBarButton: View {
    let imageName: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(text)
                    .font(Font.caption)
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.clear, lineWidth: 2)
            )
        }
        .frame(width: 90, height: 40)
        .buttonStyle(PlainButtonStyle())
    }
}

struct AuthenticationForm: View {
    @Default(.githubApiBaseUrl) var githubApiBaseUrl
    @Default(.githubUsername) var githubUsername
    @FromKeychain(.githubToken) var githubToken

    @StateObject private var githubTokenValidator = GitHubTokenValidator()
    
    var body: some View {
        Form {
            HStack(alignment: .center) {
                Text("Endpoint URL:")
                    .frame(width: 120, alignment: .trailing)
                TextField("", text: $githubApiBaseUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textContentType(.password)
                    .frame(width: 200)
            }

            HStack(alignment: .center) {
                Text("Username:")
                    .frame(width: 120, alignment: .trailing)
                TextField("", text: $githubUsername)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textContentType(.password)
                    .frame(width: 200)
            }
            
            HStack(alignment: .center) {
                Text("Token:")
                    .frame(width: 120, alignment: .trailing)
                VStack(alignment: .leading) {
                    HStack() {
                        SecureField("", text: $githubToken)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                Image(systemName: githubTokenValidator.iconName)
                                    .foregroundColor(githubTokenValidator.iconColor)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 8)
                            )
                            .frame(width: 380)
                            .onChange(of: githubToken) { _ in
                                githubTokenValidator.validate()
                            }
                        Button {
                            githubTokenValidator.validate()
                        } label: {
                            Image(systemName: "repeat")
                        }
                        .help("Retry")
                    }
                    Text("[Generate](https://github.com/settings/tokens/new?scopes=repo) a personal access token with **repo** scope")
                        .font(.footnote)
                        .padding(.leading, 8)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .onAppear() {
            githubTokenValidator.validate()
        }
    }
}

struct GeneralForm: View {
    @Default(.buildType) var builtType
    @Default(.showAssigned) var showAssigned
    @Default(.showCreated) var showCreated
    @Default(.showRequested) var showRequested
    @Default(.showLabels) var showLabels
    @Default(.refreshRate) var refreshRate

    @ObservedObject private var launchAtLogin = LaunchAtLogin.observable

    var body: some View {
        Form {
            HStack(alignment: .center) {
                Text("Build Information:")
                    .frame(width: 120, alignment: .trailing)
                Picker("", selection: $builtType, content: {
                    ForEach(BuildType.allCases) { bt in
                        Text(bt.description)
                    }
                })
                .labelsHidden()
                .pickerStyle(RadioGroupPickerStyle())
                .frame(width: 120)
            }
            .padding(.bottom)

            HStack(alignment: .center) {
                Text("Pull Requests:")
                    .frame(width: 120, alignment: .trailing)
                VStack(alignment: .leading){
                    Toggle("assigned", isOn: $showAssigned)
                    Toggle("created", isOn: $showCreated)
                    Toggle("review requested", isOn: $showRequested)
                }
            }
            .padding(.bottom)
            
            HStack(alignment: .center) {
                Text("Refresh Rate:")
                    .frame(width: 120, alignment: .trailing)
                Picker("", selection: $refreshRate, content: {
                    Text("1 minute").tag(1)
                    Text("5 minutes").tag(5)
                    Text("10 minutes").tag(10)
                    Text("15 minutes").tag(15)
                    Text("30 minutes").tag(30)
                })
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 100)
            }

            HStack(alignment: .center) {
                Text("Show Labels:")
                    .frame(width: 120, alignment: .trailing)
                Toggle("", isOn: $showLabels)
            }
            
            HStack(alignment: .center) {
                Text("Launch at login:")
                    .frame(width: 120, alignment: .trailing)
                Toggle("", isOn: $launchAtLogin.isEnabled)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct ShortcutsForm: View {
    @Default(.refreshKey) var refreshKey
    @Default(.settingsKey) var settingsKey
    @Default(.quitKey) var quitKey

    var body: some View {
        Form {
            Text("Record Shortcut:")
                .padding(.top)
                .padding (.bottom)

            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Text("Refresh Key")
                        .frame(width: 120, alignment: .center)
                    HStack {
                        Text("⌘ +")
                        TextField("", text: $refreshKey)
                            .frame(width: 30)
                    }
                }

                VStack(alignment: .center) {
                    Text("Settings Key")
                        .frame(width: 120, alignment: .center)
                    HStack {
                        Text("⌘ +")
                        TextField("", text: $settingsKey)
                            .frame(width: 30)
                    }
                }

                VStack(alignment: .center) {
                    Text("Quit Key")
                        .frame(width: 120, alignment: .center)
                    HStack {
                        Text("⌘ +")
                        TextField("", text: $quitKey)
                            .frame(width: 30)
                    }
                }
            }
            .labelsHidden()
            .padding(.bottom)
        }
    }
}

struct AppearanceForm: View {
    @Default(.counterType) var counterType
    @Default(.menuIcon) var selectedMenuIcon: String 

    var body: some View {
        Form {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Counter:")
                    Text("Number of pull requests appearing next to the icon")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Picker("", selection: $counterType, content: {
                    ForEach(CounterType.allCases) { bt in
                        Text(bt.description)
                    }
                })
                .labelsHidden()
                .pickerStyle(RadioGroupPickerStyle())
                .padding(.bottom)
            }

            HStack(alignment: .center) {
                Text("Menu Icon:")
                    .frame(width: 120, alignment: .leading)
                HStack {
                    ForEach(MenuIcon.allCases, id: \.self) { icon in
                        Button(action: {
                            selectedMenuIcon = icon.rawValue
                            Defaults[.menuIcon] = icon.rawValue
                        }) {
                            icon.image
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundColor(icon.rawValue == selectedMenuIcon ? .blue : .primary)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.leading, -55)
            }
            .padding(.bottom)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
