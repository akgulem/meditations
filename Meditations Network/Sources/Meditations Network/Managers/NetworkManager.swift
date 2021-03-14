//
//  File.swift
//  
//
//  Created by Emrah Akgül on 7.03.2021.
//
import Foundation

public protocol NetworkManageable {
    func makeRequest<R: Request, S: Decodable>(request: R, completionHandler: @escaping (S?, Error?) -> Void)
}

public final class DefaultNetworkManager: NetworkManageable {
    
    public static let `default`: DefaultNetworkManager = DefaultNetworkManager()
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private func createRequest<R: Request>(request: R) -> URLRequest? {
        guard let requestURL = request.constructedURL else {
            return nil
        }
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        return urlRequest
    }
    
    public func makeRequest<R: Request, S: Decodable>(request: R, completionHandler: @escaping (S?, Error?) -> Void){
        guard let urlRequest = createRequest(request: request) else {
            completionHandler(nil, NetworkError.corruptedURL)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                #if DEBUG
                print("No Response!")
                #endif
                completionHandler(nil, NetworkError.other)
                return
            }
            if let error = error {
                #if DEBUG
                print("Connection Error: " + error.localizedDescription)
                #endif
                
                completionHandler(nil, NetworkError.connection(reason: error))
                
                return
            }
            if response.statusCode < 200 || response.statusCode >= 400 {
                #if DEBUG
                print("HTTP Error: " + String(describing: response.statusCode))
                #endif
                completionHandler(nil, NetworkError.http(code: response.statusCode))
            }
            else {
                guard let data = data else {
                    #if DEBUG
                    print("No Data!")
                    #endif
                    completionHandler(nil, NetworkError.data(reason: .missing))
                    return
                }
                do {
                    let response = try DefaultNetworkManager.decoder.decode(S.self, from: data)
                    completionHandler(response, nil)
                } catch let error as DecodingError {
                    completionHandler(nil, NetworkError.data(reason: .read(underlying: error)))
                } catch {
                    completionHandler(nil, NetworkError.other)
                }
            }
        }
        task.resume()
    }
}
