//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import SwiftUI


struct BottomItemView: View {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some View {
        
        HStack {             
            Button{
                appDelegate.refreshMenu()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.secondary)
                    
                    Image(systemName: "repeat")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .contentShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
            .accessibilityLabel(Text("Close"))

            Spacer()

            HStack(alignment: .bottom){
                Button{
                    appDelegate.openSettingsWindow(nil)
                    
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.secondary)
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    .contentShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel(Text("Close"))
                
                
                Button{
                    appDelegate.openAboutWindow(nil)
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.secondary)
                        
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    .contentShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel(Text("Close"))
                
                
                Button{
                    appDelegate.quit()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.secondary)
                        
                        Image(systemName: "power.circle.fill")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    .contentShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel(Text("Close"))
            }
            
        }.border(Color.pink)
            .frame(maxWidth: .infinity, alignment: .trailing)
        
        
    }
}

struct BottomItemView_Previews: PreviewProvider {
    static var previews: some View {
        BottomItemView()
    }
}
