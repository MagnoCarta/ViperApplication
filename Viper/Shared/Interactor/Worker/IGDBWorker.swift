//
//  IGDBWorker.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation

//https://api.igdb.com/v4/genres

class IGDBWorker {
    
    // MARK: Properties
    //weak var presenter: InteractorToPresenterQuotesProtocol?
    var gameGenres: [String]?
    var allEndpoints: [String]?
    
    func loadEndpointInfo(endpoint: String) {
        print("Interactor receives the request from Presenter to load quotes from the server.")
        var pluralEndpoint = endpoint.last == "y" ? "\(endpoint[..<endpoint.index(of: "y")!])ies" : "\(endpoint)s"
        pluralEndpoint = (pluralEndpoint.replacingOccurrences(of: " ", with: "_")).lowercased()
        guard let url = URL(string: "https://api.igdb.com/v4/\(pluralEndpoint)") else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer be60orsu3ac3r7j9r0ynn1njtbzt5y", forHTTPHeaderField: "Authorization")
        request.setValue("sp8ryigsauyi3uivnmmo3hydbv8fui", forHTTPHeaderField: "Client-ID")
        loadEndpoints()
        let endpointIndex = (allEndpoints?.firstIndex(of: endpoint))!
        let field = getFields()[endpointIndex]
    //    print(field)
        let postString = field
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                guard let data = data else {
                    fatalError("data FAIL")
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    fatalError("JSON FAIL")
                }
                
                //print(json)
                
            } catch let error {
                print(error)
            } catch let error {
                print(error)
            }
            
        })
        
        task.resume()
    }
    
    func loadEndpoints() -> [String] {
        let url = URL(string: "https://api-docs.igdb.com/#endpoints")
        
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
            let url2 = URL(string: "https://api-docs.igdb.com/?swift#game")
            
            let content2 = try String(contentsOf: url2!, encoding: .utf8)
            var str2 = content2.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            
            var newStr2: String = ""
            
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
            
            updateNewStr2(times: 38)

            
            
//            print(indices)
//            print(str2)
//
            self.allEndpoints = allEndpoints
          //  getFields()
            return allEndpoints
            
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getFields() -> [String] {
        let url2 = URL(string: "https://api-docs.igdb.com/?swift#game")
        do {
        let content2 = try String(contentsOf: url2!, encoding: .utf8)
        var str2 = content2.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        var newStr2: String = ""
        
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
        
            updateNewStr2(times: 38)
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

//
//fields age_ratings,aggregated_rating,aggregated_rating_count,alternative_names,artworks,bundles,category,checksum,collection,cover,created_at,dlcs,expanded_games,expansions,external_games,first_release_date,follows,forks,franchise,franchises,game_engines,game_modes,genres,hypes,involved_companies,keywords,multiplayer_modes,name,parent_game,platforms,player_perspectives,ports,rating,rating_count,release_dates,remakes,remasters,screenshots,similar_games,slug,standalone_expansions,status,storyline,summary,tags,themes,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites
