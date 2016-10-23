//
//  AppDelegate.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit
import GoogleMaps

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
        // Override point for customization after application launch.
        //se nao houver net
        appLanguage = getAppLanguage()
        print("appLanguage = \(appLanguage!)")
        //First time?
        if checkFirstTime(){
            downloadFile(file: getLanguageUrlFileData(language: appLanguage!), identifier: "xmlDownload")
            print("First time download")
        }else{
            downloadVersion(version: appLanguage!)
            print("Not first time download")
        }
        
        //let xmlUrlEn = URL(string: "https://dl.dropboxusercontent.com/s/8c9y36n1sjh95b8/darkskyalqueva-en.xml?dl=1")!
        //fileVerification(file: xmlUrlEn, name: "/data.xml")
        
        GMSServices.provideAPIKey("AIzaSyAakLWKXp_Ce3B3fIOc4GolFrwK7pcWxng")
        //GMSPlacesClient.provideAPIKey("AIzaSyAakLWKXp_Ce3B3fIOc4GolFrwK7pcWxng")
        
        return true
    }
    
    func checkFirstTime() -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + self.xmlDataFilename)
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            return false
        }else{
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
        
        self.stateControlData = StateControlData(xml: self.xml, mapFilterStatus: mapFilterStatus, mapConfiguration: mapconfiguration)
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
                print("Sistema operativo em Portugues")
                return "pt"
            } else if systemLanguage.range(of: "es") != nil{
                print("Sistema en Espanol")
                return "es"
            } else {
                print("System in English")
                return "en"
            }
        }
    }
    
    func getLanguageUrlFileData(language: String) -> URL{
       
        /* XML File URLs */
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
        //download
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
            print("Ja existe")
            loadXml()
        }else{
            print("Nao existe ainda")
            //download
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
                            stateControlDataInitialization()
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
            xml = XmlReader(data: data)
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
        //progressView.setProgress(0.0, animated: true)
        if (error != nil) {
            //print(error?.description)
        }else{
            print("The task finished transferring data successfully")
            //let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            //let documentsDir = paths.firstObject as! String
            
            //print("Path to the Documents directory\n\(documentsDir)")
            
            if session.configuration.identifier == "versionDownload"{
                versionCompareDownload()
            }else if session.configuration.identifier == "xmlDownload"{
                loadXml()
                stateControlDataInitialization()
            }
        }
    }

    /*
    // 2
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64){
        progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    
    func showFileWithPath(_ path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }
    }*/

    
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

