//
//  ExperienceScreen_UITests.swift
//  AroundEgyptTaskUITests
//
//  Created by Mostafa Elemam on 27/06/2025.
//

import XCTest

final class ExperienceScreen_UITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    override func tearDownWithError() throws {}
    
    func test_ExperienceScreen_likeActionShouldChangeIcon() {
        
        //Arrange
        app.textFields["Try “Luxor”"].tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"t\"]",".keys[\"t\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"e\"]",".keys[\"e\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"m\"]",".keys[\"m\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        //Act
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.children(matching: .image).element(boundBy: 8).tap()
        elementsQuery.buttons["heartEmpty"].tap()
        let alreadyLikedButton = elementsQuery.buttons["heartFilled"]
        alreadyLikedButton.tap()
        //Assert
        XCTAssert(alreadyLikedButton.exists)
                
                
    }
    func test_ExperienceScreen_shareLinkIsWorking() {
        //Arrange
        app.textFields["Try “Luxor”"].tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"t\"]",".keys[\"t\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"e\"]",".keys[\"e\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"m\"]",".keys[\"m\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //Act
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.children(matching: .image).element(boundBy: 8).tap()
        elementsQuery.buttons["share"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.cells["More"]/*[[".scrollViews.cells[\"More\"]",".cells[\"More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.containing(.staticText, identifier:"More").element.tap()
        let doneBtn = app.navigationBars["Apps"].buttons["Done"]
//        doneBtn.tap()
    
        //Assert
        XCTAssert(doneBtn.exists)
                
    }
}
