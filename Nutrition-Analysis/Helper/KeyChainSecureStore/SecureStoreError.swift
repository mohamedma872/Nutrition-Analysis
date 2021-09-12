import Foundation
/// Contains an enum, which represents all the possible errors your wrapper can deal with. Conforming to LocalizedError, SecureStoreError provides localized messages describing the error and why it occurred.
public enum SecureStoreError: Error {
  case string2DataConversionError
  case data2StringConversionError
  case unhandledError(message: String)
}

extension SecureStoreError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .string2DataConversionError:
      return NSLocalizedString("String to Data conversion error", comment: "")
    case .data2StringConversionError:
      return NSLocalizedString("Data to String conversion error", comment: "")
    case .unhandledError(let message):
      return NSLocalizedString(message, comment: "")
    }
  }
}
