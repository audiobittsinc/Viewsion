//
//  UserEmailBtn.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/13/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI
import MessageUI

struct UserEmailBtn: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack {
                    if MFMailComposeViewController.canSendMail() {
                        Button("Show mail view") {
                            self.isShowingMailView.toggle()
                        }
                    } else {
                        Text("Can't send emails from this device")
                    }
                    if result != nil {
                        Text("Result: \(String(describing: result))")
                            .lineLimit(nil)
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: self.$isShowingMailView, result: self.$result)
                }
    }
}

struct UserEmailBtn_Previews: PreviewProvider {
    static var previews: some View {
        UserEmailBtn()
    }
}
