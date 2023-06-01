//
//  LoginView.swift
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authModel: AuthenticationViewModel
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: proxy.size.width,
                           maxHeight: proxy.size.height)
            }
            VStack {
                Text("Sign In")
                    .font(.oswald(size: 40))
                    .fontWeight(.bold)
                    .padding(.vertical, 50)
                    .padding(.bottom, 100)
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .padding(.leading, 10)
                        TextField("Email address", text: $email)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    .font(.oswald(style: .title3))
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.steam_background)
                    .foregroundColor(Color.steam_foreground)
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 10)
                    
                    
                    PrimaryButton(title: "Sign Up")
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 10)
                    Text("Forgot passowrd?")
                        .padding(.bottom, 10)
                    
                    HStack {
                        VStack { Divider().background(Color.steam_foreground) }
                        Text("or")
                            .foregroundColor(.steam_foreground.opacity(0.7))
                        VStack { Divider().background(Color.steam_foreground) }
                    }

                    
                    SocalLoginButton(image: Image("apple"), text: Text("Sign in with Apple"))
                    
                    GoogleSignInButton()
                            .padding()
                            .onTapGesture {
                                authModel.signIn()
                            }
                    
//                    SocalLoginButton(image: Image("google"), text: Text("Sign in with Google"))
//
                }
                .shadow(color: Color.black.opacity(0.08), radius: 15, x: 0, y: 5)
                .padding(20)
                .glassmorpism(radius: 30, lineWidth: 0, saturation: 44)
            
                Spacer()
                Divider()
                Text("Read our Terms & Conditions")
                    .foregroundColor(.primary)
            }
            .padding()
        }
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.oswald(style: .title3))
            .fontWeight(.bold)
            .foregroundColor(.steam_foreground)
            .frame(maxWidth: .infinity)
            .padding(8)
            .glassmorpism(radius: 50, lineWidth: 1, saturation: 0, blur: 0)
    }
}

struct SocalLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .padding(.leading, -20)
                .padding(.horizontal)
            text
                .font(.oswald(style: .title3))
                .textCase(.none)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .glassmorpism(radius: 50, lineWidth: 0, saturation: 44)
    }
}

#if DEBUG
struct Login_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
