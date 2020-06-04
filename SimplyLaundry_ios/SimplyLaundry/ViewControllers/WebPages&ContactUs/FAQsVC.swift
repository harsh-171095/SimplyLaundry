//
//  FAQsVC.swift
//  SimplyLaundry
//
//  Created by webclues on 17/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class FAQsVC: UIViewController {

    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!

    @IBOutlet weak var btnCeanMyCloth:UIButton!
    @IBOutlet weak var btnConatctUs:UIButton!
    
    // Variable Declarations and Initlizations
    var arrPreferences = NSMutableArray()

    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    //MARK:- set Outlet's Theme
    /*
     Function Name :- setTheme
     Function Parameters :- (nil)
     Function Description :- This function used for set a Cotroller outlet's theme.
     */
    func setTheme()
    {
        //Parent theme
        self.view.addGradientsWithTwoColor()
        viewParent.backgroundColor = COLOR.White
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("FAQ")

        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        scrollContent.backgroundColor = COLOR.White
        
        tableViewObj.register(UINib(nibName: "FAQsCell", bundle: nil), forCellReuseIdentifier: "FAQsCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = false
        
        btnCeanMyCloth.setTitle("CLEAN MY CLOTHES", for: .normal)
        btnCeanMyCloth.setTitleColor(COLOR.Blue, for: .normal)
        btnCeanMyCloth.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnCeanMyCloth.addTarget(self, action: #selector(btnCleanMyClothsClick(_:)), for: .touchUpInside)
     
        btnConatctUs.setTitle("CONTACT US", for: .normal)
        btnConatctUs.setTitleColor(COLOR.Blue, for: .normal)
        btnConatctUs.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnConatctUs.addTarget(self, action: #selector(btnContactusClick(_:)), for: .touchUpInside)

        setDataOfViewController()
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        arrPreferences = [
            ["title":"Lorem Ipsum is simply dummy text of the printing and typesetting industry.?","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry.","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry.","isExpande":false],
            ["title":"Detergent","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","isExpande":false]
        ]
        tableViewObj.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnContactusClick(_ sender: Any)
    {
        let controller  = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        Application_Delegate.navigationController.pushViewController(controller, animated: false)
    }
    
    @IBAction func btnCleanMyClothsClick(_ sender: Any)
    {
        let controller  = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "CleanMyClothesFirstVC") as! CleanMyClothesFirstVC
        Application_Delegate.navigationController.pushViewController(controller, animated: false)
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height
    }

}
/*
 Extension Description :- Delegate method for table view.
 */
extension FAQsVC : UITableViewDelegate, UITableViewDataSource
{
    //Diplay sections cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrPreferences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "FAQsCell") as! FAQsCell
        cell.selectionStyle = .none
        
        cell.reloadData(dictionary: arrPreferences[indexPath.row] as! NSDictionary)
        cell.btnHideShow.tag = indexPath.row
        cell.btnHideShow.addTarget(self, action: #selector(btnTableViewDidSelect(FAQsCell:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func btnTableViewDidSelect(FAQsCell sender:UIButton)
    {
        let dic = NSMutableDictionary(dictionary: arrPreferences[sender.tag] as! NSDictionary)
        if dic.value(forKey: "isExpande") as! Bool == true
        {
            dic.setValue(false, forKey: "isExpande")
        }
        else{
            dic.setValue(true, forKey: "isExpande")
        }
        arrPreferences.replaceObject(at: sender.tag, with: dic)
        tableViewObj.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
    }
}
