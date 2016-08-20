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
let imovelDetailSegueIdentifier = "ImovelDetailSegue"

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
    let imoveisViewModel = ImoveisViewModel()
    var refreshControl:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.appBlueColor()
        configureNavigationBar()
        configureRefreshControl()
        self.imoveisViewModel.delegate = self
        loadImoveis()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshControl.beginRefreshing()
    }
    
    func loadImoveis() {
        imoveisViewModel.fetchImoveis()
    }
    
    // MARK: CONFIGURATIONS
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.appBlueColor()
        self.refreshControl.addTarget(self, action: #selector(loadImoveis), forControlEvents: .ValueChanged)
        self.realStateTableView.addSubview(self.refreshControl)
    }
    
    func configureButtonCreateAnuncio() {
        self.buttonCreateAnuncio.backgroundColor = UIColor.appOrangeColor()
        self.buttonCreateAnuncio.setTitle("CRIAR ANÚNCIO", forState: .Normal)
        self.buttonCreateAnuncio.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.buttonCreateAnuncio.layer.cornerRadius = 5.0
        self.buttonCreateAnuncio.clipsToBounds = true
    }
    
    func configureLabelAtualizadoAInstantes() {
        labelAtualizadoAInstantes.textColor = UIColor.whiteColor()
        labelAtualizadoAInstantes.text = ""
    }
    
    func configureLabelNumberOfAnuncios() {
        labelNumberOfAnuncios.textColor = UIColor.whiteColor()
        labelNumberOfAnuncios.text = ""
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == imovelDetailSegueIdentifier {
            
            let cell = sender as! RealStateTableTableViewCell
            let destVc = segue.destinationViewController as! ImovelDetailViewController
            destVc.imovelViewModel = ImovelViewModel(imovelId: cell.imovel!.codImovel!)
        }
    }

}

// MARK:  TABLE VIEW DELEGATE & DATA SOURCE

extension RealStateTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        self.performSegueWithIdentifier(imovelDetailSegueIdentifier, sender: cell)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RealStateTableTableViewCell
        
        cell.imovel = imoveisViewModel.objectForIndexPath(indexPath)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imoveisViewModel.numberOfRowsInSection
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
extension RealStateTableViewController : ImoveisViewModelDelegate {
    
    func didFinishLoadingImoveis(imoveisViewModel: ImoveisViewModel, sucess: Bool, errorMsg: String?) {
        dispatch_async(dispatch_get_main_queue(), {
            
            if sucess {
                self.refreshControl!.endRefreshing()
                self.realStateTableView.reloadData()
                self.labelNumberOfAnuncios.text = imoveisViewModel.numberOfAnunciosText
                self.labelAtualizadoAInstantes.text = imoveisViewModel.justUpdatedText
            } else {
                print(errorMsg!)
            }
        })
        
    }
}
