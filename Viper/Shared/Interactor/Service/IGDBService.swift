//
//  IGDBService.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation

//https://api.igdb.com/v4/genres

class IGDBService {
    
    // MARK: Properties
    //weak var presenter: InteractorToPresenterQuotesProtocol?
    
    static let service = IGDBService()
    
    private init(){}

    var allEndpoints: [Endpoint] = []
    var fetchingImages = false
    
    func getUrlForEndpoint(endpoint: Endpoint,isFetchingImage: Bool) -> URL? {
        var endpointString = endpoint.rawValue
        if isFetchingImage {
            endpointString = endpoint.imageType.0.rawValue
        }
        var pluralEndpoint = endpointString.last == "y" ? "\(endpointString[..<endpointString.index(of: "y")!])ies" : "\(endpointString)s"
        pluralEndpoint = (pluralEndpoint.replacingOccurrences(of: " ", with: "_")).lowercased()
        return URL(string: "https://api.igdb.com/v4/\(pluralEndpoint)")
    }
    
    func getRequestForURL(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer be60orsu3ac3r7j9r0ynn1njtbzt5y", forHTTPHeaderField: "Authorization")
        request.setValue("sp8ryigsauyi3uivnmmo3hydbv8fui", forHTTPHeaderField: "Client-ID")
        return request
    }
    
    func getFieldsForEndpoint(endpoint: Endpoint) -> String {
        allEndpoints = Endpoint.allCases
        let endpointIndex = (allEndpoints.firstIndex(of: Endpoint(rawValue:endpoint.rawValue)!))!
        return getFields()[endpointIndex]
    }
    
    func loadEndpointFullInfo(endpoint: Endpoint, completionHandler: @escaping (Any) -> Void ) {
        let fields = getFieldsForEndpoint(endpoint: endpoint)
        loadEndpointsWithFields(endpoint: endpoint,fields: fields, completion: completionHandler)
    }
    
    func loadEndpointSummary(endpoint: Endpoint,page: Int,completion: @escaping (Any) -> Void ) {
        let fieldsEntity = "fields name, \(endpoint.imageType.1); limit 20; where \(endpoint.imageType.1) != null; offset \(page * 20);"
        loadEndpointsWithFields(endpoint: endpoint, fields: fieldsEntity, completion: completion)
    }
    
    func loadEndpointsWithFields(endpoint: Endpoint,fields: String, completion: @escaping (Any) -> Void ) {
        
        guard let url = getUrlForEndpoint(endpoint: endpoint, isFetchingImage: false) else { return }
        var request = getRequestForURL(url: url)
        let postString = fields
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

                guard let data = data else { fatalError("data FAIL") }
                let json: [StructDecoder] = self.loadJsonDecoded(endpoint: endpoint, data: data)
                var mixedJson: [StructDecoder] = []
            
                self.loadImagesURL(endpoint: endpoint, json: json, fields: "fields url;", completion: { results in
                    switch endpoint {
                    case .character:
                        let characterWithURL = results as! [CharacterEntity]
                        let characterWithoutURL = json as! [CharacterEntity]
                        characterWithURL.forEach( { char in
                         //   print("sss \((char as! CharacterEntity).id)")
                        })
                        characterWithoutURL.forEach( { char in
                        //    print("bbb \((char as! CharacterEntity).mugShot)")
                        })
                        let characters = characterWithoutURL.map({ character -> StructDecoder in
                            if let imageURL = characterWithURL.first(where: {
                                $0.id == character.mugShot
                            }) {
                                return self.insertURL(endpoint: endpoint, noURL: character, withURL: imageURL)
                            } else {
                                return character
                            }
                        })
                        mixedJson = characters
                    case .company:
                        let companyWithURL = results as! [CompanyEntity]
                        let companyWithoutURL = json as! [CompanyEntity]
                        let companies = companyWithoutURL.map({ company -> StructDecoder in
                            if let imageURL = companyWithURL.first(where: {
                                $0.id == company.logo
                            }) {
                                return self.insertURL(endpoint: endpoint, noURL: company, withURL: imageURL)
                            } else {
                                return company
                            }
                        })
                        mixedJson = companies
                    case .game:
                        let gameWithUrl = results as! [GameEntity]
                        let gameWithoutURL = json as! [GameEntity]
                        let games = gameWithoutURL.map({ game -> StructDecoder in
                            if let imageURL = gameWithUrl.first(where: {
                                $0.id == game.cover
                            }) {
                                return self.insertURL(endpoint: endpoint, noURL: game, withURL: imageURL)
                            } else {
                                return game
                            }
                        })
                        mixedJson = games
                    case .platform:
                        let platformWithUrl = results as! [PlatformEntity]
                        let platformWithoutURL = json as! [PlatformEntity]
                        let platforms = platformWithoutURL.map({ platform -> StructDecoder in
                            if let imageURL = platformWithUrl.first(where: {
                                $0.id == platform.platformLogo
                            }) {
                                return self.insertURL(endpoint: endpoint, noURL: platform, withURL: imageURL)
                            } else {
                                return platform
                            }
                        })
                        mixedJson = platforms
                    }
                    
                    completion(mixedJson)
                })
                
        })
        
        task.resume()
    }
    
    func loadJsonDecoded(endpoint: Endpoint,data: Data) -> [StructDecoder] {
        let jsonDecoder = JSONDecoder()
        var json: [StructDecoder]?
            switch endpoint {
            case .character:
                json = try? jsonDecoder.decode([CharacterEntity].self, from: data)
            case .company:
                json = try? jsonDecoder.decode([CompanyEntity].self, from: data)
            case .game:
                json = try? jsonDecoder.decode([GameEntity].self, from: data)
            case .platform:
                json = try? jsonDecoder.decode([PlatformEntity].self, from: data)
            }
        
        guard let json = json else { fatalError("Fail to decode JSON") }

        return json
    }
    
    func loadImagesURL(endpoint: Endpoint,json: [StructDecoder],fields: String,completion: @escaping ([StructDecoder]) -> Void) {
        
        guard let url = getUrlForEndpoint(endpoint: endpoint, isFetchingImage: true) else { return }
        var request = getRequestForURL(url: url)
        var filteredField: String
        filteredField = "\(fields) where id = ("
        for decoder in json {
            switch endpoint {
            case .character:
                let decoderWithType = decoder as! CharacterEntity
                if let mugShot = decoderWithType.mugShot {
                    filteredField += "\(mugShot),"
                }
            case .company:
                let decoderWithType = decoder as! CompanyEntity
                if let logo = decoderWithType.logo {
                    filteredField += "\(logo),"
                }
            case .game:
                let decoderWithType = decoder as! GameEntity
                if let cover = decoderWithType.cover {
                    filteredField += "\(cover),"
                }
            case .platform:
                let decoderWithType = decoder as! PlatformEntity
                if let platformLogo = decoderWithType.platformLogo {
                    filteredField += "\(platformLogo),"
                }
            }
        }
        filteredField.removeLast()
        filteredField = "\(filteredField));"
        print(filteredField)
        let postString = filteredField
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                guard let data = data else { fatalError("data FAIL") }
            
                let json: [StructDecoder] = self.loadJsonDecoded(endpoint: endpoint, data: data)
            
                completion(json)
        })
        
        task.resume()
        
    }
    
    func insertURL(endpoint: Endpoint,noURL: StructDecoder,withURL: StructDecoder) -> StructDecoder {
        
        var inserted: StructDecoder
        switch endpoint {
        case .character:
            let noURL = noURL as! CharacterEntity
            let withURL = withURL as! CharacterEntity
            inserted = CharacterEntity(id: noURL.id, createdAt: noURL.createdAt, games: noURL.games, name: noURL.name, slug: noURL.slug, updatedAt: noURL.updatedAt, url: noURL.url, checksum: noURL.checksum, gender: noURL.gender, mugShot: noURL.mugShot, species: noURL.species, characterDescription: noURL.characterDescription, mugShotURL: withURL.url)
        case .company:
            let noURL = noURL as! CompanyEntity
            let withURL = withURL as! CompanyEntity
            inserted = CompanyEntity(id: noURL.id, changeDateCategory: noURL.changeDateCategory, country: noURL.country, createdAt: noURL.createdAt, companyDescription: noURL.companyDescription, developed: noURL.developed, logo: noURL.logo, name: noURL.name, slug: noURL.slug, startDate: noURL.startDate, startDateCategory: noURL.startDateCategory, updatedAt: noURL.updatedAt, url: noURL.url, websites: noURL.websites, checksum: noURL.checksum, published: noURL.published, parent: noURL.parent, changeDate: noURL.changeDate, changedCompanyID: noURL.changedCompanyID, logoURL: withURL.url )
        case .game:
            let noURL = noURL as! GameEntity
            let withURL = withURL as! GameEntity
            inserted = GameEntity(id: noURL.id, category: noURL.category, cover: noURL.cover, createdAt: noURL.createdAt, externalGames: noURL.externalGames, firstReleaseDate: noURL.firstReleaseDate, gameModes: noURL.gameModes, genres: noURL.genres, name: noURL.name, platforms: noURL.platforms, releaseDates: noURL.releaseDates, screenshots: noURL.screenshots, similarGames: noURL.similarGames, slug: noURL.slug, status: noURL.status, summary: noURL.summary, tags: noURL.tags, themes: noURL.themes, updatedAt: noURL.updatedAt, url: noURL.url, websites: noURL.websites, checksum: noURL.checksum, ageRatings: noURL.ageRatings, involvedCompanies: noURL.involvedCompanies, alternativeNames: noURL.alternativeNames, parentGame: noURL.parentGame, aggregatedRating: noURL.aggregatedRating, aggregatedRatingCount: noURL.aggregatedRatingCount, bundles: noURL.bundles, collection: noURL.collection, franchise: noURL.franchise, franchises: noURL.franchises, keywords: noURL.keywords, rating: noURL.rating, ratingCount: noURL.ratingCount, totalRating: noURL.totalRating, totalRatingCount: noURL.totalRatingCount, gameEngines: noURL.gameEngines, playerPerspectives: noURL.playerPerspectives, artworks: noURL.artworks, videos: noURL.videos, storyline: noURL.storyline, versionParent: noURL.versionParent, versionTitle: noURL.versionTitle, hypes: noURL.hypes, follows: noURL.follows, multiplayerModes: noURL.multiplayerModes, dlcs: noURL.dlcs, standaloneExpansions: noURL.standaloneExpansions, remasters: noURL.remasters, coverURL: withURL.url)
        case .platform:
            let noURL = noURL as! PlatformEntity
            let withURL = withURL as! PlatformEntity
            inserted = PlatformEntity(id: noURL.id, alternativeName: noURL.alternativeName, category: noURL.category, createdAt: noURL.createdAt, name: noURL.name, platformLogo: noURL.platformLogo, slug: noURL.slug, updatedAt: noURL.updatedAt, url: noURL.url, versions: noURL.versions, websites: noURL.websites, checksum: noURL.checksum, generation: noURL.generation, platformFamily: noURL.platformFamily, abbreviation: noURL.abbreviation, summary: noURL.summary, platformLogoURL: withURL.url)
        }
        
        return inserted
        
    }
    
    func getFields() -> [String] {
        let url2 = URL(string: "https://api-docs.igdb.com/?swift")
        do {
        let content2 = try String(contentsOf: url2!, encoding: .utf8)
        let str2 = content2.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        let indices = str2.indices(of: "request.body")
        var endPointfields: [String] = []
        func updateNewStr2(times: Int) {
            var updatedStr2 = str2
            for i in 0...times-1 {
                updatedStr2 = String(str2[indices[i]...])
                let firstEndpointIndex = updatedStr2.index(of: "fields")!
                let endEndpointIndex = updatedStr2.index(of: ";&")!
                let fields = String(updatedStr2[firstEndpointIndex...endEndpointIndex])
                endPointfields.append(fields)
            }
        }
        
            updateNewStr2(times: allEndpoints.count)
            return endPointfields
        } catch let error {print(error.localizedDescription)
            return []
        }
    }
    
    func retrieveQuote(at index: Int) {
//        guard let quotes = self.quotes, quotes.indices.contains(index) else {
//            self.presenter?.getQuoteFailure()
//            return
//        }
//        self.presenter?.getQuoteSuccess(self.quotes![index])
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    
    func index(from: Int) -> Index {
            return self.index(startIndex, offsetBy: from)
        }
    
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
            ranges(of: string, options: options).map(\.lowerBound)
        }
    
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
            var result: [Range<Index>] = []
            var startIndex = self.startIndex
            while startIndex < endIndex,
                let range = self[startIndex...]
                    .range(of: string, options: options) {
                    result.append(range)
                    startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                        index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
            }
            return result
        }
}
