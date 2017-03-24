//
//  OQSegundaViewController.swift
//  App_GCD_OperationQueu
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class OQSegundaViewController: UIViewController {

    //MARK: - Variables
    var myOperationQueu : OperationQueue?
    
    let urlString1 = "http://fansports.com.mx/wp-content/uploads/2016/09/hermanas-davalos-cuadernos-scribe-2014-1.jpeg"
    let urlString2 = "https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2015/04/24/daval16.jpg"
    let urlString3 = "https://p2.trrsf.com/image/fget/cf/460/0/images.terra.com/2015/04/24/daval14.jpg"
    let urlString4 = "http://phax.com.co/2014/img/cms/norma/Gemelas%20Davalos2.jpg"
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageView1: UIImageView!
    @IBOutlet weak var myImageView2: UIImageView!
    @IBOutlet weak var myImageView3: UIImageView!
    @IBOutlet weak var myImageView4: UIImageView!
    
    //MARK: - IBActions
    @IBAction func cancelAllOperations(_ sender: Any) {
        
        myOperationQueu?.cancelAllOperations()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadImages()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func downloadImages() {
        
        //Bloques de operaciones
        let operation1 = BlockOperation{
            
            do{
                
                let urlImageData = try Data(contentsOf: URL(string: self.urlString1)!)
                OperationQueue.main.addOperation {
                    self.myImageView1.image = UIImage(data: urlImageData)
                }
                
            }catch let error {
                print("Error en la descarga: \(error.localizedDescription)")
            }
            
        }
        
        let operation2 = BlockOperation{
            
            do{
                
                let urlImageData = try Data(contentsOf: URL(string: self.urlString2)!)
                OperationQueue.main.addOperation {
                    self.myImageView2.image = UIImage(data: urlImageData)
                }
                
            }catch let error {
                print("Error en la descarga (2): \(error.localizedDescription)")
            }
            
        }
        
        let operation3 = BlockOperation{
            
            do{
                
                let urlImageData = try Data(contentsOf: URL(string: self.urlString3)!)
                OperationQueue.main.addOperation {
                    self.myImageView3.image = UIImage(data: urlImageData)
                }
                
            }catch let error {
                print("Error en la descarga (3): \(error.localizedDescription)")
            }
            
        }
        
        let operation4 = BlockOperation{
            
            do{
                
                let urlImageData = try Data(contentsOf: URL(string: self.urlString4)!)
                OperationQueue.main.addOperation {
                    self.myImageView4.image = UIImage(data: urlImageData)
                }
                
            }catch let error {
                print("Error en la descarga (4): \(error.localizedDescription)")
            }
            
        }
        
        //esto sirve para cargar las operaciones. Se van a ir cargando segun terminen
        //podemos generar dependencias. así garantizamos mostrar info
        operation1.addDependency(operation2)
        operation2.addDependency(operation3)
        operation3.addDependency(operation4)
        
        myOperationQueu = OperationQueue()
        myOperationQueu?.addOperation(operation1)
        myOperationQueu?.addOperation(operation2)
        myOperationQueu?.addOperation(operation3)
        myOperationQueu?.addOperation(operation4)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
