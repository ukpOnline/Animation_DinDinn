//
//  UKWebService.swiftManger.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON

let baseUrl     = WebserviceURL.production

struct WebserviceURL {
    static let production   = "https://picsum.photos/"
}

struct ImageURL {
    static let baseURL = "https://picsum.photos/200/300?image="
}

typealias WebServiceCompletionHandler = (_ status: Bool, _ message: String?, _ responseObject: AnyObject?, _ error: NSError?) -> Void

public enum ATHTTPMethod {

    case options
    case get
    case post
}

enum ServiceMethodType {
    case listItems
}

struct WebserviceKey {
    static let content      = "application/json"
    static let contentType  = "Content-Type"
}

struct WebserviceError {

    struct Code {

        static let noData                    = 999001
        static let dataFormat                = 999002
        static let unKnown                   = 999003
        static let noInternetConnectivity    = 999004

        struct HTTP {
            static let successCode        = 200
            static let badRequest         = 400
            static let forbidden          = 403
            static let timeOut            = 408
            static let unAuthorizedAccess = 401
            static let resourceNotFound   = 404
            static let other              = 999999
        }

        struct App {
            static let invalidSession   = 3000
        }
    }

    struct Messages {

        struct HTTP {
            static let timeOut            = "The server timed out."
            static let other              = "HTTP error."
            static let badRequest         = "The server cannot or will not process the request due to an apparent client error."
            static let forbidden          = "Credentials are already in use Or you do not have proper access for this action."
            static let unAuthorizedAccess = "You are not authenticated to do this action."
            static let resourceNotFound   = "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible."
        }
        struct App {
            static let invalidSession   = "Your login has expired. Please login again."
        }

        static let unKnown                = "Unknown error."
        static let noData                 = "No data available."
        static let dataFormat             = "Data format error. Data contract breakage."
        static let noInternetConnectivity = "No internet connectivity."
        static let generic                = "An error occurred."
     }
}

class UKWebserviceManger: NSObject {

    var showLoadingIndicator: Bool      = true
    var showConnectivityErrorMessage    = true
    var completionHandler: WebServiceCompletionHandler?
    var webMethodType: ServiceMethodType = ServiceMethodType.listItems

    var httpHeaders = [ WebserviceKey.contentType: WebserviceKey.content,]

    // MARK: - core methods

    func isConnectivityAvailable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }

    private func setUpInitialConfigurations() -> Bool {

        let connectivityError: NSError!
        var callService: Bool = true

        if self.showConnectivityErrorMessage == true {

            callService = isConnectivityAvailable()
        }

        if callService == false {

            connectivityError = NSError(domain: WebserviceError.Messages.noInternetConnectivity, code: WebserviceError.Code.noInternetConnectivity, userInfo: nil)
            self.handleFailureResponse(error: connectivityError)

            UKCommon.showWeakInternetConnectivityMessage()

        }

        return callService
    }
    func handleFailureResponse(error: NSError) {

        if let handler = self.completionHandler {

            handler(false, nil, nil, error)
        }
    }

    func getHTTPMethodTypeFor(ATHTTP: ATHTTPMethod) -> HTTPMethod {

        var serviceHttpMethod: HTTPMethod = .options

        switch ATHTTP {
        case .get:
            serviceHttpMethod = .get
        default:
            serviceHttpMethod = .options
        }

        return serviceHttpMethod
    }

    func showActivityIndicator(message: String? = nil) {
        DispatchQueue.main.async {
            let activityData = ActivityData(size: CGSize(width: 50, height: 50), message: message,
                                            messageFont: UIFont.systemFont(ofSize: 12),
                                            messageSpacing: 5, type: .ballSpinFadeLoader, color: UKColors.whiteAttributedColor,
                                            padding: 5, backgroundColor: UIColor.black.withAlphaComponent(0.1),
                                            textColor: UKColors.whiteAttributedColor)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
           NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        })
    }

    public func sendWebServiceRequest(path: String, httpMethod: ATHTTPMethod, params: Parameters?, success: @escaping (Any) -> Void, failure: @escaping (NSError) -> Void) {

        if let urlPath = URL.init(string: "\(baseUrl)\(path)") {
            self.sendWebServiceRequest(urlPath: urlPath, httpMethod: httpMethod, params: params, headers: httpHeaders, success: success, failure: failure)
        }
    }

    fileprivate func sendWebServiceRequest(urlPath: URL, httpMethod: ATHTTPMethod, params: Parameters?, headers: [String: String]?, success: @escaping (Any) -> Void, failure: @escaping (NSError) -> Void) {

        if self.setUpInitialConfigurations() == true {

            let methodType = getHTTPMethodTypeFor(ATHTTP: httpMethod)
            let encoding: ParameterEncoding = (methodType == .post) ? JSONEncoding.default : URLEncoding.queryString
            let dataRequest = Alamofire.request(urlPath, method: methodType, parameters: params, encoding: encoding, headers: headers ?? nil)
            print("\nRequest type: \(methodType.rawValue)")
            if let url = dataRequest.request?.url {
                print("\nRequest URL: \(url.absoluteString)")
            }
            print("Headers :\(httpHeaders)")
           
            dataRequest.responseJSON { response in

                    if self.showLoadingIndicator == true {
                        self.hideActivityIndicator()
                    }

                    if response.response != nil {
                        if let statusCode = response.response?.statusCode {
                            if statusCode != WebserviceError.Code.HTTP.successCode {
                                let error = self.errorWithHttpStatusCode(statusCode)
                                failure(error)
                                print("\nHTTP ERROR : \(statusCode)")
                            } else {
                                switch response.result {
                                case .success:
                                if response.result.value != nil {
                                    if let responseData = response.data as NSData? {
                                            success(responseData)
                                        } else {
                                            let customError = NSError(domain: WebserviceError.Messages.noData, code: WebserviceError.Code.noData, userInfo: nil)
                                            failure(customError)
                                        }
                                    }

                                case .failure(let error):
                                    failure(error as NSError)
                                    print("\nSERVER SIDE APP ERROR : \(error.localizedDescription)")
                                }
                            }

                        } else {
                            if self.showConnectivityErrorMessage == true {
                                UKCommon.showServerConnectivityMessage()
                            }
                            let error: NSError = NSError(domain: WebserviceError.Messages.noData, code: WebserviceError.Code.noData, userInfo: nil)
                            failure(error)
                        }

                    } else {
                        if self.showConnectivityErrorMessage == true {
                            UKCommon.showServerConnectivityMessage()
                        }
                        let error: NSError = NSError(domain: WebserviceError.Messages.noData, code: WebserviceError.Code.noData, userInfo: nil)
                        failure(error)
                    }
            }

            if self.showLoadingIndicator == true {
                self.showActivityIndicator()
            }
        }
    }

    func errorWithHttpStatusCode(_ statusCode: Int) -> NSError {

        let error: NSError!
        var errorMessage = ""

        switch statusCode {

        case WebserviceError.Code.HTTP.badRequest:
            errorMessage =  WebserviceError.Messages.HTTP.badRequest

        case WebserviceError.Code.HTTP.unAuthorizedAccess:
            errorMessage =  WebserviceError.Messages.HTTP.unAuthorizedAccess

        case WebserviceError.Code.HTTP.forbidden:
            errorMessage =  WebserviceError.Messages.HTTP.forbidden

        case WebserviceError.Code.HTTP.resourceNotFound:
            errorMessage =  WebserviceError.Messages.HTTP.resourceNotFound

        case WebserviceError.Code.HTTP.timeOut:
            errorMessage =  WebserviceError.Messages.HTTP.timeOut

        default:
            errorMessage =  WebserviceError.Messages.HTTP.other
        }

        error = NSError(domain: errorMessage, code: statusCode, userInfo: nil)
        return error
    }

}
