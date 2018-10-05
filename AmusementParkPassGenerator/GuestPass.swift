//
//  GuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Base class for guest passes
class GuestPass: Pass {
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement: return SwipeResult(success: true)
        default: return SwipeResult(success: false)
        }
    }
    
    override func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all: return SwipeResult(success: true)
        default: return SwipeResult(success: false)
        }
    }
}
