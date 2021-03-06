//
//  BaseService.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class BaseService {
    
    private var task: URLSessionTask?
    
    func execute<Model:Codable>(endPoint: EndPointType, completionHandler: @escaping (Swift.Result<Model, Error>) -> Void ) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: endPoint)
            
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    completionHandler(.failure(error!))
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        guard let data = data else {
                            completionHandler(.failure(BaseServiceError.serverError(message: "No Data")))
                            return
                        }
                        
                        do {
                            let object = try JSONDecoder().decode(Model.self, from: data)
                            completionHandler(Swift.Result.success(object))
                        }
                        catch {
                            print(error)
                            completionHandler(Swift.Result.failure(BaseServiceError.parsingError))
                        }
                        
                    } else {
                        
                        completionHandler(.failure(self.handleUnSuccessfullStatusCode(response.statusCode)))
                        
                        
                    }
                }
            })
            
        }catch {
            completionHandler(.failure(error))
        }
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    
    private func buildRequest(from route: EndPointType) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
    private func handleUnSuccessfullStatusCode(_ statusCode: Int) -> BaseServiceError{
        switch statusCode {
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        default: return .serverError(message: "Server Error \(statusCode)")
        }
    }
}
