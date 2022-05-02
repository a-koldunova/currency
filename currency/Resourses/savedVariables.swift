
import Foundation

struct UserDefaultsValues {
    static var isViewShown: Bool {
        set {
            UserDefaults.standard.set(!newValue, forKey: "IS_VIEW_SHOWN")
        }
        get {
            return !UserDefaults.standard.bool(forKey: "IS_VIEW_SHOWN")
        }
    }
    
    static var isFirstLaunch: Bool {
        set {
            UserDefaults.standard.set(!newValue, forKey: "isFirstLaunch")
        }
        get {
            return !UserDefaults.standard.bool(forKey: "isFirstLaunch")
        }
    }
    
    static var banksDate: Double? {
        set {
            UserDefaults.standard.set(newValue, forKey: "banksKey")
        }
        get {
            return !UserDefaults.standard.double(forKey: "banksKey")
        }
    }
}
