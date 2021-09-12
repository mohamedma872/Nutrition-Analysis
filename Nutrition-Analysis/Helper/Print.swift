import Foundation

func printToConsole(message: String) {
    #if DEBUG
        print(message)
    #endif
}
