//
//  RealStateTableViewController.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/18/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

let nibIdentifier = "RealStateTableTableViewCell"
let cellIdentifier = "RealStateCell"

class RealStateTableViewController: UIViewController {
    
    @IBOutlet weak var realStateTableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    @IBOutlet weak var toolBar: UIToolbar! {
        didSet {
            configureToolBar()
        }
    }

    @IBOutlet weak var lowerToolBar: UIToolbar! {
        didSet {
            configureLowerToolBar()
        }
    }
    
    @IBOutlet weak var labelAtualizadoAInstantes: UILabel! {
        didSet {
            configureLabelAtualizadoAInstantes()
        }
    }
    @IBOutlet weak var labelNumberOfAnuncios: UILabel! {
        didSet {
            configureLabelNumberOfAnuncios()
        }
    }
    @IBOutlet weak var buttonMagnifier: UIBarButtonItem!
    @IBOutlet weak var buttonCone: UIBarButtonItem!
    @IBOutlet weak var segmenetedControl: UISegmentedControl!
    @IBOutlet weak var buttonOrdenar: UIBarButtonItem!
    @IBOutlet weak var buttonOrdenarMenu: UIBarButtonItem!
    @IBOutlet weak var buttonCreateAnuncio: UIButton! {
        didSet {
            configureButtonCreateAnuncio()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.appBlueColor()
        configureNavigationBar()
        
        let comModel = RealStateCommunicationModel()
        comModel.fetchImoveis({
            imoveisCallBack in
            
            do{
                let imoveis = try  imoveisCallBack()
                print(imoveis)
            } catch let error {
                print(error)
            }



            
        
        })
        
    }
    
    // MARK: CONFIGURATIONS
    
    func configureButtonCreateAnuncio() {
        self.buttonCreateAnuncio.backgroundColor = UIColor.appOrangeColor()
        self.buttonCreateAnuncio.setTitle("CRIAR ANÚNCIO", forState: .Normal)
        self.buttonCreateAnuncio.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.buttonCreateAnuncio.layer.cornerRadius = 5.0
        self.buttonCreateAnuncio.clipsToBounds = true
    }
    
    func configureLabelAtualizadoAInstantes() {
        labelAtualizadoAInstantes.textColor = UIColor.whiteColor()
    }
    
    func configureLabelNumberOfAnuncios() {
        labelNumberOfAnuncios.textColor = UIColor.whiteColor()
    }
    
    func configureTableView() {
        self.realStateTableView.delegate = self
        self.realStateTableView.dataSource = self
        let cellNib = UINib(nibName: nibIdentifier, bundle: nil)
        self.realStateTableView.registerNib(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func configureToolBar() {
        self.toolBar.delegate = self
        self.toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .TopAttached, barMetrics: .Default)
        self.toolBar.backgroundColor = UIColor.appBlueColor()
    }
    
    func configureLowerToolBar() {
        self.lowerToolBar.delegate = self
        self.lowerToolBar.setBackgroundImage(UIImage(), forToolbarPosition: .Bottom, barMetrics: .Default)
        self.lowerToolBar.alpha = 0.9
        self.lowerToolBar.backgroundColor = UIColor.appBlueColor()
        self.lowerToolBar.tintColor = UIColor.whiteColor()
    }
    
    func configureNavigationBar() {
        
        let navigationBar = self.navigationController!.navigationBar
        
        navigationBar.setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
        navigationBar.backgroundColor = UIColor.appBlueColor()
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK:  TABLE VIEW DELEGATE & DATA SOURCE

extension RealStateTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealStateTableTableViewCell
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
}
// MARK:  TOOL BAR DELEGATE
extension RealStateTableViewController : UIToolbarDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        
        if bar === self.toolBar {
            return .TopAttached
        } else {
            return .Bottom
        }
        
    }
}
