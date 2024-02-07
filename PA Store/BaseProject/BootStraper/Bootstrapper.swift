//
//  Bootstrapper.swift
//
//
//  Copyright © 2020 Next Generation Innovation. All rights reserved.
//

import UIKit
import Foundation

struct Bootstrapper {
    
    var window: UIWindow
    static var instance: Bootstrapper?
    
    private init(window: UIWindow) {
        self.window = window
    }
    
    static func initialize(_ scene: UIWindowScene) {
        instance = Bootstrapper(window: UIWindow(windowScene: scene))
        instance!.bootstrap()
    }
    
    mutating func bootstrap() {
        //Decision point to show Onboarding, Login, Home.
        showHome()
        window.makeKeyAndVisible()
    }
    
    static func startAppAfterSetup() {
        instance!.startAppAfterSetup()
    }
    
    static func setupTheLanguage() {
        //   instance!.setupTheLanguage()
    }
    
    static func decideScreenToOpen() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
    }
    
    static func createHome() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showHome()
    }
    
}

extension Bootstrapper {
    
    
    private func startAppAfterSetup() {
        makeDecision()
    }
    
    private func getMetaData() {
        
    }
    
    private func makeDecision() {
    }
    
    private func showHome() {
        let controller = HomeScreenRouter.createModule()
        let nav = UINavigationController(rootViewController: controller)
        nav.isNavigationBarHidden = true
        nav.setNavigationBarHidden(true, animated: false)
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: { completed in
        })
        self.window.rootViewController = nav
    }
    
    func showViewFromSideMenu(view: UIViewController) {
        let controller = view
        let nav = UINavigationController(rootViewController: controller)
        nav.isNavigationBarHidden = true
        nav.setNavigationBarHidden(true, animated: false)
        self.window.rootViewController = nav
    }
    
}
