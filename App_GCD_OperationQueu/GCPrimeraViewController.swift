//
//  GCPrimeraViewController.swift
//  App_GCD_OperationQueu
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class GCPrimeraViewController: UIViewController {

    //MARK: - Variables locales
    let urlImage = "https://d1hw6n3yxknhky.cloudfront.net/022333859_prevstill.jpeg"
    let urlWeb = "https://es.wikipedia.org/wiki/Wikipedia:Portada"
    
    typealias downloadImageFunc = (_ imageData : UIImage) -> ()
    typealias downloadWebFunc = (_ webData: URLRequest) -> ()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageViewCustom: UIImageView!
    @IBOutlet weak var myWebViewCustom: UIWebView!
    
    //MARK: - IBActions
    @IBAction func showDataFromGCDAction(_ sender: Any) {
        //1
        //downloadDataSync()
        //2
        //downloadDataASync()
        //3
        downloadDataAsyncwithCallback()
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Utils
    func downloadDataSync(){
        
        do{
            
            let urlData = try Data(contentsOf: URL(string: urlImage)!)
            myImageViewCustom.image = UIImage(data: urlData)
            
            let urlWebData = URLRequest(url: URL(string: urlWeb)!)
            myWebViewCustom.loadRequest(urlWebData)
            
        }catch let error{
            print("error en la descarga de los datos: \(error.localizedDescription)")
        }
        
    }
    
    func downloadDataASync() {
        
        //Cola 2 plano
        DispatchQueue.global(qos: .default).async {
            
            do{
                
                let urlData = try Data(contentsOf: URL(string: self.urlImage)!)
                let urlWebData = URLRequest(url: URL(string: self.urlWeb)!)
                
                
                //Cola en primer plano
                DispatchQueue.main.async {
                    self.myImageViewCustom.image = UIImage(data: urlData)
                    self.myWebViewCustom.loadRequest(urlWebData)
                }
                
            }catch let error{
                print("error en la descarga de los datos: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func downloadDataAsyncwithCallback() {
        
        downloadInfoFromWeb(callbackImage: { (imageData) in
            self.myImageViewCustom.image = imageData
        }) { (requestData) in
            self.myWebViewCustom.loadRequest(requestData)
        }
        
        
    }
    
    func downloadInfoFromWeb(callbackImage: @escaping (_ imageData : UIImage) -> (), callbackWeb: @escaping (_ webData: URLRequest) -> ()){
        
        //Cola 2 plano
        DispatchQueue.global(qos: .default).async {
            
            do{
                
                let urlImageData = UIImage(data: try Data(contentsOf: URL(string: self.urlImage)!))
                let urlWebData = URLRequest(url: URL(string: self.urlWeb)!)
                
                /*
                //Cola en primer plano
                DispatchQueue.main.async {
                    callbackImage(urlImageData!)
                    callbackWeb(urlWebData)
                }
                */
                callbackImage(urlImageData!)
                callbackWeb(urlWebData)
                
            }catch let error{
                print("error en la descarga de los datos: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}
