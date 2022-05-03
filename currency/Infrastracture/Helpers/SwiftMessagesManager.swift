import UIKit
import SwiftMessages

protocol SwiftMessagesManager : AnyObject {
    func showMessages(theme : Theme, withTitle title : MessagesText, withMessage message : MessagesText, isForeverDuration : Bool, actionText : String?, action : (() -> Void)?)
//    func showSuccessMessages(withTitle title : String, withMessage message : String, isForeverDuration : Bool, actionText : String?, action : (() -> Void)?)
}

extension SwiftMessagesManager {
    
    func showMessages(theme : Theme, withTitle title : MessagesText = .errorStr, withMessage message : MessagesText, isForeverDuration : Bool, actionText : String?, action : (() -> Void)?) {
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureTheme(theme)
        messageView.configureDropShadow()
        messageView.configureContent(title: title.rawValue, body: message.rawValue)
        messageView.button?.isHidden = (action == nil)
        messageView.button?.setTitle(actionText, for: .normal)
        messageView.buttonTapHandler = { _ in
            SwiftMessages.hide(id: message.rawValue)
            action?()
        }
        var config = SwiftMessages.defaultConfig
        config.duration = isForeverDuration ? .forever : .automatic
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        messageView.id = message.rawValue
        SwiftMessages.show(config: config, view: messageView)
    }
    
//    func showSuccessMessages(withTitle title : String, withMessage message : String, isForeverDuration : Bool, actionText : String?, action : (() -> Void)?) {
//        let messageView = MessageView.viewFromNib(layout: .cardView)
//        messageView.configureTheme(.error)
//        messageView.configureDropShadow()
//        messageView.configureContent(title: title, body: message)
//        messageView.button?.isHidden = (action == nil)
//        messageView.button?.setTitle(actionText, for: .normal)
//        messageView.buttonTapHandler = { _ in
//            SwiftMessages.hide(id: message)
//            action?()
//        }
//        var config = SwiftMessages.defaultConfig
//        config.duration = isForeverDuration ? .forever : .automatic
//        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
//        messageView.id = message
//        SwiftMessages.show(config: config, view: messageView)
//    }
}
