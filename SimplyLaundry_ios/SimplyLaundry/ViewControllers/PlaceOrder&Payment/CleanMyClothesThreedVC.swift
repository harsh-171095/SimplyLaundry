//
//  CleanMyClothesThreedVC.swift
//  SimplyLaundry
//
//  Created by webclues on 02/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import DropDown
import VACalendar

var arrGlobalTimeSlot = NSArray()

class CleanMyClothesThreedVC: UIViewController
{
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnBack:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    //MARK:- Schedule of a Pickup and Drop off view Outlet's
    @IBOutlet weak var viewSchedulePickDropParent:UIView!
    @IBOutlet weak var lblSchedulePickDropTitle:UILabel!
    @IBOutlet weak var viewPickDropTitle:UIView!
    @IBOutlet weak var lblPickupTitle:UILabel!
    @IBOutlet weak var lblDropOffTitle:UILabel!

    @IBOutlet weak var viewPickDropDateTime:UIView!
    // PickUp Date
    @IBOutlet weak var viewPickUpDate:UIView!
    @IBOutlet weak var txtPickUpDate:UITextField!
    @IBOutlet weak var imgPickUpDate:UIImageView!
    @IBOutlet weak var btnPickUpDate : UIButton!

    // PickUp Time
    @IBOutlet weak var viewPickUpTime:UIView!
    @IBOutlet weak var txtPickUpTime:UITextField!
    @IBOutlet weak var imgPickUpTime:UIImageView!
    @IBOutlet weak var btnPickUpTime: UIButton!
    
    // Drop Off Date
    @IBOutlet weak var viewDropOffDate:UIView!
    @IBOutlet weak var txtDropOffDate:UITextField!
    @IBOutlet weak var imgDropOffDate:UIImageView!
    @IBOutlet weak var btnDropOffDate: UIButton!

    // Drop Off Time
    @IBOutlet weak var viewDropOffTime:UIView!
    @IBOutlet weak var txtDropOffTime:UITextField!
    @IBOutlet weak var imgDropOffTime:UIImageView!
    @IBOutlet weak var btnDropOffTime: UIButton!
    
    //MARK:- Tip view Outlet's
    @IBOutlet weak var viewSelectTipPercentParent:UIView!
    @IBOutlet weak var lblSelectTipPercentTitle:UILabel!
    @IBOutlet weak var viewSelectTipPercent:UIView!
    @IBOutlet weak var txtSelectTipPercent:UITextField!
    @IBOutlet weak var imgSelectTipPercent:UIImageView!
    @IBOutlet weak var btnSelectTipPercent:UIButton!
    
    //MARK:- Coupan Code view Outlet's
    @IBOutlet weak var viewCoupanCodeParent:UIView!
    @IBOutlet weak var lblCoupanCodeTitle:UILabel!
    @IBOutlet weak var viewCoupanCode:UIView!
    @IBOutlet weak var txtCoupanCode:UITextField!
    @IBOutlet weak var btnCoupanCode:UIButton!
    
    //MARK:- Check Uncheck Repeat Order Outlet's
    @IBOutlet weak var btnRepeatOrderCheckUnCheck:UIButton!
    
    @IBOutlet weak var viewRepeatOrderParent:UIView!
    @IBOutlet weak var lblRepeatOrderTitle:UILabel!
    @IBOutlet weak var viewRepeatOrder:UIView!
    @IBOutlet weak var txtRepeatOrder:UITextField!
    @IBOutlet weak var imgRepeatOrder:UIImageView!
    @IBOutlet weak var btnRepeatOrder:UIButton!
    @IBOutlet weak var consRepeatOrderHeight: NSLayoutConstraint!
    
    //Pyment List
    @IBOutlet weak var viewPaymentMethodParent:UIView!
    @IBOutlet weak var lblPaymentMethodTitle:UILabel!
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!

    //MARK:- Crad View Parent
    @IBOutlet weak var viewCardParent:UIView!
    @IBOutlet weak var consviewCardParent: NSLayoutConstraint! // Constraint: set 351 to Diplay and When Hidd set 0
                                                              // if user New card is not selected thne set constraint 351-215
    
    //MARK:- Select Card view Outlet's
    @IBOutlet weak var viewSelectCardParent:UIView!
    @IBOutlet weak var lblSelectCardTitle:UILabel!
    @IBOutlet weak var viewSelectCard:UIView!
    @IBOutlet weak var txtSelectCard:UITextField!
    @IBOutlet weak var imgSelectCard:UIImageView!
    @IBOutlet weak var btnSelectCard:UIButton!
    
    //MARK:- Check Uncheck New Card Outlet's
    @IBOutlet weak var btnNewCardCheckUnCheck:UIButton!
    
    //MARK:- Add new card Outlet's
    @IBOutlet weak var viewAddNewCard:UIView!
    @IBOutlet weak var lblAddNewCardTitle:UILabel!
    @IBOutlet weak var consAddNewCardHeight: NSLayoutConstraint! // Constraint: set 210 to Diplay and When Hidd set 0
    
    @IBOutlet weak var viewRegistrationType:UIView!
    @IBOutlet weak var lblAccountTypeTitle:UILabel!
    @IBOutlet weak var btnIndividual:UIButton!
    @IBOutlet weak var btnBusiness:UIButton!
    
    // Credit Card Number
    @IBOutlet weak var viewCreditCardNo:UIView!
    @IBOutlet weak var txtCreditCardNo:UITextField!
    @IBOutlet weak var imgCreditCardNo:UIImageView!
    
    // Card Expiration Date
    @IBOutlet weak var viewExpiDate:UIView!
    @IBOutlet weak var txtExpiDate:UITextField!
    
    // Card CVV Number
    @IBOutlet weak var viewCVVNo:UIView!
    @IBOutlet weak var txtCVVNo:UITextField!
    
    // Card Holder Name
    @IBOutlet weak var viewCardHolderName:UIView!
    @IBOutlet weak var txtCardHolderName:UITextField!
    @IBOutlet weak var imgCardHolderName:UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewButtonCircle: UIView!
    
    //Calendar View Outlet's
    @IBOutlet weak var viewCalendarParent: UIView!
    @IBOutlet weak var viewCalendar: UIView!
    @IBOutlet weak var viewCalendarMonth: VAMonthHeaderView! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL yyyy"
            
            let appereance = VAMonthHeaderViewAppearance(
                monthFont: UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_TWENTY)!,
                monthTextColor:COLOR.White,
                monthTextWidth: 200,
                previousButtonImage: UIImage.init(),
                nextButtonImage: UIImage.init(),
                dateFormatter: dateFormatter
            )
            viewCalendarMonth.appearance = appereance
        }
    }
    
    @IBOutlet weak var viewCalendarWeek: VAWeekDaysView!{
        didSet {
            let appereance = VAWeekDaysViewAppearance(
                symbolsType: .short,
                weekDayTextColor: COLOR.Balck,
                weekDayTextFont: UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!,
                leftInset: 0,
                rightInset: 0,
                calendar: defaultCalendar
            )
            viewCalendarWeek.appearance = appereance
            viewCalendarWeek.layer.borderWidth = 0.5
            viewCalendarWeek.layer.borderColor = COLOR.background_Gray.cgColor
        }
    }
    @IBOutlet weak var viewCalendarDays: UIView!
    @IBOutlet weak var btnCalendarDone: UIButton!
    @IBOutlet weak var btnCalendarCancel: UIButton!
    var calendarView: VACalendarView?
    
    // Variable Declarations and Initlizations
    let PickupTimePickerView = UIPickerView()
    let DropoffTimePickerView = UIPickerView()
    let ExpDatePickerView = UIPickerView()
    
    var dicCleanClothInfo = NSMutableDictionary()
    var deliveryOptionDay : Int = Int()
    var deliveryOptionHours : Int = Int()
 
    var arrMainTime : NSArray = NSArray()
    var arrDropoffTime : NSArray = NSArray()
    var arrPickupTime : NSArray = NSArray()
    var arrExpMonthPicker : NSArray = NSArray()
    var arrExpYearPicker : NSArray = NSArray()
    var arrPaymentList : NSMutableArray = NSMutableArray()
    var intPickupTimeIndex = Int()
    var intDropoffTimeIndex = Int()
    var intExpYearIndex = Int()
    var intExpMonthIndex = Int()
    var intPaymentIndex = Int()
    
    var intDateCalenderID : Int = 0
    var selectedDate = Date()
    var pickupDate = Date()
    var dropoffDate = Date()
    var arrPickupDate = [Date]()
    var arrDropoffDate = [Date]()
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone.current//TimeZone(secondsFromGMT:0)!
        calendar.locale = Locale.current
        return calendar
    }()
    var dateFirstOnCalender = Date()
    var dateLastOnCalender = Date()
    
    var arrCardList : NSArray = NSArray()
    var isCheque : String = "0"
    var dicPaypalToken = NSDictionary()
    
    var intSelectedRepeatOrder : Int = 0
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if arrGlobalTimeSlot.count > 0
        {
            arrMainTime = NSArray(array: arrGlobalTimeSlot)
            setDataOfViewController()
        }
        else{
            processGetTimeSlot()
        }
        
        processGetAllCreditCard()
        setTheme()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        lblVCTitle.setVCTitle("Clean My Clothes")

        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        
        // Schedule Pickup and Drop off Parent View theme
        viewSchedulePickDropParent.backgroundColor = COLOR.clear
        lblSchedulePickDropTitle.setThemeForTextFiledTitle("Schedule a time for Pickup and Drop off.")
        
        //Pickup Drop off label Title theme
        viewPickDropTitle.backgroundColor = COLOR.clear
        lblPickupTitle.text = "Pickup*"
        lblPickupTitle.textColor = COLOR.Gray
        lblPickupTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        lblDropOffTitle.text = "Drop off*"
        lblDropOffTitle.textColor = COLOR.Gray
        lblDropOffTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        
        //Pichup and Drop off Date and Time theme
        viewPickDropDateTime.backgroundColor = COLOR.clear
        
        viewPickUpDate.backgroundColor = COLOR.background_Gray
        viewPickUpDate.setCornerRadius(corner:5)
        txtPickUpDate.text = ""
        txtPickUpDate.textColor = COLOR.textFiled
        txtPickUpDate.placeholder = "DD/MM/YYYY"
        txtPickUpDate.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        txtPickUpDate.setPlaceholderColor(color: COLOR.placeholder)
        txtPickUpDate.isUserInteractionEnabled = false
        imgPickUpDate.image = UIImage.init(named: "date")
        btnPickUpDate.setTitle("", for: .normal)
        btnPickUpDate.tag = 1
        btnPickUpDate.addTarget(self, action: #selector(btnPickupDateClick(_:)), for: .touchUpInside)
        
        viewPickUpTime.backgroundColor = COLOR.background_Gray
        viewPickUpTime.setCornerRadius(corner:5)
        txtPickUpTime.text = ""
        txtPickUpTime.textColor = COLOR.textFiled
        txtPickUpTime.placeholder = "Time"
        txtPickUpTime.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        txtPickUpTime.setPlaceholderColor(color: COLOR.placeholder)
        txtPickUpTime.isUserInteractionEnabled = false
        imgPickUpTime.image = UIImage.init(named: "time")
        btnPickUpTime.setTitle("", for: .normal)
        btnPickUpTime.addTarget(self, action: #selector(btnPickupTimeClick(_:)), for: .touchUpInside)
        
        viewDropOffDate.backgroundColor = COLOR.background_Gray
        viewDropOffDate.setCornerRadius(corner:5)
        txtDropOffDate.text = ""
        txtDropOffDate.textColor = COLOR.textFiled
        txtDropOffDate.placeholder = "DD/MM/YYYY"
        txtDropOffDate.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        txtDropOffDate.setPlaceholderColor(color: COLOR.placeholder)
        txtDropOffDate.isUserInteractionEnabled = false
        imgDropOffDate.image = UIImage.init(named: "date")
        btnDropOffDate.setTitle("", for: .normal)
        btnDropOffDate.tag = 2
        btnDropOffDate.addTarget(self, action: #selector(btnDropoffDateClick(_:)), for: .touchUpInside)

        viewDropOffTime.backgroundColor = COLOR.background_Gray
        viewDropOffTime.setCornerRadius(corner:5)
        txtDropOffTime.text = ""
        txtDropOffTime.textColor = COLOR.textFiled
        txtDropOffTime.placeholder = "Time"
        txtDropOffTime.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        txtDropOffTime.setPlaceholderColor(color: COLOR.placeholder)
        txtDropOffTime.isUserInteractionEnabled = false
        imgDropOffTime.image = UIImage.init(named: "time")
        btnDropOffTime.setTitle("", for: .normal)
        btnDropOffTime.addTarget(self, action: #selector(btnDropofTimeClick(_:)), for: .touchUpInside)
        
        //set the Tip View Theme
        viewSelectTipPercentParent.backgroundColor = COLOR.clear
        lblSelectTipPercentTitle.setThemeForTextFiledTitle("Tip")
        viewSelectTipPercent.backgroundColor = COLOR.background_Gray
        viewSelectTipPercent.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectTipPercent.setThemeFor("Select Percentage of Tip You Give.")
        imgSelectTipPercent.image = UIImage.init(named: "down_arrow")
        btnSelectTipPercent.setTitle("", for: .normal)
        btnSelectTipPercent.addTarget(self, action: #selector(btnSelectTipPercentClick(_:)), for: .touchUpInside)
        
        //set the Coupan Code View Theme
        viewCoupanCodeParent.backgroundColor = COLOR.clear
        lblCoupanCodeTitle.setThemeForTextFiledTitle("Coupon Code")
        viewCoupanCode.backgroundColor = COLOR.background_Gray
        viewCoupanCode.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtCoupanCode.setThemeFor("XXXX")
        btnCoupanCode.setTitle("APPLY", for: .normal)
        btnCoupanCode.setTitleColor(COLOR.White, for: .normal)
        btnCoupanCode.backgroundColor = COLOR.Blue
        btnCoupanCode.titleLabel?.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_TWELVE)
        btnCoupanCode.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        btnCoupanCode.setCornerRadius(corner: 4)
        btnCoupanCode.addTarget(self, action: #selector(btnCoupanCodeClick(_:)), for: .touchUpInside)

        // set the repeat order check and Uncheck Theme
        btnRepeatOrderCheckUnCheck.setTitle("  Repeat Order", for: .normal)
        btnRepeatOrderCheckUnCheck.setImage(UIImage.init(named: "checkbox"), for: .normal)
        btnRepeatOrderCheckUnCheck.tag = 111
        btnRepeatOrderCheckUnCheck.setTitleColor(COLOR.Gray, for: .normal)
        btnRepeatOrderCheckUnCheck.addTarget(self, action: #selector(btnCheckUnCheckClick(_:)), for: .touchUpInside)
        btnRepeatOrderCheckUnCheck.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)

        viewRepeatOrderParent.backgroundColor = COLOR.clear
        lblRepeatOrderTitle.setThemeForTextFiledTitle( "Select Frequency")
        viewRepeatOrder.backgroundColor = COLOR.background_Gray
        viewRepeatOrder.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtRepeatOrder.setThemeFor("Select Frequency")
        imgRepeatOrder.image = UIImage.init(named: "down_arrow")
        btnRepeatOrder.setTitle("", for: .normal)
        btnRepeatOrder.addTarget(self, action: #selector(btnRepeatOrderPressed(_:)), for: .touchUpInside)
        
        viewPaymentMethodParent.backgroundColor = COLOR.clear
        lblPaymentMethodTitle.setThemeForTextFiledTitle("Payment Method")
        tableViewObj.register(UINib(nibName: "ExtraServiceCell", bundle: nil), forCellReuseIdentifier: "ExtraServiceCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = false

        //set the Select Card View Theme
        viewSelectCardParent.backgroundColor = COLOR.clear
        lblSelectCardTitle.setThemeForTextFiledTitle("Select Card")
        viewSelectCard.backgroundColor = COLOR.background_Gray
        viewSelectCard.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectCard.setThemeFor( "Please Select Credit Card")
        imgSelectCard.image = UIImage.init(named: "down_arrow")
        btnSelectCard.setTitle("", for: .normal)
        btnSelectCard.addTarget(self, action: #selector(btnSelectCardClick(_:)), for: .touchUpInside)
        
        // set the new Card check and Uncheck Theme
        btnNewCardCheckUnCheck.setTitle("  I want to use new credit card", for: .normal)
        btnNewCardCheckUnCheck.setImage(UIImage.init(named: "checkbox"), for: .normal)
        btnNewCardCheckUnCheck.setTitleColor(COLOR.Gray, for: .normal)
        btnNewCardCheckUnCheck.addTarget(self, action: #selector(btnCheckUnCheckClick(_:)), for: .touchUpInside)
        btnNewCardCheckUnCheck.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        
        // set the add New card View Theme
        viewAddNewCard.backgroundColor = COLOR.clear
        lblAddNewCardTitle.setThemeForTextFiledTitle("We currently only accept major credit cards.")

        //set the Card type View Theme
        viewRegistrationType.backgroundColor = COLOR.clear
        
        lblAccountTypeTitle.setThemeForTextFiledTitle("Account Type")
        
        btnIndividual.setThemeForRadioBtton("Individual", isSelected: true)
        btnIndividual.addTarget(self, action: #selector(btnRadioChekUncheckClick(_:)), for: .touchUpInside)
        
        btnBusiness.setThemeForRadioBtton("Business")
        btnBusiness.addTarget(self, action: #selector(btnRadioChekUncheckClick(_:)), for: .touchUpInside)

        //set the Credit Card Number Theme
        viewCreditCardNo.backgroundColor = COLOR.background_Gray
        viewCreditCardNo.setCornerRadius(corner: 5)
        txtCreditCardNo.setThemeFor("Credit Card Number*")
        txtCreditCardNo.isSecureTextEntry = false
        txtCreditCardNo.delegate = self
        imgCreditCardNo.image = UIImage.init(named: "credit_card")
        
        //set the Credit Card expiretion Date Theme
        viewExpiDate.backgroundColor = COLOR.background_Gray
        viewExpiDate.setCornerRadius(corner: 5)
        txtExpiDate.setThemeFor("Expriation Date*")
        txtExpiDate.delegate = self
        
        //set the Credit Card CVV Number Theme
        viewCVVNo.backgroundColor = COLOR.background_Gray
        viewCVVNo.setCornerRadius(corner: 5)
        txtCVVNo.setThemeFor("CVV*")
        txtCVVNo.isSecureTextEntry = true
        txtCVVNo.delegate = self
        
        //set the Credit Card Holder Name Theme
        viewCardHolderName.backgroundColor = COLOR.background_Gray
        viewCardHolderName.setCornerRadius(corner: 5)
        viewCardHolderName.isHidden = true
        txtCardHolderName.setThemeFor("Card Holder Name", returnKeyType : .done)
        txtCardHolderName.delegate = self
        imgCardHolderName.image = UIImage.init(named: "first_name")
        
        //set the LET'S DO SOME LAUNDRY Theme
        btnNext.setThemeForAppButton("LET'S DO SOME LAUNDRY")
        btnNext.addTarget(self, action: #selector(btnNextClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
        
        viewCalendarParent.backgroundColor = COLOR.Balck.withAlphaComponent(0.2)
        viewCalendarParent.isHidden = true
        
        viewCalendar.backgroundColor = COLOR.White
        viewCalendar.setCornerRadius(corner:5)
        viewCalendarMonth.backgroundColor = COLOR.Green
        
        btnCalendarDone.setTitle("DONE", for: .normal)
        btnCalendarDone.tag = 2
        btnCalendarDone.setTitleColor(COLOR.White, for: .normal)
        btnCalendarDone.titleLabel?.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)
        btnCalendarDone.addTarget(self, action: #selector(btnCalendarCancelAndDoneClick(_:)), for: .touchUpInside)
        
        btnCalendarCancel.setTitle("CANCEL", for: .normal)
        btnCalendarCancel.setTitleColor(COLOR.White, for: .normal)
        btnCalendarCancel.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnCalendarCancel.addTarget(self, action: #selector(btnCalendarCancelAndDoneClick(_:)), for: .touchUpInside)
        
        setDataOfViewController()
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        consAddNewCardHeight.constant = 0
        viewAddNewCard.isHidden = true
        
        btnPickUpTime.isUserInteractionEnabled = false
        txtPickUpTime.isUserInteractionEnabled = false
        btnDropOffDate.isUserInteractionEnabled = false
        txtDropOffDate.isUserInteractionEnabled = false
        btnDropOffTime.isUserInteractionEnabled = false
        txtDropOffTime.isUserInteractionEnabled = false
        
        arrDropoffTime = arrMainTime
        arrPickupTime = arrMainTime
        arrExpMonthPicker = ["01","02","03","04","05","06","07","08","09","10","11","12"]
        txtSelectTipPercent.text = "10%"
        if isCheque == "1"
        {
            arrPaymentList = [["title":RequestParameters_place_order.payment_method_values.Credit_Card,isSelected_Key:true],
                              ["title":RequestParameters_place_order.payment_method_values.Paypal,isSelected_Key:false],
                              ["title":RequestParameters_place_order.payment_method_values.Cheque,isSelected_Key:false]
            ]
            
            intPaymentIndex = 0
        }
        else{
            arrPaymentList = [["title":RequestParameters_place_order.payment_method_values.Credit_Card,isSelected_Key:true],
                              ["title":RequestParameters_place_order.payment_method_values.Paypal,isSelected_Key:false]
            ]
            intPaymentIndex = 0
        }
        tableViewObj.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
        let date = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current//TimeZone(secondsFromGMT:0)!
        let year = calendar.component(.year, from: date)
        print(year)
        var strYear = ""
        var intYear = Int(year)
        
        for i in 1...50
        {
            if i == 1
            {
                strYear = "\(intYear)"
            }
            else
            {
                intYear = intYear + 1
                strYear = "\(strYear),\(intYear)"
            }
        }
        
        arrExpYearPicker = strYear.components(separatedBy: ",") as NSArray
        
        ExpDatePickerView.tag = 5
        setTimePicker(pickerView: ExpDatePickerView, textFiled: txtExpiDate, pickerDoneAction: #selector(pickDoneClick(_:)), pickerCancelAction: #selector(pickCancelClick(_:)))
        setCardViewDisplay()
        
        consRepeatOrderHeight.constant = 0
        viewRepeatOrderParent.isHidden = true
    }
    
    /*
     Function Name :- setCardViewDisplay
     Function Parameters :- (nil)
     Function Description :- check login user payment method is credit card or cheque. and set default creadit card.
     */
    func setCardViewDisplay()
    {
        let predicateSearch = NSPredicate(format: "\(isSelected_Key) == %@", NSNumber(value: true))
        let array = NSMutableArray(array: arrPaymentList.filtered(using: predicateSearch) as NSArray)
        if "\((array[0] as! NSDictionary).value(forKey: "title")!)" == RequestParameters_place_order.payment_method_values.Credit_Card
        {
            viewCardParent.isHidden = false
            if btnNewCardCheckUnCheck.imageView!.image == UIImage.init(named: "checkbox")
            {
                consviewCardParent.constant = 346 - 210
            }
            else{
                consviewCardParent.constant = 346
            }
        }
        else{
            viewCardParent.isHidden = true
            consviewCardParent.constant = 0
        }
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectTipPercentClick(_ sender: Any)
    {
        self.view.endEditing(true)
        initDropDown( dataSource: ["0%","10%","15%","20%"], textFiled: txtSelectTipPercent, nil)
    }
    
    @IBAction func btnCoupanCodeClick(_ sender: Any)
    {
        self.view.endEditing(true)
        if (txtCoupanCode.text?.count)! == 0
        {
            showMyAlertView(message: "Coupan code required.") { (action) in }
            return
        }
        processCheckPromocode(code: txtCoupanCode.text!)
    }
    
    @IBAction func btnSelectCardClick(_ sender: Any)
    {
        self.view.endEditing(true)
        initDropDown( dataSource: getNSArrayToStringArray(array: arrCardList, forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no), textFiled: txtSelectCard, nil)
    }
    
    @IBAction func btnCheckUnCheckClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if sender.tag == 111
        {
            if sender.imageView!.image == UIImage.init(named: "checkbox")
            {
                sender.setImage(UIImage.init(named: "checkbox_done"), for: .normal)
                consRepeatOrderHeight.constant = 95
                viewRepeatOrderParent.isHidden = false
                
                intSelectedRepeatOrder = 1
                txtRepeatOrder.text = "Every Week"
            }
            else
            {
                sender.setImage(UIImage.init(named: "checkbox"), for: .normal)
                consRepeatOrderHeight.constant = 0
                viewRepeatOrderParent.isHidden = true
            }
        }
        else{
            if sender.imageView!.image == UIImage.init(named: "checkbox")
            {
                sender.setImage(UIImage.init(named: "checkbox_done"), for: .normal)
                consAddNewCardHeight.constant = 210
                viewAddNewCard.isHidden = false
            }
            else{
                sender.setImage(UIImage.init(named: "checkbox"), for: .normal)
                consAddNewCardHeight.constant = 0
                viewAddNewCard.isHidden = true
            }
            setCardViewDisplay()
        }
    }
    
    @IBAction func btnRepeatOrderPressed(_ sender: UIButton)
    {
        self.view.endEditing(true)
        initDropDown( dataSource: ["Every Week","Every 2 Week","Every Month"], textFiled: txtRepeatOrder) { (index, value) in
            self.intSelectedRepeatOrder = index + 1
        }
    }
    
    @IBAction func btnRadioChekUncheckClick(_ sender : UIButton)
    {
        self.view.endEditing(true)
        if sender == btnIndividual
        {
            btnIndividual.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
            btnBusiness.setImage(UIImage.init(named: "radio_button"), for: .normal)
        }
        else{
            btnIndividual.setImage(UIImage.init(named: "radio_button"), for: .normal)
            btnBusiness.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
        }
    }

    @IBAction func btnNextClick(_ sender: Any)
    {
        self.view.endEditing(true)
        var strMessage = String()
        if (txtPickUpDate.text?.count)! == 0
        {
            strMessage = "Enter Pickup Date."
        }
        else if (txtPickUpTime.text?.count)! == 0
        {
            strMessage = "Enter Pickup Time."
        }
        else if (txtDropOffDate.text?.count)! == 0
        {
            strMessage = "Enter Drop Off Date."
        }
        else if (txtDropOffTime.text?.count)! == 0
        {
            strMessage = "Enter Drop Off Time."
        }
        
        
        if strMessage.count > 1
        {
            showMyAlertView(message: strMessage) { (action) in }
            return
        }
        let paymentMethod = checkPaymentMethod()
        if paymentMethod == RequestParameters_place_order.payment_method_values.Credit_Card
        {
            if self.btnNewCardCheckUnCheck.imageView!.image == UIImage.init(named: "checkbox_done")
            {
                if (txtCreditCardNo.text?.count)! == 0
                {
                    strMessage = "Enter Credit Card Number."
                }
                else if txtCreditCardNo.text!.count < 18
                {
                    strMessage = "16 or 15 Digits Credit Cards Are No Longer Used And it Will Be Treated as an Invalid Card Number"
                }
                else if (txtExpiDate.text?.count)! == 0
                {
                    strMessage = "Enter Card Expiration Date."
                }
                else if (txtCVVNo.text?.count)! == 0
                {
                    strMessage = "Enter Card CVV Number."
                }
                else if (txtCVVNo.text?.count)! < 3
                {
                    strMessage = "Insert Minimum CVV 3 Digits."
                }
                
                if strMessage.count == 0
                {
                    let cardNumber = txtCreditCardNo.text?.split(separator: " ")
                    let month = txtExpiDate.text?.split(separator: "-")
                    var strCardDetails = String()
                    if (cardNumber?.count)! > 0
                    {
                        strCardDetails = "\(cardNumber![0])," + txtCVVNo.text! + ",\(cardNumber![1])," + "\(month![0])," + "\(cardNumber![2])," + "\(month![1])," + "\(cardNumber![3])"
                        
                        let data = (strCardDetails).data(using: String.Encoding.utf8)
                        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                        print(base64)
                        strCardDetails = base64
                    }
                    dicCleanClothInfo.setValue(strCardDetails, forKey: RequestParameters_place_order.cc_number)
                }
            }
            else{
                if arrCardList.count == 0
                {
                    if self.btnNewCardCheckUnCheck.imageView!.image != UIImage.init(named: "checkbox_done")
                    {
                        strMessage = "Please Add New Card."
                    }
                }
                else if (txtSelectCard.text?.count)! == 0
                {
                    strMessage = "Please Select Card."
                }
                dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.payment_profile_id),
                                           forKey: RequestParameters_place_order.payment_profile_id)
            }
            
            dicCleanClothInfo.setValue(RequestParameters_place_order.payment_method_values.Credit_Card,
                                       forKey: RequestParameters_place_order.payment_method)
            
        }
        else if paymentMethod == RequestParameters_place_order.payment_method_values.Cheque
        {
            dicCleanClothInfo.setValue(RequestParameters_place_order.payment_method_values.Cheque,
                                       forKey: RequestParameters_place_order.payment_method)
        }
        else {
            dicCleanClothInfo.setValue(RequestParameters_place_order.payment_method_values.Paypal,
                                       forKey: RequestParameters_place_order.payment_method)
        }
        
        if strMessage.count > 1
        {
            showMyAlertView(message: strMessage) { (action) in }
            return
        }
        
        dicCleanClothInfo.setValue(RequestParameters_place_order.order_platform_values.Ios,
                                   forKey: RequestParameters_place_order.order_platform)
        
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.cc_payment_customer_type),
                                   forKey: RequestParameters_place_order.cc_payment_customer_type)
        
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.select_payment_account),
                                   forKey: RequestParameters_place_order.select_payment_account)
        dicCleanClothInfo.setValue(getDateFrom(string: txtPickUpDate.text!, fromDateFormate: "dd/MM/yyyy", getDateFormate: "yyyy-MM-dd"),
                                   forKey: RequestParameters_place_order.pickup_date)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.pickup_time_slot_id),
                                   forKey: RequestParameters_place_order.pickup_time_slot_id)
        dicCleanClothInfo.setValue(getDateFrom(string: txtDropOffDate.text!, fromDateFormate: "dd/MM/yyyy", getDateFormate: "yyyy-MM-dd"),
                                   forKey: RequestParameters_place_order.delivery_date)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.delivery_time_slot_id),
                                   forKey: RequestParameters_place_order.delivery_time_slot_id)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.driver_tip),
                                   forKey: RequestParameters_place_order.driver_tip)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.is_repeat),
                                   forKey: RequestParameters_place_order.is_repeat)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.agree),
                                   forKey: RequestParameters_place_order.agree)
        dicCleanClothInfo.setValue(getUserID(),
                                   forKey: RequestParameters_place_order.user_id)
        
        
        if self.btnRepeatOrderCheckUnCheck.imageView!.image == UIImage.init(named: "checkbox_done")
        {
            dicCleanClothInfo.setValue(intSelectedRepeatOrder,
                                       forKey: RequestParameters_place_order.is_repeat_order_type)
        }
        
        if paymentMethod == RequestParameters_place_order.payment_method_values.Paypal
        {
            processGetPaypalToken()
        }
        else
        {
            processPlaceOrder()
        }
    }
    
    @IBAction func btnPickupDateClick(_ sender:UIButton)
    {
        self.view.endEditing(true)
        intDateCalenderID = sender.tag
        viewCalendarParent.isHidden = false
        Calender(intVisibaleDays: 30)
    }
    
    @IBAction func btnPickupTimeClick(_ sender:UIButton)
    {
        initDropDown( dataSource: getNSArrayToStringArray(array: arrPickupTime as NSArray, forKey: ResponceKey_get_time_slot.dataValues.time_title), textFiled: txtPickUpTime) { (index, value) in
            self.intPickupTimeIndex = index
            self.txtDropOffDate.text = ""
            self.txtDropOffTime.text = ""
            self.btnDropOffDate.isUserInteractionEnabled = true
        }
        
        txtDropOffDate.text = ""
        btnDropOffDate.isUserInteractionEnabled = true
        txtDropOffTime.text = ""
        btnDropOffTime.isUserInteractionEnabled = false
    }
    
    @IBAction func btnDropoffDateClick(_ sender:UIButton)
    {
        self.view.endEditing(true)
        intDateCalenderID = sender.tag
        viewCalendarParent.isHidden = false
        Calender(isDropoffDate: true)
       
    }
    
    @IBAction func btnDropofTimeClick(_ sender:UIButton)
    {
        initDropDown(dataSource: getNSArrayToStringArray(array: arrDropoffTime as NSArray, forKey: ResponceKey_get_time_slot.dataValues.time_title), textFiled: txtDropOffTime) { (index, value) in
            self.intDropoffTimeIndex = index
        }
    }
    
    @IBAction func viewHideCalender(_ sender:Any)
    {
        self.view.endEditing(true)
        intDateCalenderID = 0
        viewCalendarParent.isHidden = true
    }
    
    @IBAction func btnNextCalender(_ sender:Any)
    {
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "MM"
    }
    
    @IBAction func btnPreviousCalender(_ sender:Any)
    {
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "yyyy-MM-dd"
        let max_date = Date()
        let dateCurrent = dateformatter1.string(from: max_date)
        let calenderFirst = dateformatter1.string(from: dateFirstOnCalender)
        if dateCurrent == calenderFirst
        {
            
        }
        else{
            
        }
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height
        Application_Delegate.showSpinnerView(isShow: false)
    }
   
    /*
     Function Name :- checkPaymentMethod
     Function Parameters :- (nil)
     Function Description :- get selected payment method.
     */
    func checkPaymentMethod()-> String
    {
        let predicateSearch = NSPredicate(format: "\(isSelected_Key) == %@", NSNumber(value: true))
        let array = NSMutableArray(array: arrPaymentList.filtered(using: predicateSearch) as NSArray)
        return "\((array[0] as! NSDictionary).value(forKey: "title")!)" 
    }
    
    /*
     Function Name :- getIDFrom
     Function Parameters :- (key : String)
     Function Description :- get a ID from given key value.
     */
    func getIDFrom(key string: String)-> String
    {
        if string == RequestParameters_place_order.pickup_time_slot_id // For pickup time slot id
        {
            let arrayMain = NSArray(array: arrMainTime)
            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_time_slot.dataValues.time_title) CONTAINS[C] '\(txtPickUpTime.text!)'")
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
                return "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_slot_id)!)"
            }
        }
        else if string == RequestParameters_place_order.delivery_time_slot_id // For get delivery time slot id
        {
            let arrayMain = NSArray(array: arrMainTime)
            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_time_slot.dataValues.time_title) CONTAINS[C] '\(txtDropOffTime.text!)'")
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
                return "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_slot_id)!)"
            }
        }
        else if string == RequestParameters_place_order.payment_profile_id
        {
            let arrayMain = NSArray(array: arrCardList)
            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_credit_card.dataValues.payment_card_no) CONTAINS[C] '\(txtSelectCard.text!)'")
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
               return "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)"
            }
        }
        else if string == RequestParameters_place_order.payment_method
        {
            return RequestParameters_place_order.payment_method_values.Credit_Card
        }
        else if string == RequestParameters_place_order.select_payment_account
        {
            if self.btnNewCardCheckUnCheck.imageView!.image == UIImage.init(named: "checkbox_done")
            {
                return RequestParameters_place_order.select_payment_account_values.create_new_credit_card
            }
            else{
                return RequestParameters_place_order.select_payment_account_values.use_cim_payment_account
            }
        }
        else if string == RequestParameters_place_order.is_repeat
        {
            if btnRepeatOrderCheckUnCheck.imageView?.image == UIImage.init(named: "checkbox_done")
            {
                return RequestParameters_place_order.is_repeat_values.yes
            }
            else{
                return RequestParameters_place_order.is_repeat_values.no
            }
        }
        else if string == RequestParameters_place_order.cc_payment_customer_type
        {
            if btnIndividual.imageView?.image == UIImage.init(named: "radio_button_selected")
            {
                return RequestParameters_place_order.cc_payment_customer_type_values.individual
            }
            else{
                return RequestParameters_place_order.cc_payment_customer_type_values.business
            }
        }
        else if string == RequestParameters_place_order.agree
        {
            return RequestParameters_place_order.is_repeat_values.yes
        }
        else if string == RequestParameters_place_order.driver_tip
        {
            let strSpitl = txtSelectTipPercent.text!.split(separator: "%")
            return String(strSpitl[0])
        }
        return String()
    }
    
    //MARK:- API Call Funtions
    func processGetTimeSlot()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = [:]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_GET(reqTask: reqGetTimeSlot, dictParameter: parameters as NSDictionary)
    }
    
    func processGetAllCreditCard()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllCreditCard, dictParameter: parameters as NSDictionary)
    }
    
    func processCheckPromocode(code: String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["coupon_code":code,"user_id":getUserID(),"wash_service[]":dicCleanClothInfo[RequestParameters_place_order.wash_service] as Any]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckPromocode, dictParameter: parameters as NSDictionary)
    }
    
    func processPlaceOrder()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqPlaceOrder, dictParameter: dicCleanClothInfo)
    }
    
    func processGetPaypalToken()
    {
        let parameters : [String:Any] = ["grant_type":"client_credentials"]
        Application_Delegate.showSpinnerView(isShow: true)
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: get_paypal_Token, dictParameter: parameters as NSDictionary)
    }
    
    func processGetPaypalLoginURL()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        callPaypalLoginURL(URL : getAgreementTokens, dicHeaderData: dicPaypalToken) { (responseData) in
            print(responseData)
            
            if let arrlinks : NSArray = responseData.value(forKey: "links") as? NSArray
            {
                DispatchQueue.main.async {
                    Application_Delegate.showSpinnerView(isShow: false)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "PaymetWebViewVC") as! PaymetWebViewVC
                    controller.strPaypalURL = "\((arrlinks.firstObject as! NSDictionary).value(forKey: "href")!)"
                    controller.dicCleanClothInfo = self.dicCleanClothInfo
                    controller.dicPaypalToken = self.dicPaypalToken
                    self.navigationController?.pushViewController(controller, animated: true)

                }
            }
            else {
                DispatchQueue.main.async {
                    Application_Delegate.showSpinnerView(isShow: false)
                }
            }
        }
    }
    
    // MARK:- Ojective Functions
    @objc func pickDoneClick(_ sender:UIBarButtonItem)
    {
        if sender.tag == 3{
            btnDropOffDate.isUserInteractionEnabled = true
            txtDropOffDate.text = ""
            selectedDate = Date()
            txtDropOffTime.text = ""
            txtDropOffTime.isUserInteractionEnabled = false
            intDropoffTimeIndex = 0
            txtPickUpTime.text = "\((arrPickupTime[intPickupTimeIndex] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_title) as! String)"
        }
        else if sender.tag == 4{
            txtDropOffTime.text = "\((arrDropoffTime[intDropoffTimeIndex] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_title) as! String)"
        }
        else if sender.tag == 5{
            txtExpiDate.text = "\(arrExpMonthPicker[intExpMonthIndex])-\(arrExpYearPicker[intExpYearIndex])"
        }
        self.view.endEditing(true)
    }

    @objc func pickCancelClick(_ sender:Any)
    {
        self.view.endEditing(true)
    }
    
    private func selectDate(date:Date)
    {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .medium
        dateformatter.amSymbol = "AM"
        dateformatter.pmSymbol = "PM"
        dateformatter.dateFormat = "dd/MM/yyyy"
        if intDateCalenderID == 1
        {
            pickupDate = date
            btnPickUpTime.isUserInteractionEnabled = true
            txtPickUpDate.text = dateformatter.string(from: date)
        }
        else if intDateCalenderID == 2
        {
            dropoffDate = date
            btnDropOffTime.isUserInteractionEnabled = true
            txtDropOffDate.text = dateformatter.string(from: date)
        }
    }
    
    //MARK:- Calendar Logic
    @IBAction func btnCalendarCancelAndDoneClick(_ sender:UIButton)
    {
        self.view.endEditing(true)
        calendarView?.removeFromSuperview()
        if sender.titleLabel?.text == "DONE"
        {
            selectDate(date: selectedDate)
            if intDateCalenderID == 1 // pickup date
            {
                intPickupTimeIndex = 0
                intDropoffTimeIndex = 0
                
                txtPickUpTime.text = ""
                btnPickUpTime.isUserInteractionEnabled = true
                txtDropOffDate.text = ""
                btnDropOffDate.isUserInteractionEnabled = false
                txtDropOffTime.text = ""
                btnDropOffTime.isUserInteractionEnabled = false
                
                let weekDays = getDateFrom(string: txtPickUpDate.text!, fromDateFormate: "dd/MM/yyyy", getDateFormate: "E")
                let max_date = Date()
                let CurrentDateFormatter = DateFormatter()
                CurrentDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let currentDate : String = getDateFrom(string:  CurrentDateFormatter.string(from: max_date), getDateFormate: "dd/MM/yyyy")
                if txtPickUpDate.text! == currentDate
                {
                    let time : Int = Int(getDateFrom(string: CurrentDateFormatter.string(from: max_date), getDateFormate: "HH"))!
                    if weekDays.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased()
                    {
                        let array : NSMutableArray = NSMutableArray()
                        for i in 1..<arrMainTime.count{
                            array.add(arrMainTime[i])
                        }
                        arrPickupTime = NSArray(array: array)
                    }
                    else{
                        if time < 10{
                            let array : NSMutableArray = NSMutableArray()
                            for i in 0..<arrMainTime.count{
                                array.add(arrMainTime[i])
                            }
                            arrPickupTime = NSArray(array: array)
                        }
                        else if time >= 10{
                            let array : NSMutableArray = NSMutableArray()
                            for i in 0..<arrMainTime.count{
                                if i != 0
                                {
                                    array.add(arrMainTime[i])
                                }
                            }
                            arrPickupTime = NSArray(array: array)
                        }
                        else{
                            arrPickupTime = NSArray(array: arrMainTime)
                        }
                    }
                }
                else{
                    if weekDays.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased()
                    {
                        let array : NSMutableArray = NSMutableArray()
                        for i in 1..<arrMainTime.count{
                            array.add(arrMainTime[i])
                        }
                        arrPickupTime = NSArray(array: array)
                    }
                    else{
                        arrPickupTime = NSArray(array: arrMainTime)
                    }
                }
            }
            else if intDateCalenderID == 2 // Dropoff date
            {
                btnDropOffDate.isUserInteractionEnabled = true
                txtDropOffTime.text = ""
                btnDropOffTime.isUserInteractionEnabled = true
                
                let strfirstDateObj = getStringDateFromDATEObject(arrDropoffDate.first!, getDateFormate: "yyyy-MM-dd")
                let strSelectedDateObj = getDateFrom(string: "\(txtDropOffDate.text!)", fromDateFormate: "dd/MM/yyyy", getDateFormate: "yyyy-MM-dd")
                if strfirstDateObj == strSelectedDateObj
                {
                    let array : NSMutableArray = NSMutableArray()
//                    let timeSlot = arrPickupTime[intPickupTimeIndex] as! NSDictionary
//                    let myTime = Int(getDateFrom(string: "\(timeSlot.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)", fromDateFormate: "HH:mm:ss", getDateFormate: "H"))!
                    let myTime = Int(getStringDateFromDATEObject(arrDropoffDate.first!, getDateFormate: "HH"))!
                    let weekDays = getDateFrom(string: txtDropOffDate.text!, fromDateFormate: "dd/MM/yyyy", getDateFormate: "E")
                    print("if the fist date of array is selected \ncheck week day is holdy or not:- \(weekDays.lowercased()) == \(ResponceKey_get_global.halfdayOffName.lowercased())")
                    if weekDays.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased()
                    {
                        for i in 1..<arrMainTime.count{
                            let dic = arrMainTime[i] as! NSDictionary
                            let Totime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)".split(separator:  ":")
                            print("is half day drop-off delivery option :- \(Int(Totime[0])!) >= \(myTime)")
                            if Int(Totime[0])! >= myTime
                            {
                                array.add(arrMainTime[i])
                            }
                        }
                        if array.count > 0
                        {
                            let strEveningAnyTime = "\((arrMainTime.lastObject as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)"
                            var splitDate = strEveningAnyTime.split(separator: ":")
                            let intEveningAnyTime = Int(splitDate[0])!
                            let strTime = "\((array.firstObject as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)"
                            splitDate = strTime.split(separator: ":")
                            let intTime = Int(splitDate[0])!
                            
                            if intTime >= intEveningAnyTime
                            {
                                if "\((array.lastObject as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_slot_id)!)" != "4"
                                {
                                    array.add(arrMainTime.lastObject!)
                                }
                            }
                        }
                    }
                    else{
                        if deliveryOptionHours < 24
                        {
                            if  myTime >= 20
                            {
                                array.add(arrMainTime.lastObject as! NSDictionary)
                            }
                            else{
                                for i in 0..<arrMainTime.count{
                                    let dic = arrMainTime[i] as! NSDictionary
                                    let Fromtime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)".split(separator:  ":")
                                    let Totime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_to)!)".split(separator:  ":")
                                    print("Time is \(myTime) >= \(Int(Fromtime[0])!)  && \(myTime) <= \(Int(Totime[0])!)")
                                    if Int(Fromtime[0])! >= myTime
                                    {
                                        array.add(arrMainTime[i])
                                    }
                                }
                            }
                        }
                        else{
                        if myTime >= 20 {
//                            myTime = 20
                            for i in 0..<arrMainTime.count{
                                let dic = arrMainTime[i] as! NSDictionary
                                //                                let Fromtime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)".split(separator:  ":")
                                let Totime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)".split(separator:  ":")
                                print("is half day drop-off delivery option :- \(Int(Totime[0])!) >= \(myTime)")
                                if Int(Totime[0])! >= myTime
                                {
                                    array.add(arrMainTime[i])
                                }
                            }
                        }
                        else{
                            for i in 0..<arrMainTime.count{
                                let dic = arrMainTime[i] as! NSDictionary
                                //                                let Fromtime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)".split(separator:  ":")
                                let Totime = "\(dic.value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)".split(separator:  ":")
                                print("is half day drop-off delivery option :- \(Int(Totime[0])!) >= \(myTime)")
                                if Int(Totime[0])! >= myTime
                                {
                                    array.add(arrMainTime[i])
                                }
                            }
                            
                        }
                        
                        }
                        
                        if array.count > 0
                        {
                            let strEveningAnyTime = "\((arrMainTime.lastObject as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)"
                            var splitDate = strEveningAnyTime.split(separator: ":")
                            let intEveningAnyTime = Int(splitDate[0])!
                            let strTime = "\((array.firstObject as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)"
                            splitDate = strTime.split(separator: ":")
                            let intTime = Int(splitDate[0])!
                            
                            if intTime >= intEveningAnyTime
                            {
                                if "\((array.lastObject as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_slot_id)!)" != "4"
                                {
                                    array.add(arrMainTime.lastObject!)
                                }
                            }
                        }
                    }
                    arrDropoffTime = array
                }
                else{
                    var array : NSMutableArray = NSMutableArray()
                    let weekDays = getDateFrom(string: txtDropOffDate.text!, fromDateFormate: "dd/MM/yyyy", getDateFormate: "E")
                    print("check week day is holdy or not:- \(weekDays.lowercased()) == \(ResponceKey_get_global.halfdayOffName.lowercased())")
                    if weekDays.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased()
                    {
                        for i in 1..<arrMainTime.count{
                            print((arrMainTime[i] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_to)!)
                            array.add(arrMainTime[i])
                        }
                    }
                    else{
                        
                        array = NSMutableArray(array: arrMainTime)
                    }
                    arrDropoffTime = array
                }
                
                DropoffTimePickerView.reloadAllComponents()
                DropoffTimePickerView.selectRow(0, inComponent: 0, animated: false)
            }
        }
        intDateCalenderID = 0
        viewCalendarParent.isHidden = true
    }
    
    /*
     Function Name :- Calender
     Function Parameters :- (intVisibaleDays:Int = 6,isDropoffDate : Bool = false)
     Function Description :- It's initlize a VACalender.
     */
    private func Calender(intVisibaleDays:Int = 6,isDropoffDate : Bool = false)
    {
        
        if calendarView != nil
        {
            calendarView?.reloadInputViews()
            calendarView = nil
        }
        
        let calendar = VACalendar(calendar: defaultCalendar)
        let frame = CGRect(x: 0, y: 0, width: viewCalendarDays.frame.width, height: viewCalendarDays.frame.height)
        calendarView = VACalendarView(frame: frame, calendar: calendar)
        calendarView!.backgroundColor = .clear
        view.backgroundColor = .clear
        calendarView!.showDaysOut = true
        calendarView!.selectionStyle = .single
        calendarView!.monthDelegate = viewCalendarMonth
        calendarView!.dayViewAppearanceDelegate = self
        calendarView!.calendarDelegate = self
        calendarView!.scrollDirection = .horizontal
       
        var calendarDate : [Date] = [Date]()
        if isDropoffDate == true
        {
            calendarDate = getCalendarDate(intVisibaleDays : intVisibaleDays,isDropoffDate : isDropoffDate)
        }
        else{
            if arrPickupDate.count > 0
            {
                calendarDate = arrPickupDate
            }
            else{
                calendarDate = getCalendarDate(intVisibaleDays : intVisibaleDays,isDropoffDate : isDropoffDate)
                arrPickupDate = calendarDate
            }
        }
        calendarView!.setAvailableDates(DaysAvailability.some(calendarDate))
        calendarView!.setup()
        viewCalendarDays.addSubview(calendarView!)
        scrollMonths(date:calendarDate[0], calendarView: calendarView!)
        
    }
    
    /*
     Function Name :- getCalendarDate
     Function Parameters :- (intVisibaleDays:Int,isDropoffDate : Bool = false) return date array
     Function Description :- It's return a visibal date array
     */
    func getCalendarDate(intVisibaleDays:Int,isDropoffDate : Bool = false) ->[Date]
    {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .medium
        dateformatter.amSymbol = "AM"
        dateformatter.pmSymbol = "PM"
        dateformatter.dateFormat = "E"
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformatter1.locale = NSLocale.current
        dateformatter1.timeZone = TimeZone.current
        
        var days = [Date]()
        var localintVisibaleDays = Int()
        for i in 0..<intVisibaleDays {
            var max_date = Date()
            if i == 0
            {
                if isDropoffDate == true{
                    let strSelectedToTime = "\((arrPickupTime[intPickupTimeIndex] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)"
                    let pickupTimeID = "\((arrPickupTime[intPickupTimeIndex] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_slot_id)!)"
                    var isoDate = String()
                    if pickupTimeID == "4"
                    {
                        isoDate  = "\(txtPickUpDate.text!) \("\((arrPickupTime[intPickupTimeIndex] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_from)!)")"
                    }
                    else{
                        isoDate  = "\(txtPickUpDate.text!) \(strSelectedToTime)"
                    }
                    
                    // Start ---converty in string to date
                    let date1 : Date = getDateFromString(string: isoDate, fromDateFormate: "dd/MM/yyyy HH:mm:ss")
                    print(date1)
                    //end ---
                    //start ---- add hours
                    var newdate = Date()
                    for i in 0..<deliveryOptionHours
                    {
                        if i == 0{
                            max_date = defaultCalendar.date(byAdding: .hour, value: 1, to: date1)!
                            max_date = checkHoliday(myDate: max_date)
                            newdate = max_date
                            print(max_date)
                        }
                        else{
                            if max_date != newdate{
                                max_date = defaultCalendar.date(byAdding: .hour, value: 1, to: max_date)!
                                max_date = checkHoliday(myDate: max_date)
                                newdate = max_date
                                print(max_date)
                            }
                            else{
                                max_date = defaultCalendar.date(byAdding: .hour, value: 1, to: max_date)!
                                print(max_date)
                            }
                        }
                    }
                    
                    print(max_date)
                    let tempDate = dateformatter1.string(from: date1)
                    print(tempDate)
                    // end
                    let tempWeek = getStringDateFromDATEObject(date1, getDateFormate: "E")
                                        
                    if tempWeek.lowercased() == ResponceKey_get_global.beforDayOf_FullDayOffName.lowercased()
                    {
                        if deliveryOptionHours < 24{
                            let tempWeek =  getStringDateFromDATEObject(max_date, getDateFormate: "E")
                            if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased(){
                                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                            }
                            else if tempWeek.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased(){
                                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.halfDayHours, to: max_date)!
                            }
                            max_date = graterNight(max_date)
                        }
                        else{
                            max_date = defaultCalendar.date(byAdding: .hour, value: 24, to: max_date)!
                        }
                    }
                    else{
                        max_date = graterNight(max_date)
                    }
                    print(max_date)
                }
                else{
                    let tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
                    if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased(){
                        max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                    }else{
                        let time : Int = Int(getDateFrom(string: dateformatter1.string(from: max_date), getDateFormate: "HH"))!
                        if time >= Int(ResponceKey_get_global.cut_off_time)!
                        {
                            max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                            let tempWeek = dateformatter.string(from: max_date)
                            if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased(){
                                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                            }
                        }
                    }
                }
            }
            else{
                max_date = days[i-1]
                if isDropoffDate == true{
                    max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                    print(max_date)
                    let tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
                    print(tempWeek)
                    if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased()
                    {
                        max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                    }
                }
                else{
                    max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                    let tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
                    if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased()
                    {
                        max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                        localintVisibaleDays += 1
                    }
                }
            }
            
            max_date = checkHoliday(myDate: max_date)
            
            days.append(dateformatter1.date(from: dateformatter1.string(from: max_date))!)
        }
        print(days)
        
        if isDropoffDate == true
        {
            arrDropoffDate = days
        }
        if isDropoffDate == false{
            localintVisibaleDays = (intVisibaleDays - localintVisibaleDays)
            days = Array(days[0..<localintVisibaleDays])
            arrPickupDate = days
        }
        dateFirstOnCalender = days.first!
        dateLastOnCalender = days.last!
        selectedDate = days[0]
        
        return days
    }
    
    /*
     Function Name :- scrollMonths
     Function Parameters :- (date:Date,calendarView:VACalendarView)
     Function Description :- scroll a VACalendarView from the give date.
     */
    func scrollMonths(date:Date,calendarView:VACalendarView)
    {
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "MM"
        dateformatter1.timeZone = TimeZone.current//TimeZone(secondsFromGMT: 0)
        let max_date = Date()
        let dateOne : Int = Int(dateformatter1.string(from: date))!
        let dateCurrent : Int = Int(dateformatter1.string(from: max_date))!
        let count : Int = dateOne - dateCurrent
        if count >= 0
        {
            for _ in 0..<count
            {
                calendarView.nextMonth()
            }
        }
        else{
            calendarView.nextMonth()
        }
    }
    
    /*
     Function Name :- graterNight
     Function Parameters :- (myDate : Date)
     Function Description :- Check This date is Holday or not.
     */
    func checkHoliday(myDate : Date = Date()) -> Date
    {
        var max_date : Date = myDate
        let splitMyDate = getStringDateFromDATEObject(max_date, getDateFormate: "yyyy-MM-dd")
        let arrHolidayist : [String] = ResponceKey_get_global.holiday_dates
        print(arrHolidayist)
        for i in 0..<arrHolidayist.count
        {
            let holidayDate = getDateFrom(string: "\(arrHolidayist[i])", fromDateFormate: "yyyy-MM-dd", getDateFormate: "yyyy-MM-dd")
            if splitMyDate == holidayDate
            {
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                let tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
                if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased()
                {
                    max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
                }
            }
        }
        return max_date
    }
    
    /*
     Function Name :- graterNight
     Function Parameters :- (myDate : Date)
     Function Description :- check a date is late night or not if it's a late night then add hours.
     */
    func graterNight(_ myDate : Date = Date()) -> Date
    {
        var tempWeek = getStringDateFromDATEObject(myDate, getDateFormate: "E")
        var myTime : Int = Int(getStringDateFromDATEObject(myDate, getDateFormate: "HH"))!
        
        var max_date = myDate
        
        if myTime > 22
        {
            max_date = defaultCalendar.date(byAdding: .hour, value: 6, to: max_date)!
            tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
            if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased(){
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
            }
            else if tempWeek.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased(){
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.halfDayHours, to: max_date)!
            }
            
        }
        else if myTime <= 4
        {
            max_date = defaultCalendar.date(byAdding: .hour, value: 6, to: max_date)!
            tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
            if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased(){
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
            }
            else if tempWeek.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased(){
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.halfDayHours, to: max_date)!
            }
            
        }
        else{
            tempWeek = getStringDateFromDATEObject(max_date, getDateFormate: "E")
            if tempWeek.lowercased() == ResponceKey_get_global.fullDayOffName.lowercased(){
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.fullDayHours, to: max_date)!
            }
            else if tempWeek.lowercased() == ResponceKey_get_global.halfdayOffName.lowercased(){
                max_date = defaultCalendar.date(byAdding: .hour, value: ResponceKey_get_global.halfDayHours, to: max_date)!
            }
            
            myTime = Int(getStringDateFromDATEObject(max_date, getDateFormate: "HH"))!
            if myTime > 22
            {
               max_date = graterNight(max_date)
            }
        }
        
        return max_date
    }
}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension CleanMyClothesThreedVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == txtCreditCardNo
        {
            textField.resignFirstResponder()
        }
        else if textField == txtExpiDate
        {
            textField.resignFirstResponder()
        }
        else if textField == txtCardHolderName
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtCreditCardNo
        {
            if string != ""
            {
                let maxLength = 19
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                if newString.length == 5
                {
                    txtCreditCardNo.text?.append(" ")
                }
                else if newString.length == 10
                {
                    txtCreditCardNo.text?.append(" ")
                }
                else if newString.length == 15
                {
                    txtCreditCardNo.text?.append(" ")
                }
                
                if newString.length > maxLength
                {
                    txtCreditCardNo.resignFirstResponder()
                }
                if newString.length <= maxLength
                {
                    let myCharSet=CharacterSet(charactersIn:"0123456789 ")
                    let output: String = string.trimmingCharacters(in: myCharSet.inverted)
                    let isValid: Bool = (string == output)
                    print("\(isValid)")
                    
                    return isValid
                }
                return newString.length <= maxLength

            }
        }
        else if textField == txtCVVNo
        {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length <= maxLength
            {
                let myCharSet=CharacterSet(charactersIn:"0123456789")
                let output: String = string.trimmingCharacters(in: myCharSet.inverted)
                let isValid: Bool = (string == output)
                print("\(isValid)")
                
                return isValid
            }
            return newString.length <= maxLength
        }
        return true
    }
}
/*
 Extension Description :- Delegate method for picker view.
 */
extension CleanMyClothesThreedVC : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if pickerView == PickupTimePickerView ||  pickerView == DropoffTimePickerView
        {
            return 1
        }
        else{
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == PickupTimePickerView
        {
            return arrPickupTime.count
        }
        else if pickerView == DropoffTimePickerView
        {
            return arrDropoffTime.count
        }
        else{
            if component == 0
            {
                return arrExpMonthPicker.count
            }
            else
            {
                return arrExpYearPicker.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == PickupTimePickerView
        {
            return ((arrPickupTime[row] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_title) as! String)
        }
        else if pickerView == DropoffTimePickerView
        {
            return ((arrDropoffTime[row] as! NSDictionary).value(forKey: ResponceKey_get_time_slot.dataValues.time_title) as! String)
        }
        else{
            if component == 0
            {
                return (arrExpMonthPicker[row] as! String)
            }
            else{
                return (arrExpYearPicker[row] as! String)
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == PickupTimePickerView
        {
            intPickupTimeIndex = row
        }
        else if pickerView == DropoffTimePickerView{
            intDropoffTimeIndex = row
        }
        else if pickerView == ExpDatePickerView
        {
            if component == 0
            {
                intExpMonthIndex = row
            }
            else
            {
                intExpYearIndex = row
            }
        }
    }
}
/*
 Extension Description :- Delegate method for table view.
 */
extension CleanMyClothesThreedVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPaymentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
          let cell = tableViewObj.dequeueReusableCell(withIdentifier: "ExtraServiceCell") as! ExtraServiceCell
        cell.selectionStyle = .none
        
        cell.reloadPaymentData(dictionary: arrPaymentList[indexPath.row] as! NSDictionary)
        cell.btnCheckUnCkeck.tag = indexPath.row
        cell.btnCheckUnCkeck.addTarget(self, action: #selector(btnCheckUncheckClick(ExtraServiceCell:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func btnCheckUncheckClick(ExtraServiceCell sender:UIButton)
    {
        for i in 0..<arrPaymentList.count
        {
            let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrPaymentList[i] as! NSDictionary)
            dic.setValue(false, forKey: isSelected_Key)
            arrPaymentList.replaceObject(at: i, with: dic)
        }
        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrPaymentList[sender.tag] as! NSDictionary)
        dic.setValue(true, forKey: isSelected_Key)
        arrPaymentList.replaceObject(at: sender.tag, with: dic)
        tableViewObj.reloadData()
        setCardViewDisplay()
    }
}

/*
 Extension Description :- Delegate method for VAMonth view.
 */
extension CleanMyClothesThreedVC: VAMonthHeaderViewDelegate
{
    
    func didTapNextMonth() {
    }
    
    func didTapPreviousMonth() {
    }
    
}
/*
 Extension Description :- Delegate method for VADay view.
 */
extension CleanMyClothesThreedVC: VADayViewAppearanceDelegate
{
    
    func font(for state: VADayState) -> UIFont {
        return UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!
    }
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return COLOR.Blue
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func backgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 249 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1.0)
        default:
            return .white
        }
    }
    
    func shape() -> VADayShape {
        return .square
    }
    
    func borderWidth(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return 1 / UIScreen.main.scale
        }
    }
    
    func borderColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return COLOR.Blue
        default:
            return UIColor(red: 221 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1.0)
        }
    }
}
/*
 Extension Description :- Delegate method for VACalender view.
 */
extension CleanMyClothesThreedVC: VACalendarViewDelegate
{
    
    func selectedDate(_ date: Date) {
        selectedDate = date
        btnCalendarCancelAndDoneClick(btnCalendarDone)
    }
    
}

//MARK:- API Response
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension CleanMyClothesThreedVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        if reqTask == reqGetTimeSlot
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrMainTime = NSArray(array: resKeyData)
                        arrGlobalTimeSlot = NSArray(array: arrMainTime)
                        setDataOfViewController()
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
        else if reqTask == reqGetAllCreditCard
        {
            Application_Delegate.showSpinnerView(isShow: false)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrCardList = NSArray(array: resKeyData)
                        if arrCardList.count > 0
                        {
                            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_credit_card.dataValues.is_default) CONTAINS[C] '1'")
                            let array = NSMutableArray(array: resKeyData.filtered(using: predicateSearch) as NSArray)
                            if array.count > 0
                            {
                                txtSelectCard.text = "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no)!)"
                            }
                        }
                        viewContent.isHidden = false
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
        else if reqTask == reqCheckPromocode
        {
            Application_Delegate.showSpinnerView(isShow: false)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                         showMyAlertView(message: message) { (action) in }
                    }
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicCleanClothInfo.setValue(resKeyData.value(forKey: "promo_id"), forKey: RequestParameters_place_order.promocode_id)
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
        else if reqTask == reqPlaceOrder
        {
            Application_Delegate.showSpinnerView(isShow: false)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "SuccessOrderVC") as! SuccessOrderVC
                        controller.dicOrderDetails = resKeyData
                        Application_Delegate.navigationController.pushViewController(controller, animated: true)
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
        else if reqTask == get_paypal_Token
        {
            if let _ : String = responseData.value(forKey: "access_token") as? String{
                dicPaypalToken = responseData
                processGetPaypalLoginURL()
            }
            else
            {
                Application_Delegate.showSpinnerView(isShow: false)
            }
        }
    }
}
