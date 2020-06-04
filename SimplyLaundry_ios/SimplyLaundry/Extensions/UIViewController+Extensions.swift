import UIKit

extension UIViewController {
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
}
extension UIViewController
{
    func setTimePicker(pickerView:UIPickerView, textFiled:UITextField, pickerDoneAction: Selector, pickerCancelAction: Selector )
    {
        pickerView.delegate = (self as! UIPickerViewDelegate)
        pickerView.dataSource = (self as! UIPickerViewDataSource)
        pickerView.reloadAllComponents()
        
        let toolBarStartDate = UIToolbar()
        toolBarStartDate.barStyle = UIBarStyle.default
        toolBarStartDate.isTranslucent = true
        toolBarStartDate.tintColor = COLOR.Balck
        toolBarStartDate.sizeToFit()
        let doneStartTime = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: pickerDoneAction)
        doneStartTime.tag = pickerView.tag
        let spaceStartTime  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelStartTime = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: pickerCancelAction)
        cancelStartTime.tag = pickerView.tag
        toolBarStartDate.setItems([cancelStartTime, spaceStartTime, doneStartTime], animated: false)
        toolBarStartDate.isUserInteractionEnabled = true
        
        textFiled.inputView = pickerView
        textFiled.inputAccessoryView = toolBarStartDate
    }
    
    func goBackToViewController(ViewController : UIViewController.Type,isanimated : Bool = true)
    {
        for controller in self.navigationController!.viewControllers as Array
        {
            if controller.isKind(of: ViewController)
            {
                self.navigationController!.popToViewController(controller, animated: isanimated)
                break
            }
        }        
    }
    
    func AouthLogoutFromApplication()
    {
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self as! webServiceDataProviderDelegate).sendRequestToServer_POST(reqTask: reqLogout, dictParameter: parameters as NSDictionary,isHeader: false)
    }
}

