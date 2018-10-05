//
//  Test.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A place to put all tests
struct Test {
    /// Run all tests
    func test() {
        testGuestPass()
        testVIPGuestPass()
        testFreeChildGuestPass()
        testHourlyEmployeeFoodServicesPass()
        testHourlyEmployeeRideServicesPass()
        testHourlyEmployeeMaintenancePass()
        testManagerPass()
    }
    
    /**
     Print a description for a test section to separate the different tests from each other.
     
     - Parameter description: The description of the type of pass that is going to be tested.
     */
    func printTestPass(description: String) {
        print("\n")
        print(description)
        print("==============================================")
    }
    
    /// Test GuestPass access and discounts
    func testGuestPass() {
        printTestPass(description: "Classic Guest")
        let entrant = Entrant()
        do {
            let guestPass = try GuestPass(entrant: entrant)
            testPass(guestPass)
        }
        catch {
            print("GuestPass error. This should not happen! \(error)")
        }
    }
    
    /// Test VIP guest pass access and discounts
    func testVIPGuestPass() {
        printTestPass(description: "VIP Guest Pass")
        
        let entrant = Entrant()
        do {
            let pass = try VIPGuestPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating VIPGuestPass: \(error)")
        }
    }
    
    /// Test FreeChildGuestPass access and discounts
    func testFreeChildGuestPass() {
        printTestPass(description: "Free Child Guest Pass")
        
        let anonymousEntrant = Entrant()
        // This should throw an error because entrant has no date of birth
        do {
            let _ = try FreeChildGuestPass(entrant: anonymousEntrant)
        } catch PassError.missingInformation {
            print("Expected PassError.missingInformation error creating FreeChildGuestPass.")
        } catch {
            print("Unexpected error creating FreeChildGuestPass (entrant has no date of birth): \(error)")
        }
        
        // This should throw an error because the entrant is too old
        let today = Calendar.current.startOfDay(for: Date())
        let dateOfBirthTooOld = Calendar.current.date(byAdding: .year, value: -5, to: today)!
        let entrantTooOld = Entrant(dateOfBirth: dateOfBirthTooOld)
        do {
            let _ = try FreeChildGuestPass(entrant: entrantTooOld)
        } catch PassError.wrongAge(let description) {
            print("Expected PassError.wrongAge error: \(description)")
        } catch {
            print("Unexpected error creating FreeChildGuestPass (entrant too old): \(error)")
        }
        
        var dateOfBirth = Calendar.current.date(byAdding: .year, value: -5, to: today)!
        dateOfBirth = Calendar.current.date(byAdding: .day, value: 1, to: dateOfBirth)!
        let entrant = Entrant(dateOfBirth: dateOfBirth)
        do {
            let childGuestPass = try FreeChildGuestPass(entrant: entrant)
            testPass(childGuestPass)
        } catch {
            print("Unexpected error creating FreeChildGuestPass.")
        }
    }
    
    /// Test Hourly Employee - Food Services access and discounts
    func testHourlyEmployeeFoodServicesPass() {
        printTestPass(description: "Hourly Employee - Food Services Pass")
        
        let anonymousEntrant = Entrant()
        do {
            let _ = try HourlyEmployeeFoodServicesPass(entrant: anonymousEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error thrown when creating HourlyEmployeeFoodServicesPass: \(description)")
        } catch {
            print("Unexpected error trying to create HourlyEmployeeFoodServicesPass with anonymous employee. \(error)")
        }
        
        let entrant = Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: 90000)
        do {
            let pass = try HourlyEmployeeFoodServicesPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error trying to create HourlyEmployeeFoodServicesPass: \(error)")
        }
    }
    
    /// Test Hourly Employee - Ride Services access and discounts
    func testHourlyEmployeeRideServicesPass() {
        printTestPass(description: "Hourly Employee - Ride Services Pass")
        
        let partialEntrant = Entrant(firstName: "First", lastName: "Last")
        do {
            let _ = try HourlyEmployeeRideServicesPass(entrant: partialEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error when creating HourlyEmployeeRideServicesPass with partialEntrant: \(description)")
        } catch {
            print("Unexpected error creating HourlyEmployeeRideServicesPass with partialEntrant: \(error)")
        }
        
        let entrant = Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: 90000)
        do {
            let pass = try HourlyEmployeeRideServicesPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating HourlyEmployeeRideServicesPass: \(error)")
        }
    }
    
    /// Test Hourly Employee - Maintenance access and discounts
    func testHourlyEmployeeMaintenancePass() {
        printTestPass(description: "Hourly Employee - Maintenance Pass")
        
        let partialEntrant = Entrant(firstName: "First", lastName: "Last")
        do {
            let _ = try HourlyEmployeeMaintenancePass(entrant: partialEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error when creating HourlyEmployeeMaintenancePass with partialEntrant: \(description)")
        } catch {
            print("Unexpected error creating HourlyEmployeeMaintenancePass with partialEntrant: \(error)")
        }
        
        let entrant = Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: 90000)
        do {
            let pass = try HourlyEmployeeMaintenancePass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating HourlyEmployeeMaintenancePass: \(error)")
        }
    }
    
    /// Test Manager access and discounts
    func testManagerPass() {
        printTestPass(description: "Manager Pass")
        
        let partialEntrant = Entrant(firstName: "First", lastName: "Last")
        do {
            let _ = try ManagerPass(entrant: partialEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error when creating ManagerPass with partialEntrant: \(description)")
        } catch {
            print("Unexpected error creating ManagerPass with partialEntrant: \(error)")
        }
        
        let entrant = Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: 90000)
        do {
            let pass = try ManagerPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating ManagerPass: \(error)")
        }
    }
    
    /**
     Test access and discounts for a pass.
     
     - Parameter pass: The pass to test.
     */
    func testPass(_ pass: Pass) {
        print("Park Area")
        print("----------------------------------------------")
        var parkAreaResult = pass.swipe(parkArea: .amusement)
        print("Amusement Park: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .kitchen)
        print("Kitchen: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .maintenance)
        print("Maintenance: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .rideControl)
        print("Ride Control: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .office)
        print("Office: \(parkAreaResult)")
        
        print("Ride Access")
        print("----------------------------------------------")
        var rideAccessResult = pass.swipe(rideAccess: .all)
        print("All Rides: \(rideAccessResult)")
        rideAccessResult = pass.swipe(rideAccess: .skipLines)
        print("Skip lines: \(rideAccessResult)")
        
        print("Discounts")
        print("----------------------------------------------")
        var discountResult = pass.swipe(discountType: .food)
        print("Food: \(discountResult)")
        discountResult = pass.swipe(discountType: .merchandise)
        print("Merchandise: \(discountResult)")
    }
}
