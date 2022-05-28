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
    
    func loadGameGenres() {
        print("Interactor receives the request from Presenter to load quotes from the server.")
        guard let url = URL(string: "https://api.igdb.com/v4/genres") else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer be60orsu3ac3r7j9r0ynn1njtbzt5y", forHTTPHeaderField: "Authorization")
        request.setValue("sp8ryigsauyi3uivnmmo3hydbv8fui", forHTTPHeaderField: "Client-ID")
        let postString = "fields checksum,created_at,name,slug,updated_at,url; where id = 14;"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                guard let data = data else {
                    fatalError("data FAIL")
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    fatalError("JSON FAIL")
                }
                
                print(json)
                
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
            
            return allEndpoints
            
        } catch let error {
            print(error.localizedDescription)
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
}
