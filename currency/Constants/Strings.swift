// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Alert {
    internal enum Action {
      internal enum Calculator {
        /// Go to calculator
        internal static let title = L10n.tr("Localizable", "alert.action.calculator.title")
      }
      internal enum Cancel {
        /// Cancel
        internal static let title = L10n.tr("Localizable", "alert.action.cancel.title")
      }
      internal enum Map {
        /// Map
        internal static let title = L10n.tr("Localizable", "alert.action.map.title")
      }
      internal enum Site {
        /// Go to site
        internal static let title = L10n.tr("Localizable", "alert.action.site.title")
      }
    }
  }

  internal enum Calculator {
    internal enum Buy {
      /// Buy
      internal static let title = L10n.tr("Localizable", "calculator.buy.title")
    }
    internal enum Sell {
      /// Sell
      internal static let title = L10n.tr("Localizable", "calculator.sell.title")
    }
    internal enum TextField {
      internal enum Placeholder {
        /// Please, enter a number
        internal static let title = L10n.tr("Localizable", "calculator.textField.placeholder.title")
      }
    }
  }

  internal enum DataBase {
    internal enum Adress {
      /// ADDRESS_UA
      internal static let title = L10n.tr("Localizable", "dataBase.adress.title")
    }
    internal enum BankName {
      /// BANK_NAME_UA
      internal static let title = L10n.tr("Localizable", "dataBase.bankName.title")
    }
  }

  internal enum Introduction {
    internal enum Button {
      /// Next
      internal static let title = L10n.tr("Localizable", "introduction.button.title")
    }
    internal enum View1 {
      internal enum Label {
        /// Get accurate
        /// currency exchange
        internal static let title = L10n.tr("Localizable", "introduction.view1.label.title")
      }
    }
    internal enum View2 {
      internal enum Label {
        /// Get banks posotions
        /// all over the word
        internal static let title = L10n.tr("Localizable", "introduction.view2.label.title")
      }
    }
    internal enum View3 {
      internal enum Label {
        /// Сalculate the amount you need to dollars and euros
        internal static let title = L10n.tr("Localizable", "introduction.view3.label.title")
      }
    }
  }

  internal enum NotMessages {
    internal enum Error {
      /// Error
      internal static let title = L10n.tr("Localizable", "notMessages.error.title")
      internal enum ErrorDesc {
        /// Something went wrong. Try later
        internal static let title = L10n.tr("Localizable", "notMessages.error.errorDesc.title")
      }
    }
  }

  internal enum TabBar {
    internal enum Item {
      internal enum Banks {
        /// Banks
        internal static let title = L10n.tr("Localizable", "tabBar.item.banks.title")
      }
      internal enum BlackMarket {
        /// Black Market
        internal static let title = L10n.tr("Localizable", "tabBar.item.blackMarket.title")
      }
      internal enum NatBank {
        /// National Banks
        internal static let title = L10n.tr("Localizable", "tabBar.item.natBank.title")
      }
      internal enum Near {
        /// Near me
        internal static let title = L10n.tr("Localizable", "tabBar.item.near.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
