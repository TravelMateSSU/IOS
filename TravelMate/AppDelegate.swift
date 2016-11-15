//
//  AppDelegate.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 9. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?
    
    var networkManager: NetworkManager!
    
    private func setupEntryController(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "login") as UIViewController
        loginNavigationController.pushViewController(viewController, animated: true)
        self.loginViewController = loginNavigationController
        
        let viewController2 = mainStoryBoard.instantiateViewController(withIdentifier: "main") as UIViewController
        mainNavigationController.pushViewController(viewController2, animated: true)
        self.mainViewController = mainNavigationController
    }
    
    private func reloadRootViewController(){
        let isOpened = KOSession.shared().isOpen()
        
        if !isOpened{
            let mainViewController = self.mainViewController as! UINavigationController
            
            mainViewController.popToRootViewController(animated: true)
        }else{
            getUserInfo()
        }
        
        self.window?.rootViewController = isOpened ? self.mainViewController : self.loginViewController
        self.window?.makeKeyAndVisible()
    }
    
    // 카카오사용자 정보 얻어오는 함수
    private func getUserInfo(){
        var userInfo = UserInfoModel(id: "0", nickName: "guest", profileImageURL: "bagic", thumbnailImageURL: "bagic")
        networkManager = NetworkManager()
        
        KOSessionTask.meTask(completionHandler: { (user, error) in
            if user != nil {
                let koUser = user as! KOUser
                
                userInfo.id = koUser.id.stringValue
            }
        })
        
        KOSessionTask.talkProfileTask(completionHandler: { (talkProfile, error) -> Void in
            if error != nil {
                dump(error)
                
                self.setUserInfo(userInfo: userInfo)
            } else {
                let profile = talkProfile as! KOTalkProfile
                
                userInfo.nickName = profile.nickName
                userInfo.profileImageURL = profile.profileImageURL
                userInfo.thumbnailImageURL = profile.thumbnailURL
                
                self.setUserInfo(userInfo: userInfo)
                
                self.networkManager.tryLoginAndJoin(isJoin: false, userInfo: userInfo) { (err, code) in
                    if err {
                        print("로그인 실패")
                    } else {
                        print("로그인 성공")
                        if code == 0{
                            self.networkManager.tryLoginAndJoin(isJoin: true, userInfo: userInfo, { (err, code) in
                                if err{
                                    print("회원가입 실패")
                                } else{
                                    print("회원가입 성공")
                                }
                            })
                        }
                    }
                }
            }
        })
    }
    
    private func setUserInfo(userInfo: UserInfoModel){
        var userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        userDefaults.set(encodedData, forKey: "UserInfo")
        userDefaults.synchronize()
    }
    
    // GoogleMaps
    private func settingGoogleMaps(){
        GMSServices.provideAPIKey("AIzaSyCOFon9DyJWvpHefxRNVGOfuvi1ZkASdiY")
    }
    
    func loadWriteView(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let writeMapController = mainStoryBoard.instantiateViewController(withIdentifier: "writemap") 
        
        let mainViewController = self.mainViewController as! UINavigationController
        
        mainViewController.pushViewController(writeMapController, animated: true)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 최초 실행 시 2종류의 rootViewController 준비. (login, main)
        setupEntryController()
        
        // KOSession 변경 시
        NotificationCenter.default.addObserver(self, selector: #selector(kakaoSessionDidChangeWithNotification), name: NSNotification.Name.KOSessionDidChange, object: nil)
        
        reloadRootViewController()
        
        settingGoogleMaps()
        
        return true
    }
    
    func kakaoSessionDidChangeWithNotification(){
        reloadRootViewController()
    }
    
    func loadMainViewController(){
        self.window?.rootViewController = self.mainViewController
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        KOSession.handleDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        KOSession.handleDidBecomeActive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url){
            return KOSession.handleOpen(url)
        }
        return false
    }
}
