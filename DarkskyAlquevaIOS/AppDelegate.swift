//
//  AppDelegate.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit
import GoogleMaps
import SystemConfiguration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, URLSessionDownloadDelegate{

    var window: UIWindow?
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!
    var xml: XmlReader!
    var stateControlData: StateControlData!
    
    var appLanguage: String!
    let xmlDataFilename = "/data.xml"
    let versionFilename = "/dataVersion.txt"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        
        stateControlDataInitialization()
        
        checkInternetConnection()
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        appLanguage = getAppLanguage()
        print("appLanguage = \(appLanguage!)")
        
        if stateControlData.internetConnection! {
            if checkFirstTime(){
                downloadFile(file: getLanguageUrlFileData(language: appLanguage!), identifier: "xmlDownload")
                print("First time download")
            }else{
                downloadVersion(version: appLanguage!)
                print("Not first time download")
            }
        }else{
            if !checkFirstTime(){
                loadXml()
            }
        }
        
        GMSServices.provideAPIKey("AIzaSyAakLWKXp_Ce3B3fIOc4GolFrwK7pcWxng")
        //GMSPlacesClient.provideAPIKey("AIzaSyAakLWKXp_Ce3B3fIOc4GolFrwK7pcWxng")
        
        return true
    }
    
    func checkInternetConnection(){
        stateControlData.setInternetConnection(connection: connectedToNetwork())
    }
    
    func checkFirstTime() -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + self.xmlDataFilename)
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            stateControlData.setFirstTime(first: false)
            return false
        }else{
            stateControlData.setFirstTime(first: true)
            return true
        }
    }
    
    func stateControlDataInitialization(){
        
        var mapFilterStatus = [String: Bool]()
        var mapconfiguration = [String: Bool]()
        
        mapFilterStatus["astrophoto"] = true
        mapFilterStatus["landscape"] = true
        mapFilterStatus["observation"] = true
        
        mapconfiguration["normal"] = true
        mapconfiguration["hybrid"] = false
        mapconfiguration["satellite"] = false
        mapconfiguration["terrain"] = false
        
        self.stateControlData = StateControlData(mapFilterStatus: mapFilterStatus, mapConfiguration: mapconfiguration)
        
        stateControlData.firstTime = false
    }
    
    func downloadVersion(version: String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String
        
        let versionPath = documentsDir + versionFilename
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: versionPath){
            do{
                try fileManager.removeItem(at: URL(fileURLWithPath: versionPath))
            }
            catch {
                print("\(error)")
            }
        }else{
            NSLog("Failed to find data.xml")
        }
        
        let versionURLPt = URL(string: "https://dl.dropboxusercontent.com/s/38qpt41e7ve607d/version-pt.txt?dl=1")!
        let versionURLEs = URL(string: "https://dl.dropboxusercontent.com/s/egez7y46ldq2z9r/version-es.txt?dl=1")!
        let versionURLEn = URL(string: "https://dl.dropboxusercontent.com/s/xrf6b6raspmugr2/version-en.txt?dl=1")!
        
        if version == "pt"{
            downloadFile(file: versionURLPt, identifier: "versionDownload")
            print("Download portuguese version")
        }else if version == "es"{
            downloadFile(file: versionURLEs, identifier: "versionDownload")
            print("Donwload Spanish version")
        }else{
            downloadFile(file: versionURLEn, identifier: "versionDownload")
            print("Donwload English version")
        }
    }
    
    func getAppLanguage() -> String{
        
        if let systemLanguage = NSLocale.preferredLanguages[0] as String? {
            print("Language = \(systemLanguage)")
            if systemLanguage.range(of: "pt") != nil{
                return "pt"
            } else if systemLanguage.range(of: "es") != nil{
                return "es"
            } else if systemLanguage.range(of: "en") != nil{
                return "en"
            }
            else{
                for i in 1...NSLocale.preferredLanguages.count{
                    let prefLanguage = NSLocale.preferredLanguages[i] as String?
                    if prefLanguage != nil{
                        if prefLanguage?.range(of: "pt") != nil{
                            return "pt"
                        } else if prefLanguage?.range(of: "es") != nil{
                            return "es"
                        } else if prefLanguage?.range(of: "en") != nil{
                            return "en"
                        }
                    }
                }
                return "en"
            }
        }
    }
    
    func getLanguageUrlFileData(language: String) -> URL{
       
        let xmlUrlPt = URL(string: "https://dl.dropboxusercontent.com/s/qfh0fw7ajdo3hyg/darkskyalqueva-pt.xml?dl=1")!
        let xmlUrlEs = URL(string: "https://dl.dropboxusercontent.com/s/if16iq36ak5jnwu/darkskyalqueva-es.xml?dl=1")!
        let xmlUrlEn = URL(string: "https://dl.dropboxusercontent.com/s/8c9y36n1sjh95b8/darkskyalqueva-en.xml?dl=1")!
        
        if language == "pt"{
            return xmlUrlPt
        } else if language == "es"{
            return xmlUrlEs
        } else {
            return xmlUrlEn
        }
    }
    
    func downloadFile(file: URL, identifier: String){
        
        print(identifier)
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: identifier)
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        downloadTask = backgroundSession.downloadTask(with: file)
        downloadTask.resume()
    }
    
    func fileVerification(file: URL, name: String){
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + name)
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            print("Already exists")
            loadXml()
        }else{
            print("Not yet created")
            
            downloadFile(file: file, identifier: "xmlDownload")
        }
    }
    
    func versionCompareDownload(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String
        
        let versionPath = documentsDir + versionFilename
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: versionPath){
            
            var version = "" // Used to store the file contents
            do {
                // Read the file version contents
                version = try String(contentsOf: URL(fileURLWithPath: versionPath))
                print("Version path = \(versionPath)")
                print("Version file content = \(version)")
                // Check xml version
                let existingXmlPath = documentsDir + xmlDataFilename
                
                if fileManager.fileExists(atPath: existingXmlPath){
                    guard let data = try? Data(contentsOf: URL(fileURLWithPath: existingXmlPath))
                        else
                    {return}
                    
                    var existingXml: AEXMLDocument!
                    do {
                        existingXml = try AEXMLDocument(xml: data)
                        
                        //print("date = \(existingXml.root.attributes["date"]!)")
                        guard let date = existingXml.root.attributes["date"] , existingXml.root.attributes["date"] != nil else{
                            print("no date found")
                            return
                        }
                        var xmlDate = date.replacingOccurrences(of: " ", with: "/")
                        xmlDate = xmlDate.replacingOccurrences(of: ":", with: "/")
                        print("Xml file version = \(xmlDate)")
                        
                        if version == xmlDate{
                            loadXml()
                            //self.stateControlData.setXml(xml: self.xml)
                            print("Version is equal to xml version")
                        }else{
                            try fileManager.removeItem(at: URL(fileURLWithPath: existingXmlPath))
                            downloadFile(file: getLanguageUrlFileData(language: appLanguage), identifier: "xmlDownload")
                            print("Version is different from xml version")
                        }
                    }
                    catch {
                        print("\(error)")
                    }
                }else{
                    NSLog("Failed to find data.xml")
                }
            } catch {
                print("Failed reading from Uversion file")
            }
        }else{
            NSLog("Failed to find data.xml")
        }
    }
    
    func loadXml(){
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String
        
        let xmlPath = documentsDir + xmlDataFilename
        print(xmlPath)
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: xmlPath){
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
                else{return}
            //print("path = " + xmlPath)
            self.xml = XmlReader(data: data)
            self.stateControlData.setXml(xml: self.xml)
        }else{
            NSLog("Failed to find data.xml")
        }
    }
    
    // 1
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        print("download identifier name = \(session.configuration.identifier)")
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        var destinationURLForFile: URL!
        
        if session.configuration.identifier == "versionDownload"{
            destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + versionFilename)
        }else if session.configuration.identifier == "xmlDownload"{
            destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + xmlDataFilename)
        }
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            print("download concluido")
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                print("download concluido")
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?){
        downloadTask = nil
        if (error != nil) {
            
        }else{
            print("The task finished transferring data successfully")
            
            if session.configuration.identifier == "versionDownload"{
                versionCompareDownload()
            }else if session.configuration.identifier == "xmlDownload"{
                loadXml()
            }
        }
    }

    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

