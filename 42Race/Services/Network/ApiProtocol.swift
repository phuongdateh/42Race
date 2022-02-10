//
//  ApiProtocol.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

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
        switch self {
        case .autocomplete:
            return """
            {
                "categories": [
                    {
                        "alias": "coffee",
                        "title": "Coffee & Tea"
                    },
                    {
                        "alias": "tea",
                        "title": "Tea Rooms"
                    },
                    {
                        "alias": "teachersupplies",
                        "title": "Teacher Supplies"
                    }
                ],
                "businesses": [],
                "terms": [
                    {
                        "text": "Tea"
                    },
                    {
                        "text": "Tea Shop"
                    },
                    {
                        "text": "Tea House"
                    }
                ]
            }
            """.utf8Encoded
        case .searchByPhone, .searchByBusinesses:
            return """
            {
              "businesses": [
                {
                  "id": "cQfRu22j4nAuycKWHexAIA",
                  "alias": "réveille-coffee-co-san-francisco-5",
                  "name": "Réveille Coffee Co.",
                  "image_url": "https://s3-media3.fl.yelpcdn.com/bphoto/negJx3BNhMOM2-fIuLcEJg/o.jpg",
                  "is_closed": false,
                  "url": "https://www.yelp.com/biz/r%C3%A9veille-coffee-co-san-francisco-5?adjust_creative=tmQxOl0ZSAOXexlkLyPjSg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=tmQxOl0ZSAOXexlkLyPjSg",
                  "review_count": 434,
                  "categories": [
                    {
                      "alias": "coffee",
                      "title": "Coffee & Tea"
                    }
                  ],
                  "rating": 4,
                  "coordinates": {
                    "latitude": 37.7972059782064,
                    "longitude": -122.405463418284
                  },
                  "transactions": [
                    "delivery"
                  ],
                  "price": "$$",
                  "location": {
                    "address1": "200 Columbus Ave",
                    "address2": null,
                    "address3": "",
                    "city": "San Francisco",
                    "zip_code": "94133",
                    "country": "US",
                    "state": "CA",
                    "display_address": [
                      "200 Columbus Ave",
                      "San Francisco, CA 94133"
                    ]
                  },
                  "phone": "+14157896258",
                  "display_phone": "(415) 789-6258",
                  "distance": 1245.2632727382581
                }
              ],
              "total": 2300,
              "region": {
                "center": {
                  "longitude": -122.399972,
                  "latitude": 37.786882
                }
              }
            }
            """.utf8Encoded
        case .getBusinessDetail:
            return """
            {
                "id": "-9g5fZ0w0w3teWOO69nqmw",
                "alias": "radiator-coffee-salon-san-francisco",
                "name": "Radiator Coffee Salon",
                "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/Jj8HGHTdT0wRdlU46M7mvg/o.jpg",
                "is_claimed": true,
                "is_closed": false,
                "url": "https://www.yelp.com/biz/radiator-coffee-salon-san-francisco?adjust_creative=tmQxOl0ZSAOXexlkLyPjSg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=tmQxOl0ZSAOXexlkLyPjSg",
                "phone": "+14159470700",
                "display_phone": "(415) 947-0700",
                "review_count": 10,
                "categories": [
                    {
                        "alias": "coffee",
                        "title": "Coffee & Tea"
                    },
                    {
                        "alias": "breakfast_brunch",
                        "title": "Breakfast & Brunch"
                    },
                    {
                        "alias": "sandwiches",
                        "title": "Sandwiches"
                    }
                ],
                "rating": 4.0,
                "location": {
                    "address1": "299 2nd St",
                    "address2": "",
                    "address3": null,
                    "city": "San Francisco",
                    "zip_code": "94105",
                    "country": "US",
                    "state": "CA",
                    "display_address": [
                        "299 2nd St",
                        "San Francisco, CA 94105"
                    ],
                    "cross_streets": "Folsom St & Clementina St"
                },
                "coordinates": {
                    "latitude": 37.78577571880986,
                    "longitude": -122.39671881226874
                },
                "photos": [
                    "https://s3-media1.fl.yelpcdn.com/bphoto/Jj8HGHTdT0wRdlU46M7mvg/o.jpg",
                    "https://s3-media2.fl.yelpcdn.com/bphoto/jlp-gU10HYo6ZugScFndDw/o.jpg",
                    "https://s3-media1.fl.yelpcdn.com/bphoto/tYWVH7q8iQs_Ntd7OJ5SFA/o.jpg"
                ],
                "hours": [
                    {
                        "open": [
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 0
                            },
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 1
                            },
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 2
                            },
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 3
                            },
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 4
                            },
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 5
                            },
                            {
                                "is_overnight": false,
                                "start": "0600",
                                "end": "1100",
                                "day": 6
                            }
                        ],
                        "hours_type": "REGULAR",
                        "is_open_now": false
                    }
                ],
                "transactions": [],
                "messaging": {
                    "url": "https://www.yelp.com/raq/-9g5fZ0w0w3teWOO69nqmw?adjust_creative=tmQxOl0ZSAOXexlkLyPjSg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=tmQxOl0ZSAOXexlkLyPjSg#popup%3Araq",
                    "use_case_text": "Message the Business"
                }
            }
            """.utf8Encoded
        }
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
