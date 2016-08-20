//
//  ViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate, NSXMLParserDelegate {
    
    /* Version File URLs */
    let versionUrlPt = NSURL(string: "https://dl.dropboxusercontent.com/s/38qpt41e7ve607d/version-pt.txt?dl=1")!
    let versionUrlEs = NSURL(string: "https://dl.dropboxusercontent.com/s/egez7y46ldq2z9r/version-es.txt?dl=1")!
    let versionUrlEn = NSURL(string: "https://dl.dropboxusercontent.com/s/xrf6b6raspmugr2/version-en.txt?dl=1")!
    
    /* XML File URLs */
    let xmlUrlPt = NSURL(string: "https://dl.dropboxusercontent.com/s/qfh0fw7ajdo3hyg/darkskyalqueva-pt.xml?dl=1")!
    let xmlUrlEs = NSURL(string: "https://dl.dropboxusercontent.com/s/if16iq36ak5jnwu/darkskyalqueva-es.xml?dl=1")!
    let xmlUrlEn = NSURL(string: "https://dl.dropboxusercontent.com/s/8c9y36n1sjh95b8/darkskyalqueva-en.xml?dl=1")!
    
    var parser: NSXMLParser?
    var xml: XmlReader!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var downloadTask: NSURLSessionDownloadTask!
    var backgroundSession: NSURLSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let backgroundSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
        backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        progressView.setProgress(0.0, animated: false)
        
        //let url = NSURL(string: "http://publications.gbdirect.co.uk/c_book/thecbook.pdf")!
        downloadTask = backgroundSession.downloadTaskWithURL(xmlUrlEn)
        downloadTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadXml(){
        
        let path = NSBundle.mainBundle().pathForResource("file", ofType: "xml")
        //print("Path = " + path)
        if path != nil {
            parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: path!))
        } else {
            NSLog("Failed to find file.xml")
        }
        
        if parser != nil {
            // Do stuff with the parser here.
            xml = XmlReader(path: path!)
            xml.read()
        }
        
        /*let urlString = NSURL(string: "http://www.blubrry.com/feeds/onorte.xml")
        let rssUrlRequest:NSURLRequest = NSURLRequest(URL:urlString!)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue) {
            (response, data, error) -> Void in
            self.xmlParser = NSXMLParser(data: data)
            self.xmlParser.delegate = self
            self.xmlParser.parse()
        }*/
    }
    
    // 1
    func URLSession(session: NSURLSession,
                    downloadTask: NSURLSessionDownloadTask,
                    didFinishDownloadingToURL location: NSURL){
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = NSFileManager()
        let destinationURLForFile = NSURL(fileURLWithPath: documentDirectoryPath.stringByAppendingString("/file.xml"))
        
        if fileManager.fileExistsAtPath(destinationURLForFile.path!){
            showFileWithPath(destinationURLForFile.path!)
        }
        else{
            do {
                try fileManager.moveItemAtURL(location, toURL: destinationURLForFile)
                // show file
                showFileWithPath(destinationURLForFile.path!)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }
    // 2
    func URLSession(session: NSURLSession,
                    downloadTask: NSURLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                                 totalBytesWritten: Int64,
                                 totalBytesExpectedToWrite: Int64){
        progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    
    func showFileWithPath(path: String){
        let isFileFound:Bool? = NSFileManager.defaultManager().fileExistsAtPath(path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreviewAnimated(true)
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    
    func URLSession(session: NSURLSession,
                    task: NSURLSessionTask,
                    didCompleteWithError error: NSError?){
        downloadTask = nil
        progressView.setProgress(0.0, animated: true)
        if (error != nil) {
            print(error?.description)
        }else{
            print("The task finished transferring data successfully")
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            let documentsDir = paths.firstObject as! String
            
            print("Path to the Documents directory\n\(documentsDir)")
            
            loadXml()
        }
    }

}

