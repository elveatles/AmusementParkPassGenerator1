//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/**
 Root class for all Pass types.
 Represents a pass that can be swiped to access different areas of the park,
 rides that can be accessed, and discounts for food or merchandis.
*/
class Pass {
    /// The entrant this card was assigned to
    let entrant: Entrant
    
    /**
     Create a pass that stores entrant information.
     This class does not throw any errors, but inherited classes do.
     
     - Parameter entrant: The entrant (person) to assign to this pass.
    */
    init(entrant: Entrant) throws {
        self.entrant = entrant
    }
    
    /**
     Swipe the card to get into a certain area of the park.
     
     - Parameter parkArea: The area of the park to access.
     - Returns: Whether the swipe allows access and a message to show the user. This implementation is always unsuccessful because it was meant to be overridden in a subclass.
    */
    func swipe(parkArea: ParkArea) -> SwipeResult {
        return SwipeResult(success: false, message: "Swipe function must be overridden in an inherited class.")
    }
    
    /**
     Swipe the card to access a ride.
     
     - Parameter rideAccess: The type of ride access the swiper wants.
     - Returns: Whether the swipe allows access and a message to show the user. This implementation is always unsuccessful because it was meant to be overridden in a subclass.
    */
    func swipe(rideAccess: RideAccess) -> SwipeResult {
        return SwipeResult(success: false, message: "Swipe function must be overridden in an inherited class.")
    }
    
    /**
     Swipe the card at a place that offers discounts.
     
     - Parameter discountType: The type of discount the swiper should get.
     - Returns: The discount from 0.0 - 1.0.
    */
    func swipe(discountType: DiscountType) -> Float {
        return 0.0
    }
}