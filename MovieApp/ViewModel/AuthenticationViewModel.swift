//
//  AuthenticationViewModel.swift
//

import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func signIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            //GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            //    authenticateUser(for: user, with: error)
            //}
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] signResult, error in
                authenticateUser(for: signResult, with: error)
            }
        }
    }
    
    private func authenticateUser(for signResult: GIDSignInResult?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let user = signResult?.user,
              let idToken = user.idToken else { return }
        
        let accessToken = user.accessToken
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
