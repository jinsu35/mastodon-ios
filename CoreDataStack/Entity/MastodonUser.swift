//
//  MastodonUser.swift
//  CoreDataStack
//
//  Created by MainasuK Cirno on 2021/1/27.
//

import Foundation
import CoreData

final class MastodonUser: NSManagedObject {
    
    public typealias ID = String
    @NSManaged public private(set) var identifier: ID
    @NSManaged public private(set) var domain: String
    
    @NSManaged public private(set) var id: String
    @NSManaged public private(set) var acct: String
    @NSManaged public private(set) var username: String
    @NSManaged public private(set) var displayName: String?
    
    @NSManaged public private(set) var createdAt: Date
    @NSManaged public private(set) var updatedAt: Date
    
    @NSManaged public private(set) var toots: Set<Toots>?

}

extension MastodonUser {

    @discardableResult
    public static func insert(
        into context: NSManagedObjectContext,
        property: Property
    ) -> MastodonUser {
        let user: MastodonUser = context.insertObject()
    
        user.identifier = property.identifier
        user.domain = property.domain
        
        user.id = property.id
        user.acct = property.acct
        user.username = property.username
        user.displayName = property.displayName
        
        user.createdAt = property.createdAt
        user.updatedAt = property.networkDate

        return user
    }
    
}

extension MastodonUser {
    public struct Property {
        public let identifier: String
        public let domain: String
        
        public let id: String
        public let acct: String
        public let username: String
        public let displayName: String?
        
        public let createdAt: Date
        public let networkDate: Date
        
        public init(
            id: String,
            domain: String,
            acct: String,
            username: String,
            displayName: String?,
            content: String,
            createdAt: Date,
            networkDate: Date
        ) {
            self.identifier = id + "@" + domain
            self.domain = domain
            self.id = id
            self.acct = acct
            self.username = username
            self.displayName = displayName.flatMap { displayName in
                return displayName.isEmpty ? nil : displayName
            }
            self.createdAt = createdAt
            self.networkDate = networkDate
        }
    }
}

extension MastodonUser: Managed {
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(keyPath: \MastodonUser.createdAt, ascending: false)]
    }
}

