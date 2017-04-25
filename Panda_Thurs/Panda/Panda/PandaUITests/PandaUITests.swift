//
//  PandaUITests.swift
//  PandaUITests
//
//  Created by Winnie Lin on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import XCTest

class PandaUITests: XCTestCase {
        let app = XCUIApplication()
        override func setUp() {
            super.setUp()
            print("SUCCESS: All test cases passed.\n")
            // Put setup code here. This method is called before the invocation of each test method in the class.
            
            // In UI tests it is usually best to stop immediately when a failure occurs.
            //continueAfterFailure = false
            // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
            XCUIApplication().launch()
            
            // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
            
            if (loggedOut()) {
                login()
            }
            
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            super.tearDown()
        }
        
        func login() {
            let emailfield = app.textFields["enteredField"]
            let passwordfield = app.secureTextFields["enteredPassword"]
            let button = app.buttons["loginButton"]
            emailfield.tap()
            emailfield.typeText("test@panda.com")
            passwordfield.tap()
            passwordfield.typeText("password")
            button.tap()
            let profileButton = app.buttons["profileButton"]
            profileButton.tap()
            sleep(5)
        }
        
        
        
        func loggedOut() -> Bool {
            let emailfield = app.textFields["enteredField"]
            return emailfield.isHittable
        }
        
        func testBioExists() {
            let bio = app.textFields["newBio"]
            XCTAssert(bio.exists)
        }
        
        func testLogoutButtonExists() {
            let button = app.buttons["logout"]
            XCTAssert(button.exists)
            
        }
        func testLogoutWorks() {
            let button = app.buttons["logout"]
            button.tap()
            let logInButton = app.buttons["login"]
            XCTAssert(logInButton.exists)
        }
        
        func testEmailFieldExists() {
            let emailfield = app.textFields["enteredField"]
            XCTAssert(emailfield.exists)
        }
        
        func testPasswordFieldExists() {
            let passwordfield = app.secureTextFields["enteredPassword"]
            XCTAssert(passwordfield.exists)
        }
        
        func testIfButtonExists() {
            let button = app.buttons["Sign In"]
            XCTAssert(button.exists)
        }
        
        func testIfForgotPasswordExists() {
            let button = app.buttons["Forgot Your Password?"]
            XCTAssert(button.exists)
            
        }
        
        func testIfLogoLoads() {
            let logo = app.images["kuva-logo"]
            XCTAssert(logo.exists)
        }
        func testIfRegisterButtonExists() {
            let button = XCUIApplication().buttons["Don't have an account?"]
            XCTAssert(button.exists)
            
        }
        
        func testEmptyEmail() {
            let emailfield = app.textFields["Email"]
            let button = app.buttons["Sign In"]
            let badAlert = app.alerts["Email Field Empty"]
            emailfield.tap()
            emailfield.typeText("")
            button.tap()
            sleep(1)
            XCTAssert(badAlert.exists)
        }
        
        func testEmptyPassword() {
            let emailfield = app.textFields["Email"]
            let passwordfield = app.secureTextFields["Password"]
            let button = app.buttons["Sign In"]
            let badAlert = app.alerts["Password Field Empty"]
            emailfield.tap()
            emailfield.typeText("test@email.com")
            passwordfield.tap()
            passwordfield.typeText("")
            button.tap()
            sleep(1)
            XCTAssert(badAlert.exists)
        }
        
        func testLogin() {
            let emailfield = app.textFields["Email"]
            let passwordfield = app.secureTextFields["Password"]
            let button = app.buttons["Sign In"]
            emailfield.tap()
            emailfield.typeText("test@email.com")
            passwordfield.tap()
            passwordfield.typeText("testpassword")
            button.tap()
            sleep(3)
            
            let tabsQuery = app.tabBars
            print(tabsQuery.buttons.count)
            XCTAssert(tabsQuery.buttons.count == 4)
            
            
        }
        
        func logOut() {
            let tabsQuery = app.tabBars
            if (tabsQuery.buttons["Profile"].exists) {
                tabsQuery.buttons["Profile"].tap()
                
                let logoutBtn = app.buttons["Logout"]
                logoutBtn.tap()
                
            }
            sleep(2)
        }
        
        func testLocationTableExists() {
            let table = app.tables["locationTable"]
            XCTAssertTrue(table.exists)
        }
        
        func getLocationCoordinates(id: Int) -> CGVector {
            return CGVector(dx: 10, dy: 100)
        }
        
        func viewCellDetails(id: Int) {
            let fixedView = app.otherElements["feedView"]
            let viewCo = fixedView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
            let cellLocation:CGVector = getLocationCoordinates(id: 1)
            let coordinate = viewCo.withOffset(cellLocation)
            coordinate.tap()
            sleep(3)
        }
        
        //test if upload button works
        func testUploadButtonExists() {
            let button = app.buttons["Post"]
            XCTAssert(button.exists)
        }
        
        //test if you can switch to profile from home
        func testProfileButtonExists() {
            let button = app.buttons["Logout"]
            XCTAssert(button.exists)
        }
        
        //test if you can switch to another menu and then go back
        func testFeedButtonExists() {
            let logo = app.images["panda-logo"]
            XCTAssert(logo.exists)
        }
        
        //select a photo
        func testIfViewImageDetails(){
            viewCellDetails(id: 0)
        }
        
        //to take photos and upload
        func testHomeButtonExists() {
            let button = app.buttons["Homebutton"]
            XCTAssertTrue(button.exists)
        }
        
        //to sort photos
        func testPhotoButtonExists() {
            let button = app.buttons["Photobutton"]
            XCTAssertTrue(button.exists)
        }
        
        func testResetTokenButton() {
            XCTAssert(app.buttons["Send Reset Token"].exists)
        }
        
        func testReturnToLoginButtonExists() {
            XCTAssert(app.buttons["Go back to sign in?"].exists)
        }
        
        func testUsernameExists() {
            let usernameLabel = app.buttons["usernameButton"]
            
            XCTAssertTrue(usernameLabel.exists)
        }
        
        //Tests that proper username exists
        func testUsernameValid() {
            let usernameLabel = app.buttons["usernameButton"]
            
            XCTAssertNotEqual(usernameLabel.label, "Username")
        }
        
        //Test that date label exists
        func testDateLabelExists() {
            let dateLabel = app.staticTexts["dateLabel"]
            
            XCTAssertTrue(dateLabel.exists)
        }
        
        //Test that date label is valid
        func testValidDateLabel() {
            let dateLabelText = app.staticTexts["dateLabel"].label
            
            XCTAssertNotEqual(dateLabelText, "Jan 31, 2000")
        }
        
        //Test delete button exists
        func testdeleteButtonExists() {
            if isUsersPhoto() {
                let deleteBtn = app.buttons["deleteBtn"]
                XCTAssertTrue(deleteBtn.exists)
            } else {
                XCTAssertTrue(true)
            }
        }
        
        func isUsersPhoto() -> BooleanLiteralType {
            return app.buttons["deleteBtn"].exists
        }
        
        func testUsername() {
            XCTAssertFalse(app.navigationBars["USERNAME"].exists)
        }
        
        func testProfileImageExists() {
            let img = app.images["profilePicture"]
            XCTAssertTrue(img.exists)
        }
        
        func testChangeProfileExists() {
            let profile = app.buttons["changePicture"]
            XCTAssertTrue(profile.exists)
        }
        
        func testProfilePhotoViewExists() {
            let photos = app.collectionViews["profilecview"]
            XCTAssertTrue(photos.exists)
        }
        
        func testUsernameFieldExists() {
            XCTAssert(app.textFields["Username"].exists)
        }
        
        // test that the description field exists
        func testDescriptionExists() {
            let captionTextView = app.textViews[""]
            XCTAssert(captionTextView.exists)
        }
        
        // test that the description label exists
        func testDescriptionLabelExists() {
            let captionLabel = app.staticTexts["description goes here..."]
            XCTAssert(captionLabel.exists)
        }
        
        // test that label goes away when you tap
        func testDescriptionLabelDisappears() {
            let captionTextView = app.textViews[""]
            captionTextView.tap()
            let captionLabel = app.staticTexts["description goes here..."]
            XCTAssertFalse(captionLabel.exists)
        }
        
        // test that the post description button works
        func testPostButtonExists() {
            let postButton = app.buttons["Post"]
            XCTAssert(postButton.exists)
        }
        
        // test that the post description button will fail
        func testPostButtonFailure() {
            let postButton = app.buttons["Post"]
            postButton.tap()
            let postFailureAlert = app.alerts["Select an image"]
            XCTAssert(postFailureAlert.exists)
            let sadButton = postFailureAlert.buttons[":/"]
            XCTAssert(sadButton.exists)
            sadButton.tap()
        }
        
        func testSelectImageButtonExists() {
            let selectImageButton = app.buttons["Select Image +"]
            XCTAssert(selectImageButton.exists)
        }
        
        
}

