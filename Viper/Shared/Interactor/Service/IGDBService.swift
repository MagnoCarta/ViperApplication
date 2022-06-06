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
    
    func getUrlForEndpoint(endpoint: Endpoint) -> URL? {
        let endpointString = endpoint.rawValue
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
    
    func loadEndpointSummary(endpoint: Endpoint,completion: @escaping (Any) -> Void ) {
        let fields = "fields name, \(endpoint.getImageField());"
         loadEndpointsWithFields(endpoint: endpoint, fields: fields, completion: completion)
    }
    
    func loadEndpointsWithFields(endpoint: Endpoint,fields: String, completion: @escaping (Any) -> Void ) {
        guard let url = getUrlForEndpoint(endpoint: endpoint) else { return }
        var request = getRequestForURL(url: url)
        let postString = fields
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                guard let data = data else {
                    fatalError("data FAIL")
                }
                let jsonDecoder = JSONDecoder()
                var json: [StructDecoder]?
                
                switch endpoint {
                case .character:
                    json = try jsonDecoder.decode([CharacterEntity].self, from: data)
                case .company:
                    json = try jsonDecoder.decode([CompanyEntity].self, from: data)
                case .game:
                    json = try jsonDecoder.decode([GameEntity].self, from: data)
                case .platform:
                    json = try jsonDecoder.decode([PlatformEntity].self, from: data)
                }
                
                completion(json)
                
            } catch let error {
                print(error)
            }
            
        })
        
        task.resume()
    }
    
    func loadEndpoints() -> [String] {
        let url = URL(string: "https://api-docs.igdb.com")
        
        do {
            let content = try String(contentsOf: url!, encoding: .utf8)
            let str = content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            var newStr: String = ""
            
            if let index = str.index(of: "Endpoints"){
                newStr = String(str[index...])
                newStr = newStr.replacingOccurrences(of: "Endpoints", with: "")
            }
            
            if let indexReference = newStr.index(of: "Reference"){
                newStr = String(newStr[..<indexReference])
            }
          
            var allEndpoints = newStr.components(separatedBy: "  ").filter({
                $0 != "\n" && $0 != ""
            })
            
            allEndpoints =  allEndpoints.map {
                $0.replacingOccurrences(of: "\n", with: "")
            }
            return allEndpoints
            
        } catch let error {
            print(error.localizedDescription)
            return []
        }
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

        func substring(from: Int) -> String {
            let fromIndex = index(from: from)
            return String(self[fromIndex...])
        }

        func substring(to: Int) -> String {
            let toIndex = index(from: to)
            return String(self[..<toIndex])
        }

        func substring(with r: Range<Int>) -> String {
            let startIndex = index(from: r.lowerBound)
            let endIndex = index(from: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
}
