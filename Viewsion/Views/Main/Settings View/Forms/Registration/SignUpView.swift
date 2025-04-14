//
//  SignUpView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authenticator: Authenticator
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var action: Int? = 0
    
    @State private var emailVal = ""
    @State private var usernameVal = ""
    @State private var passwordVal = ""
    @State private var confirmPasswordVal = ""
    
    @State private var signUpSuccessful: Bool = false
    @State private var isSignUp: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue            
                VStack {
                    Form {
                        Group {
                            VStack{
                                Spacer()
                                HStack {
                                    Text("Email:")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                TextField("Email",
                                          text: $email)
                                    .foregroundColor(.secondary)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                HStack {
                                    if !emailVal.isEmpty {
                                        Text(emailVal)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                }
                            }
                            VStack {
                                Spacer()
                                HStack {
                                    Text("Username:")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                TextField("Username",
                                          text: $username)
                                    .foregroundColor(.secondary)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                HStack {
                                    if !usernameVal.isEmpty {
                                        Text(usernameVal)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                    
                                }
                            }
                            VStack {
                                Spacer()
                                HStack {
                                    Text("Password:")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                SecureField("Password",
                                            text: $password)
                                    .foregroundColor(.secondary)
                                HStack {
                                    if !passwordVal.isEmpty {
                                        Text(passwordVal)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                }
                            }
                            VStack {
                                Spacer()
                                HStack {
                                    Text("Confirm Password:")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                SecureField("Confirm Password",
                                            text: $confirmPassword)
                                    .foregroundColor(.secondary)
                                HStack {
                                    if !confirmPasswordVal.isEmpty {
                                        Text(confirmPasswordVal)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                }
                            }
                            HStack {
                                Button(action: {
                                    if self.isUserInformationValid() {
                                        print("Signing Up")
                                        authenticator.signUp(user: UserSignUp(email: email, userName: username, password: password))
                                    }
                                }, label: {
                                    Text("Sign Up")
                                        .font(.title)
                                }).disabled(isSignUpDisabled)
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .opacity(authenticator.isAuthenticating && isSignUp ? 1.0 : 0.0)
                            }
                        }
                        .listRowBackground(Color(.sRGB, red: 0, green: 1, blue: 1, opacity: 0.5))
                    }.padding()
                        .navigationBarTitle(Text("Create an Account"))
                        .font(.title3)
                    
                        .toolbar {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "xmark")
                            }).padding()
                        }
                }
            }
        }
    }
    
    private var isSignUpDisabled: Bool {
        authenticator.isAuthenticating || email.isEmpty || password.isEmpty || username.isEmpty || confirmPassword.isEmpty
    }
    
    private var isSigningUp: Bool {
        isSignUp = true
        return isSignUp
    }
    
    private func isUserInformationValid() -> Bool {
        if !self.textFieldValidatorEmail(email) {
            emailVal = "Enter valid email address."
            return false
            
        } else {
            emailVal = ""
        }
        
        if username.isEmpty || username.count < 6 {
            usernameVal = "Enter valid username with 6 characters."
            return false
        } else {
            usernameVal = ""
        }
        
        if password.isEmpty && confirmPassword.isEmpty{
            passwordVal = "Enter a password."
            return false
        } else {
            passwordVal = ""
        }
        
        if password.count < 6 {
            passwordVal = "Enter a password with 6 characters."
            return false
        } else {
            passwordVal = ""
        }
        
        if password != confirmPassword {
            confirmPasswordVal = "Passwords do not match."
            return false
        } else {
            confirmPasswordVal = ""
        }
        return true
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Authenticator())
    }
}
