//
//  AppDelegate.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, URLSessionDownloadDelegate{

    var window: UIWindow?

    /* Version File URLs */
    let versionUrlPt = URL(string: "https://dl.dropboxusercontent.com/s/38qpt41e7ve607d/version-pt.txt?dl=1")!
    let versionUrlEs = URL(string: "https://dl.dropboxusercontent.com/s/egez7y46ldq2z9r/version-es.txt?dl=1")!
    let versionUrlEn = URL(string: "https://dl.dropboxusercontent.com/s/xrf6b6raspmugr2/version-en.txt?dl=1")!
    
    /* XML File URLs */
    let xmlUrlPt = URL(string: "https://dl.dropboxusercontent.com/s/qfh0fw7ajdo3hyg/darkskyalqueva-pt.xml?dl=1")!
    let xmlUrlEs = URL(string: "https://dl.dropboxusercontent.com/s/if16iq36ak5jnwu/darkskyalqueva-es.xml?dl=1")!
    let xmlUrlEn = URL(string: "https://dl.dropboxusercontent.com/s/8c9y36n1sjh95b8/darkskyalqueva-en.xml?dl=1")!
    
    var xml: XmlReader!
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!

    var ten = 10
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        fileVerification()
        
        return true
    }

    func fileVerification(){
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + "/file.xml")
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            print("Ja existe")
            loadXml()
        }else{
            print("Nao existe ainda")
            //download
            let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
            backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
            
            //progressView.setProgress(0.0, animated: false)
            
            //let url = NSURL(string: "http://publications.gbdirect.co.uk/c_book/thecbook.pdf")!
            downloadTask = backgroundSession.downloadTask(with: xmlUrlEn)
            downloadTask.resume()
        }
    }
    
    func loadXml(){
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String
        
        let xmlPath = documentsDir + "/file.xml"
        //print(xmlPath)
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: xmlPath){
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
                else{return}
            //print("path = " + xmlPath)
            xml = XmlReader(data: data)
        }else{
            NSLog("Failed to find file.xml")
        }
    }
    
    // 1
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + "/file.xml")
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            //showFileWithPath(destinationURLForFile.path)
            print("download concluido")
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                //showFileWithPath(destinationURLForFile.path)
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
            
            loadXml()
            
            var interestPoints = self.xml.getInterestPoints()
            print("Nome = \((interestPoints[1]?.name)!)")
            print("geral = \(self.xml.general)")
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

