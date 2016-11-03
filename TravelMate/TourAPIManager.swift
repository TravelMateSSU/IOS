//
//  TourAPIManager.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation
import Alamofire


class TourAPIManager: NSObject, XMLParserDelegate {
    
    let APP_NAME = "TravelMate"
    
    fileprivate let MAX_ROW_NUM = 999
    
    fileprivate let API_KEY = "Lxbm1ybyU8N5PDZs85%2Fq7lPkVo9xuf2eienU0jAfV2YFMTZBElEvProHiKucWYZ5sS4R1fAA1nolBb2u7ttxcg%3D%3D"

    fileprivate let API_COMMON_URL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon"
    
    fileprivate let API_KEYWORD_SEARCH_URL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword"
    
    var spotDict = [String: Any]()
    var spot: SpotModel = SpotModel()
    var spots: [SpotModel] = []
    var elementName: String!
    
    func querySearchByKeyword(keyword: String, completion: @escaping ([SpotModel]!) -> Void) {
        let parameters: [String: Any] = [
            /* API_KEY에서 %값이 %25로 인코딩 되는 문제를 해결하려면 removeingPercentEncoding을 통해 한 번 디코딩해주고 전송해야함(2중 인코딩 방지) */
            "ServiceKey": API_KEY.removingPercentEncoding!,
            "numOfRows": MAX_ROW_NUM,
            "pageNo": 1,
            "keyword": keyword,
            "MobileOS": "ETC",
            "MobileApp": APP_NAME
        ]
        
        let url = URL(string: API_KEYWORD_SEARCH_URL)
        if let url = url {
            Alamofire.request(url, parameters: parameters).responseString(completionHandler: {
                dataStr in
                if let data = dataStr.data {
                    self.spotDict = [:]
                    let parser = XMLParser(data: data)
                    parser.delegate = self
                    
                    let isSuccess = parser.parse()
                    if isSuccess {
                        completion(self.spots)
                    } else {
                        completion(nil)
                    }
                }
            })
        }
    }
    
    func querySearchById(spot: SpotModel, completion: @escaping (SpotModel!) -> Void) {
        let parameters: [String: Any] = [
            "ServiceKey": API_KEY.removingPercentEncoding!,
            "contentId": spot.contentId,
            "contentTypeId": spot.contentTypeId,
            "defaultYN": "N",
            "mapImageYN": "N",
            "firstImageYN": "Y",
            "areacodeYN": "N",
            "catcodeYN": "Y",
            "addrinfoYN": "Y",
            "mapinfoYN": "Y",
            "overviewYN": "N",
            "transGuideYN": "N",
            "MobileOS": "ETC",
            "MobileApp": APP_NAME,
            "numOfRows": MAX_ROW_NUM,
            "pageNo": 1
        ]
        
        let url = URL(string: API_COMMON_URL)
        if let url = url {
            Alamofire.request(url, parameters: parameters).responseString(completionHandler: {
                dataStr in
                if let data = dataStr.data {
                    self.spotDict = [:]
                    let xmlParser = XMLParser(data: data)
                    xmlParser.delegate = self
                    
                    let isSuccess = xmlParser.parse()
                    
                    if isSuccess {
                        let spot = self.spots[0]
                        if spot.title == nil {
                            completion(nil)
                        }
                        completion(spot)
                    } else {
                        completion(nil)
                    }
                }
            })
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let spot = SpotModel()
            spot.setData(dict: self.spotDict)
            self.spots.append(spot)
            self.spotDict = [:]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        spotDict[elementName] = string
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parse Error = \(parseError)")
    }
}
