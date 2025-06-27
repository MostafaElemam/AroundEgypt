//
//  Helpers.swift
//  MovieExplorer
//
//  Created by Mostafa Elemam on 16/06/2025.
//

import UIKit

#if canImport(SwiftMessages)
import SwiftMessages
#endif


class Helpers {
    
    @MainActor
    static func showBanner(title: String = "Error", _ message: String, theme: Theme = .error) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(theme)
        view.configureDropShadow()
        
        view.titleLabel?.font = UIFont(name: "GothamRnd-Bold", size: 16)
        view.bodyLabel?.font = UIFont(name: "Gotham-Regular", size: 14)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        
        view.configureContent(title: NSLocalizedString(title, comment: ""), body: message)
        view.button?.isHidden = true
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        SwiftMessages.show(config: config, view: view)
    }
    
}

