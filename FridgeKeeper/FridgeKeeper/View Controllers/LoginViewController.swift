//
//  ViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/6/23.
//

import AuthenticationServices
import GoogleSignIn
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Views
    private let appleSignInButton = ASAuthorizationAppleIDButton()
    private let googleSignInButton = GIDSignInButton()
    private let sloganLabel = UILabel()
    private let titleLabel = UILabel()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupGoogleSignIn()
        setupAppleSignIn()
    }
    
    // MARK: - Setup Views
    
    private func setupTitleLabel() {
        titleLabel.text = "FridgeKeeper"
        titleLabel.font = .customFont(of: 24, weight: .bold)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
        }
        
        sloganLabel.text = "Where Ingredients Meet Inspiration"
        sloganLabel.font = .customFont(of: 18, weight: .semibold)
        view.addSubview(sloganLabel)
        
        sloganLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupAppleSignIn() {
        appleSignInButton.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
        view.addSubview(appleSignInButton)
        
        appleSignInButton.snp.makeConstraints { make in
            make.top.equalTo(googleSignInButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(googleSignInButton)
        }
    }
    
    private func setupGoogleSignIn() {
        googleSignInButton.style = .wide
        googleSignInButton.colorScheme = .light
        googleSignInButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        view.addSubview(googleSignInButton)
        
        googleSignInButton.snp.makeConstraints { make in
            make.top.equalTo(sloganLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
    
    @objc private func signInWithGoogle() {
//        let signInConfig = GIDConfiguration.init(clientID: Keys.googleClientID)
//
//        GIDSignIn.sharedInstance.configuration = signInConfig
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            // TODO: Do Something with Google User
//        }
        
        guard let window = view.window?.windowScene?.keyWindow else {
            return
        }
        
        view.fadeOut {
            window.rootViewController = HomeTabBarViewController()
        }
    }
    
    @objc private func signInWithApple() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        view.fadeOut {
            window.rootViewController = HomeTabBarViewController()
        }
    }


}

