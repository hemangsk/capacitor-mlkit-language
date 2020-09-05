//
//  Language.swift
//  Plugin
//
//  Created by Hemang Kumar on 06/09/20.
//

import Foundation
import Capacitor
import MLKitLanguageID

public class LanguageIdentificationHandler {
    var pluginCall: CAPPluginCall
    var languageIdentifier: LanguageIdentification!
    var languageIdentifierOptions: LanguageIdentificationOptions!

    var text: String!

    let TEXT_KEY = "text"
    let LANGUAGE_IDENTIFICATION_OPTIONS_KEY = "languageIdentificationOptions"
    let LIO_CONFIDENCE_KEY = "confidenceThreshold"

    let RESULT_LANGUAGE_KEY = "languageCode"
    let RESULT_CONFIDENCE_KEY = "confidence"
    let RESULT_KEY = "possibleLanguages"

    init(call: CAPPluginCall) {
        self.pluginCall = call
        self.setText()
        self.setLanguageIdentificationOptions()
        self.setLanguageIdentifier()
    }

    /**
    Sets text to be translated
    */
    func setText() {
        if self.pluginCall.options == nil {
            self.text = ""
        } else {
            self.text = self.pluginCall.getString("text", "")
        }
    }

    /**
    Sets LanguageIdentification client
    */
    func setLanguageIdentifier() {
        if self.languageIdentifierOptions != nil {
            self.languageIdentifier = LanguageIdentification.languageIdentification(options: self.languageIdentifierOptions)
        } else {
            self.languageIdentifier = LanguageIdentification.languageIdentification()
        }
    }

    /**
    Sets LanguageIdentification client options
    */
    func setLanguageIdentificationOptions() {
        if self.pluginCall.options != nil {
            if let languageIdentificationOptionsJSON = self.pluginCall.getObject(LANGUAGE_IDENTIFICATION_OPTIONS_KEY) {
                if let confidenceThreshold = languageIdentificationOptionsJSON[LIO_CONFIDENCE_KEY] {
                    if let confidenceThresholdFloatValue = Float(confidenceThreshold as! String) {
                        self.languageIdentifierOptions = LanguageIdentificationOptions.init(confidenceThreshold: confidenceThresholdFloatValue)
                    }
                }
            }
        }
    }

    /**
    Check if text submitted by user is valid and non empty.
    */
    func isTextValid() -> Bool {
        if self.text.isEmpty {
            return false
        }
        return true
    }

    /**
    Calls IdentifyLanguage method of MLKit to identify the language of text.
    */
    func identifyLanguage() throws {
        if !isTextValid() {
            throw LanguageIdentificationError.emptyTextField(reason: "`text` field is empty.")
        }

        self.languageIdentifier.identifyLanguage(for: self.text) { (languageTag, error) in
            if let error = error {
                self.pluginCall.error("LanguageIdentificationError: \(error)")
                return
            }
            self.pluginCall.success([
                self.RESULT_LANGUAGE_KEY: languageTag as Any
            ])
        }
    }

    /**
    Calls identifyPossibleLanguages method of MLKit to identify the language of text.
    */
    func identifyPossibleLanguages() throws {
        if !isTextValid() {
            throw LanguageIdentificationError.emptyTextField(reason: "`text` field is empty.")
        }

        self.languageIdentifier.identifyPossibleLanguages(for: self.text) { (identifiedLanguages, error) in
            if let error = error {
              self.pluginCall.error("LanguageIdentificationError: \(error)")
              return
            }

            var results: [Any] = []
            for language in identifiedLanguages ?? [] {
                let identifiedLanguageObject = [
                    self.RESULT_CONFIDENCE_KEY: language.confidence ,
                    self.RESULT_LANGUAGE_KEY: language.languageTag
                ] as [String: Any]
                results.append(identifiedLanguageObject)
            }

            self.pluginCall.success([
                self.RESULT_KEY: results
            ])
        }
    }
}

/**
 Errors to throw when language identification fails.
 */
enum LanguageIdentificationError: Error {
    case emptyTextField(reason: String)
    case optionsNotSupplied
}
