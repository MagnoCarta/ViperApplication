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
    let requestCount = 20
    
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
        let fieldsEntity = "fields name, \(endpoint.imageType.1); limit \(requestCount); where \(endpoint.imageType.1) != null; offset \(page * requestCount);"
        loadEndpointsWithFields(endpoint: endpoint, fields: fieldsEntity, completion: completion)
    }
    
    func loadEndpointsWithFields(endpoint: Endpoint,fields: String, completion: @escaping (Any) -> Void ) {
        
        guard let url = getUrlForEndpoint(endpoint: endpoint, isFetchingImage: false) else { return }
        var request = getRequestForURL(url: url)
        let postString = fields
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let data = data else { fatalError("data FAIL") }
            let json: [GenericEntity] = self.loadJsonDecoded(endpoint: endpoint, data: data)
            var mixedJson: [GenericEntity] = []
            
            self.loadImagesURL(endpoint: endpoint, json: json, fields: "fields url;", completion: { results in
                let entitiesWithURL = results as! [GenericEntity]
                let entitiesWithoutURL = json
                let entities = entitiesWithoutURL.map({ entity -> GenericEntity in
                    if let imageURL = entitiesWithURL.first(where: {
                        $0.id == entity.imageID
                    }) {
                        return self.insertURL(endpoint: endpoint, noURL: entity, withURL: imageURL)
                    } else {
                        return entity
                    }
                })
                mixedJson = entities
                completion(mixedJson)
            })
            
        })
        
        task.resume()
    }
    
    func loadJsonDecoded(endpoint: Endpoint, data: Data) -> [GenericEntity] {
        let jsonDecoder = JSONDecoder()
        var json: [GenericEntity]?
        if var initialJSON = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            initialJSON = initialJSON.map({ elementJSON in
                var json = elementJSON
                json["endpoint"] = endpoint.rawValue
                return json
            })
            do {
                if let newData = try? JSONSerialization.data(withJSONObject: initialJSON) {
                    json = try jsonDecoder.decode([GenericEntity].self, from: newData)
                }
            } catch {
                print(error)
            }
        }
        guard let json = json else { fatalError("Fail to decode JSON") }
        
        return json
    }
    
    func loadImagesURL(endpoint: Endpoint,json: [GenericEntity],fields: String,completion: @escaping ([GenericEntity]) -> Void) {
        
        guard let url = getUrlForEndpoint(endpoint: endpoint, isFetchingImage: true) else { return }
        var request = getRequestForURL(url: url)
        var filteredField: String
        filteredField = "\(fields) where id = ("
        for element in json {
            if let imageID = element.imageID {
                filteredField += "\(imageID),"
            }
        }
        filteredField.removeLast()
        filteredField = "\(filteredField));"
        filteredField += " limit \(requestCount);"
        let postString = filteredField
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let data = data else { fatalError("data FAIL") }
            
            let json: [GenericEntity] = self.loadJsonDecoded(endpoint: endpoint, data: data)
            
            completion(json)
        })
        
        task.resume()
        
    }
    
    func insertURL(endpoint: Endpoint, noURL: GenericEntity, withURL: GenericEntity) -> GenericEntity {
        
        var inserted: GenericEntity
        inserted = GenericEntity(endpoint: endpoint, id: noURL.id, name: noURL.name, description: noURL.description, imageID: noURL.imageID, imageURL: withURL.imageURL)
        
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
