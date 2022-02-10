//
//  ApiProtocol.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

enum ErrorData: Error {
    case message(String)
    case failedRequest
    case invalidResponse
}

typealias CompletionResult<T: Decodable> = (Result<T, ErrorData>) -> ()

protocol ApiProtocol {
    var provider: URLSession { get }
    
    func getAutocomplete(text: String,
                         completion: @escaping CompletionResult<AutoCompleteResults>)
    func searchByBusinesses(name: String,
                            completion: @escaping CompletionResult<SearchBusinessesResults>)
    func searchByPhone(phone: String,
                       completion: @escaping CompletionResult<SearchBusinessesResults>)
    func getBusinessesDetail(id: String,
                             completion: @escaping CompletionResult<BusinessDetailResult>)
}

enum ApiTarget: TargetType {

    case autocomplete(String)
    case searchByBusinesses(String)
    case searchByPhone(String)
    case getBusinessDetail(String)

    var request: URLRequest {
        var urlRequest = URLRequest.init(url: baseURL)
        headers?.forEach({ (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        return urlRequest
    }
    
    var baseURL: URL {
        guard var url = URL(string: Constants.Network.baseUrl) else {
            fatalError()
        }
        url.appendPathComponent(path)
        var component = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        component?.queryItems = parameters?.map({
            URLQueryItem(name: $0.key, value: "\($0.value)")
        })

        guard let url = component?.url else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .autocomplete:
            return "autocomplete"
        case .searchByBusinesses:
            return "businesses/search"
        case .searchByPhone:
            return "businesses/search/phone"
        case .getBusinessDetail(let id):
            return "businesses/\(id)"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var sampleData: Data {
        return Data.init()
    }
    
    var parameters: [String : Any]? {
        var parameters: [String: Any] = [
            "longitude": -122.399643,
            "latitude": 37.786942
        ]

        switch self {
        case .searchByPhone(let phone):
            parameters.updateValue(phone, forKey: "phone")
        case .searchByBusinesses(let businessName):
            parameters.updateValue(businessName, forKey: "term")
        case .autocomplete(let text):
            parameters.updateValue(text, forKey: "text")
        default:
            break
        }
        return parameters
    }
    
    var headers: [String : String]? {
        return [
            "Authorization": "Bearer \(Constants.Network.apiKey)"
        ]
    }
}

extension ApiProtocol {
    func request<T: Decodable>(target: ApiTarget,
                               _ completion: @escaping CompletionResult<T>) {
        print(target.request.curlString)
        provider.dataTask(with: target.request,
                          completionHandler: { data, response, error in
            guard error == nil else {
                completion(.failure(.failedRequest))
                return
            }

            guard let data = data ,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidResponse))
            }
        }).resume()
    }
}

extension URLRequest {
    var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = "curl \(url.absoluteString)"

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

    init?(curlString: String) {
        return nil
    }
}
