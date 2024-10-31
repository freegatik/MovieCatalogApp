//
//  WelcomeViewModel.swift
//  Movarium
//
//  Created by Anton Solovev on 30.10.2024.
//

final class WelcomeViewModel {
    
    weak var delegate: AppRouterDelegate?
    
    // MARK: - Public Methods
    func signInButtonTapped() {
        delegate?.navigateToSignIn()
    }
    
    func signUpButtonTapped() {
        delegate?.navigateToSignUp()
    }
}
