import Foundation
import Capacitor

@objc(MLKitLanguage)
public class MLKitLanguage: CAPPlugin {

    /**
    Identifies language of the given text.

    - Parameter call: The capacitor's PluginCall object with options
    */
    @objc func NLLIdentifyLanguage(_ call: CAPPluginCall) {
        let languageIDHandler = LanguageIdentificationHandler(call: call)
        do {
          try languageIDHandler.identifyLanguage()
        } catch LanguageIdentificationError.emptyTextField(let error) {
            call.error(error)
        } catch let error {
            call.error("LanguageIdentificationError: \(error)")
        }
    }

    /**
    Identifies possible language of the given text and gives the confidence of each.

    - Parameter call: The capacitor's PluginCall object with options
    */
    @objc func NLLIdentifyPossibleLanguages(_ call: CAPPluginCall) {
      let languageIDHandler = LanguageIdentificationHandler(call: call)
      do {
        try languageIDHandler.identifyPossibleLanguages()
      } catch LanguageIdentificationError.emptyTextField(let error) {
          call.error(error)
      } catch let error {
          call.error("LanguageIdentificationError: \(error)")
      }
    }
}
