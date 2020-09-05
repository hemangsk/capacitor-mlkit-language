import XCTest
import Capacitor
@testable import Plugin

class PluginTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func identifyLanguage() {
        let value = "Hello, World!"
        let language = "en"
        let plugin = MLKitLanguage()

        let call = CAPPluginCall(callbackId: "test", options: [
            "value": value
        ], success: { (result, _) in
            let resultValue = result!.data["languageCode"] as? String
            XCTAssertEqual(language, resultValue)
        }, error: { (_) in
            XCTFail("Error shouldn't have been called")
        })

        plugin.NLLIdentifyLanguage(call!)
    }

    func identifyLanguageWithInvalidData() {
        let plugin = MLKitLanguage()

        let call = CAPPluginCall(callbackId: "test", options: nil, success: { (_, _) in
            XCTFail("Error shouldn't have been called")
        }, error: { (err) in
            XCTAssertNotNil(err)
        })

        plugin.NLLIdentifyLanguage(call!)
    }

    func identifyPossibleLanguages() {
        let value = "Hello, World!"
        let plugin = MLKitLanguage()

        let call = CAPPluginCall(callbackId: "test", options: [
            "value": value
        ], success: { (result, _) in
            let resultValue = result!.data["possibleLanguages"] as? [Any]
            XCTAssertNotNil(resultValue)
            XCTAssertTrue(resultValue!.count > 0)
        }, error: { (_) in
            XCTFail("Error shouldn't have been called")
        })

        plugin.NLLIdentifyPossibleLanguages(call!)
    }

    func identifyPossibleLanguagesWithInvalidData() {
        let plugin = MLKitLanguage()

        let call = CAPPluginCall(callbackId: "test", options: nil, success: { (_, _) in
            XCTFail("Error shouldn't have been called")
        }, error: { (err) in
            XCTAssertNotNil(err)
        })

        plugin.NLLIdentifyPossibleLanguages(call!)
    }
}
