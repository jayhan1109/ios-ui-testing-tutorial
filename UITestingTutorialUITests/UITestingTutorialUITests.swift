//
//  UITestingTutorialUITests.swift
//  UITestingTutorialUITests
//
//  Created by Jeongho Han on 2021-07-01.
//  Copyright © 2021 Code Pro. All rights reserved.
//

import XCTest

class UITestingTutorialUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInvalidLogin_progressSpinnerIsHidden(){
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Missing Credentials"].scrollViews.otherElements.buttons["Ok"].tap()
        let activityIndicatorView = app.activityIndicators["In progress"]
        
        XCTAssertFalse(activityIndicatorView.exists)
        
    }
    
    func testInValidLogin_missingcredentialsAlertIsShown(){
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app.textFields["Username"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let alertDialog = app.alerts["Missing Credentials"]
        
        XCTAssertTrue(alertDialog.exists)
        
        alertDialog.buttons["Ok"].tap()
        
    }
    
    func testValidLoginSuccess(){
        
        let validUserName = "CodePro"
        let validPassword = "abc123"
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        
        let userNameTextField = app.textFields["Username"]
        XCTAssertTrue(userNameTextField.exists)
        userNameTextField.tap()
        userNameTextField.typeText(validUserName)
        
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let downloadsCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["My Downloads"]/*[[".cells.staticTexts[\"My Downloads\"]",".staticTexts[\"My Downloads\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadsCell, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
                        
    }
}
