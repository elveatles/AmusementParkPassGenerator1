//
//  HourlyEmployeeRideServicesPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Ride Services
class HourlyEmployeeRideServicesPass: EmployeePass {
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement, .rideControl: return SwipeResult(success: true)
        default: return SwipeResult(success: false)
        }
    }
}
