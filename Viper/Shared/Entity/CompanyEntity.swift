//
//  CompanyEntity.swift
//  Viper
//
//  Created by Gilberto vieira on 31/05/22.
//


import Foundation

// MARK: - CompanyEntity
struct CompanyEntity: Codable, StructDecoder {
    static var entityName: String = "Company"
    
    let id, changeDateCategory: Int?
    let country: Int?
    let createdAt: Int?
    let companyDescription: String?
    let developed: [Int]?
    let logo: Int?
    let name, slug: String?
    let startDate: Int?
    let startDateCategory, updatedAt: Int?
    let url: String?
    let websites: [Int]?
    let checksum: String?
    let published: [Int]?
    let parent, changeDate, changedCompanyID: Int?
    
    // Custom Properties
    let logoURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case changeDateCategory = "change_date_category"
        case country
        case createdAt = "created_at"
        case companyDescription = "description"
        case developed, logo, name, slug
        case startDate = "start_date"
        case startDateCategory = "start_date_category"
        case updatedAt = "updated_at"
        case url, websites, checksum, published, parent
        case changeDate = "change_date"
        case changedCompanyID = "changed_company_id"
        
        // Custom Properties
        case logoURL = "compay_logo"
    }
}
