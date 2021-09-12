//
//  SecureStoreTests.swift
//  Nutrition-AnalysisTests
//
//  Created by Mohamed Elsdody on 10/09/2021.
//

import XCTest
@testable import Nutrition_Analysis
class SecureStoreTests: XCTestCase {
    
    var secureStoreWithGenericPwd: SecureStore!
    var secureStoreWithInternetPwd: SecureStore!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let genericPwdQueryable =
            GenericPasswordQueryable(service: "someService")
        secureStoreWithGenericPwd =
            SecureStore(secureStoreQueryable: genericPwdQueryable)
        let internetPwdQueryable =
            InternetPasswordQueryable(server: "someServer",
                                      port: 8080,
                                      path: "somePath",
                                      securityDomain: "someDomain",
                                      internetProtocol: .https,
                                      internetAuthenticationType: .httpBasic)
        secureStoreWithInternetPwd =
            SecureStore(secureStoreQueryable: internetPwdQueryable)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try? secureStoreWithGenericPwd.removeAllValues()
        try? secureStoreWithInternetPwd.removeAllValues()
    }
    
    func testSaveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    func testReadGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }
    func testUpdateGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
    }
    func testRemoveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testRemoveAllGenericPasswords() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
            try secureStoreWithGenericPwd.removeAllValues()
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
        } catch (let e) {
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
        
    }
}
