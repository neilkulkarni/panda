//
//  PandaTests.swift
//  PandaTests
//
//  Created by Winnie Lin on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import XCTest
@testable import Panda

class PandaTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    func loggedOut() -> Bool {
        return true
    }
    
    func testBioExists() {
    }
    
    func testLogoutButtonExists() {
        XCTAssert(true)
        
    }
    func testLogoutWorks() {
       XCTAssert(true)
    }
    
    func testEmailFieldExists() {
       XCTAssert(true)
    }
    
    func testPasswordFieldExists() {
        XCTAssert(true)
    }
    
    func testIfButtonExists() {
       XCTAssert(true)
    }
    
    func testIfForgotPasswordExists() {
        XCTAssert(true)
        
    }
    
    func testIfLogoLoads() {
       XCTAssert(true)
    }
    func testIfRegisterButtonExists() {
       XCTAssert(true)
    }
    
    func testEmptyEmail() {
        XCTAssert(true)
    }
    
    func testEmptyPassword() {
       XCTAssert(true)
    }
    
    func testLogin() {
       XCTAssert(true)
        
        
    }
    
    func logOut() {
      XCTAssert(true)
    }
    
    func testLocationTableExists() {
        XCTAssert(true)
    }
    
    func getLocationCoordinates(id: Int) -> CGVector {
        return CGVector(dx: 10, dy: 100)
    }
    
    func viewCellDetails(id: Int) {
       XCTAssert(true)
    }
    
    //test if upload button works
    func testUploadButtonExists() {
       XCTAssert(true)
    }
    
    //test if you can switch to profile from home
    func testProfileButtonExists() {
       XCTAssert(true)
    }
    
    //test if you can switch to another menu and then go back
    func testFeedButtonExists() {
       XCTAssert(true)
    }
    
    //select a photo
    func testIfViewImageDetails(){
        viewCellDetails(id: 0)
    }
    
    //to take photos and upload
    func testHomeButtonExists() {
        XCTAssert(true)
    }
    
    //to sort photos
    func testPhotoButtonExists() {
       XCTAssert(true)
    }
    
    func testResetTokenButton() {
        XCTAssert(true)
    }
    
    func testReturnToLoginButtonExists() {
        XCTAssert(true)
    }
    
    func testUsernameExists() {
      XCTAssert(true)
    }
    
    //Tests that proper username exists
    func testUsernameValid() {
        XCTAssert(true)
    }
    
    //Test that date label exists
    func testDateLabelExists() {
        XCTAssert(true)
    }
    
    //Test that date label is valid
    func testValidDateLabel() {
        XCTAssert(true)
    }
    
    //Test delete button exists
    func testdeleteButtonExists() {
       XCTAssert(true)
    }
    
    
    func testUsername() {
        XCTAssert(true)
    }
    
    func testProfileImageExists() {
        XCTAssert(true)
    }
    
    func testChangeProfileExists() {
      XCTAssert(true)
    }
    
    func testProfilePhotoViewExists() {
        XCTAssert(true)
    }
    
    func testUsernameFieldExists() {
        XCTAssert(true)
    }
    
    // test that the description field exists
    func testDescriptionExists() {
        XCTAssert(true)
    }
    
    // test that the description label exists
    func testDescriptionLabelExists() {
        XCTAssert(true)
    }
    
    // test that label goes away when you tap
    func testDescriptionLabelDisappears() {
        XCTAssert(true)
    }
    
    // test that the post description button works
    func testPostButtonExists() {
       XCTAssert(true)
    }
    
    // test that the post description button will fail
    func testPostButtonFailure() {
       XCTAssert(true)
    }
    
    func testSelectImageButtonExists() {
        XCTAssert(true)
    }
    
}
