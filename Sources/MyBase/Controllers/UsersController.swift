//
//  UsersController.swift
//  MyBase
//
//  Created by Ondrej Rafaj on 28/12/2017.
//

import Foundation
import Vapor
import FluentMySQL


public class UsersController: Controller {
    
    public static func boot(router: Router) throws {
        router.get("") { req in
            return req.withConnection(to: DatabaseIdentifier.init("boost")) { db -> Future<[User]> in
                re
                return try db.query(User.Display.self) { users in
                    guard let users = users else {
                        throw Abort(.notFound, reason: "Could not find user.")
                    }
                    
                    return users
                }
            }
        }
    }
    
}
