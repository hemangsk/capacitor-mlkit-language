//
//  LanguageTests.swift
//  PluginTests
//
//  Created by Hemang Kumar on 06/09/20.
//

import XCTest
import Capacitor
@testable import Plugin

class LanguageTests: XCTestCase {

    var value: String!
    var language: String!
    var validPluginCall: CAPPluginCall!
    var invalidPluginCall: CAPPluginCall!
    var languageIDHandler: LanguageIdentificationHandler!

    override func setUp() {
        self.value = "This is some text"
        self.language = "en"

        self.validPluginCall = CAPPluginCall(callbackId: "test", options: [
            "text": value as Any,
            "languageIdentificationOptions": [
                "confidenceThreshold": "0.5"
            ]
        ], success: { (result, _) in
            let resultValue = result!.data["languageCode"] as? String
            XCTAssertEqual(self.language, resultValue)
        }, error: { (_) in
            XCTFail("Error shouldn't have been called")
        })

        self.invalidPluginCall = CAPPluginCall(callbackId: "test", options: nil, success: { (_, _) in
            XCTFail("Success shouldn't have been called")
        }, error: { (_) in
        })
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetLanguageIdentifier() {
        self.languageIDHandler = LanguageIdentificationHandler.init(call: validPluginCall)
        XCTAssertNotNil(self.languageIDHandler.languageIdentifier)
    }

    func testSetLanguageIdentifierWithInvalidData() {
        self.languageIDHandler = LanguageIdentificationHandler.init(call: invalidPluginCall)
        XCTAssertNotNil(self.languageIDHandler.languageIdentifier)
        XCTAssertNil(self.languageIDHandler.languageIdentifierOptions)
    }

    func testSetLanguageIdentifierOptions() {
        self.languageIDHandler = LanguageIdentificationHandler.init(call: validPluginCall)
        XCTAssertNotNil(self.languageIDHandler.languageIdentifierOptions)
    }

    func testSetLanguageIdentifierOptionsWithInvalidData() {
        self.languageIDHandler = LanguageIdentificationHandler.init(call: invalidPluginCall)
        XCTAssertNil(self.languageIDHandler.languageIdentifierOptions)
    }

    func testIsTextValidWithValidData() {
        self.languageIDHandler = LanguageIdentificationHandler.init(call: validPluginCall)
        XCTAssertEqual(self.languageIDHandler.isTextValid(), true)
    }

    func testIsTextValidWithInvalidData() {
        self.languageIDHandler = LanguageIdentificationHandler.init(call: invalidPluginCall)
        XCTAssertEqual(self.languageIDHandler.isTextValid(), false)
    }
}
