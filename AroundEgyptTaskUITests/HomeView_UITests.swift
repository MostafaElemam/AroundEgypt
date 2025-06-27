//
//  HomeView_UITests.swift
//  AroundEgyptTaskUITests
//
//  Created by Mostafa Elemam on 27/06/2025.
//

import XCTest

final class HomeView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {}
    
    func test_HomeScreen_searchBar_noDataReturnsHomeData() {
        
        //Arrange
        app.textFields["Try “Luxor”"].tap()
        
        let tKey = app.keys["t"]
        tKey.tap()
        tKey.tap()
        tKey.tap()
        
        //Act
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        let welcomeText = app.scrollViews.otherElements.staticTexts["Welcome!"]
        welcomeText.tap()
        
        //Assert
        XCTAssert(welcomeText.exists)
        
    }
    func test_HomeScreen_searchBar_clearButtonReturnHomeData() {
        
        //Arrange
        let tryLuxorTextField = app.textFields["Try “Luxor”"]
        tryLuxorTextField.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"t\"]",".keys[\"t\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"e\"]",".keys[\"e\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"m\"]",".keys[\"m\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        //Act
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.images["xmark.circle.fill"]/*[[".images[\"Close\"]",".images[\"xmark.circle.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap() //clears result
        let welcomeText = app.scrollViews.otherElements.staticTexts["Welcome!"]
        welcomeText.tap()
        
        //Assert
        XCTAssert(welcomeText.exists)
    }
    func test_HomeScreen_tappingExperience_shouldOpenExperienceDetails() {
        
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
        elementsQuery.children(matching: .image).element(boundBy: 3).tap()
        
        let description = elementsQuery.staticTexts["Description"]
        let exploreButton = elementsQuery.buttons["EXPLORE NOW"]
        
        //Assert
        XCTAssert(description.exists)
        XCTAssert(exploreButton.exists)                   
    }
}
