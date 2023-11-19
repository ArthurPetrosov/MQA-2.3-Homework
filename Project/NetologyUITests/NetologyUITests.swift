//
//  Created by Netology.
//

import XCTest

class NetologyUITests: XCTestCase {
    

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()

        let username = "username"

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()

        let predicate = NSPredicate(format: "label CONTAINS[c] %@", username)
        let text = app.staticTexts.containing(predicate)
        XCTAssertNotNil(text)

        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
    
    func testEmptyLogin() throws{
        
        
        let app = XCUIApplication()
        app.launch()

        let username = "username"

        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText(username)

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        loginTextField.doubleTap()
        loginTextField.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: (loginTextField.value as? String)?.count ?? 0))

        
        let loginButton = app.buttons["login"]
        XCTAssertFalse(loginButton.isEnabled)
        loginButton.tap()
        
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
    
    
    func testLoginAfterBack() {

        let app = XCUIApplication()
        app.launch()
        
        let otherUsername = "new_username"
        
        let loginTextField = app.textFields["login"]
        loginTextField.tap()
        loginTextField.typeText("username")

        let passwordTextField = app.textFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")

        let loginButton = app.buttons["login"]
        XCTAssertTrue(loginButton.isEnabled)
        loginButton.tap()

        app.navigationBars["Profile"].buttons["Login"].tap()

        loginTextField.doubleTap()
        loginTextField.typeText("new_username")

        loginButton.tap()
        
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", otherUsername)
        let text = app.staticTexts.containing(predicate)
        XCTAssertNotNil(text)
        
        
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
        }
}
