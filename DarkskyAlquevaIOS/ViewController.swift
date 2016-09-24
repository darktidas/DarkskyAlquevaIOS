//
//  ViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate{
    
    /* Version File URLs */
    let versionUrlPt = URL(string: "https://dl.dropboxusercontent.com/s/38qpt41e7ve607d/version-pt.txt?dl=1")!
    let versionUrlEs = URL(string: "https://dl.dropboxusercontent.com/s/egez7y46ldq2z9r/version-es.txt?dl=1")!
    let versionUrlEn = URL(string: "https://dl.dropboxusercontent.com/s/xrf6b6raspmugr2/version-en.txt?dl=1")!
    
    /* XML File URLs */
    let xmlUrlPt = URL(string: "https://dl.dropboxusercontent.com/s/qfh0fw7ajdo3hyg/darkskyalqueva-pt.xml?dl=1")!
    let xmlUrlEs = URL(string: "https://dl.dropboxusercontent.com/s/if16iq36ak5jnwu/darkskyalqueva-es.xml?dl=1")!
    let xmlUrlEn = URL(string: "https://dl.dropboxusercontent.com/s/8c9y36n1sjh95b8/darkskyalqueva-en.xml?dl=1")!

    var xml: XmlReader!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!
    
    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("loaded")
        
        /*
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        
        progressView.setProgress(0.0, animated: false)
        
        //let url = NSURL(string: "http://publications.gbdirect.co.uk/c_book/thecbook.pdf")!
        downloadTask = backgroundSession.downloadTask(with: xmlUrlEn)
        downloadTask.resume()*/
        
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            showFileWithPath(destinationURLForFile.path)
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                showFileWithPath(destinationURLForFile.path)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }
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
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?){
        downloadTask = nil
        progressView.setProgress(0.0, animated: true)
        if (error != nil) {
            //print(error?.description)
        }else{
            print("The task finished transferring data successfully")
            //let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            //let documentsDir = paths.firstObject as! String
            
            //print("Path to the Documents directory\n\(documentsDir)")
            
            loadXml()
            
            var interestPoints = self.xml.getInterestPoints()
            //print("Nome = \((interestPoints[1]?.name)!)")
        }
    }

}

