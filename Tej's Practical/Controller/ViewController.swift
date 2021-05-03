//
//  ViewController.swift
//  Tej's Practical
//
//  Created by PCS29 on 11/04/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAddEmp: BottomButton!
    @IBOutlet weak var btnViewEmp: BottomButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnBechlor: UIButton!
    @IBOutlet weak var btnMPhil: UIButton!
    @IBOutlet weak var btnMaster: UIButton!
    @IBOutlet weak var btnPhd: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpDesignation: UITextField!
    @IBOutlet weak var txtEmpPhone: UITextField!
    @IBOutlet weak var txtEmpEmail: UITextField!
    @IBOutlet weak var txtEmpCity: UITextField!
    
    private var arrEmployee = Array<Any>()
    private var arrSelectedDegree : [String] = []
    private var strGender : String = ""
    private var strDegree : String = ""
    
    var dictObj: NSManagedObject!
    var isEdit:Bool = false
    
    private let City = ["Ahmedabad", "Baroda", "Surat", "Gandhinagar"]
    private var picker = UIPickerView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func prepareView(){
        
        if (self.isEdit == true)
        {
            self.title = "Employee Details"
            self.btnAddEmp.isHidden = true
            self.btnViewEmp.isHidden = true
            self.navigationItem.setHidesBackButton(false, animated: true)
            self.setEmpData()
        }else
        {
            self.title = "Add Employee"
            self.btnAddEmp.isHidden = false
            self.btnViewEmp.isHidden = false
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.btnAddEmp.setEnable()
        }
        
        btnBechlor.tag = 0
        btnMaster.tag = 1
        btnMPhil.tag = 2
        btnPhd.tag = 3
        
        self.picker.delegate = self
        self.picker.dataSource = self
        txtEmpCity.inputView = self.picker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        txtEmpCity.inputAccessoryView = toolbar
    }
    
    @objc private func donedatePicker() {
        self.txtEmpCity.text = self.City[0]
        self.txtEmpCity.endEditing(true)
    }
    
    @objc private func cancelDatePicker() {
        self.txtEmpCity.endEditing(true)
    }
    
    private func setEmpData(){
        self.txtEmpName.text = dictObj.value(forKey: "name") as? String ?? ""
        self.txtEmpDesignation.text = dictObj.value(forKey: "designation") as? String ?? ""
        self.txtEmpPhone.text = dictObj.value(forKey: "phone") as? String ?? ""
        self.txtEmpEmail.text = dictObj.value(forKey: "email") as? String ?? ""
        self.txtEmpCity.text = dictObj.value(forKey: "city") as? String ?? ""
        
        self.strGender = dictObj.value(forKey: "gender") as? String ?? "" == "Male" ? "Male" : "Female"
        if(self.strGender == "Male"){
            self.btnMale.isSelected = true
        }else{
            self.btnFemale.isSelected = true
        }
        
        self.strDegree = dictObj.value(forKey: "education") as? String ?? ""
        self.arrSelectedDegree = self.strDegree.components(separatedBy:",")
        for degree in self.arrSelectedDegree{
            switch degree {
            case "Bechlor":
                self.btnBechlor.isSelected = true
            case "Master":
                self.btnMaster.isSelected = true
            case "M.Phil":
                self.btnMPhil.isSelected = true
            case "PhD":
                self.btnPhd.isSelected = true
                
            default:
                print("Unknown Degree")
                return
            }
        }
        
        self.btnSubmit.setTitle("Update", for: .normal)
    }
    
    //MARK: - Btn Actions -
    @IBAction func btnAddEmpAction(_ sender: Any) {
        self.btnAddEmp.setEnable()
        self.btnViewEmp.setDisable()
    }
    
    @IBAction func btnViewEmpAction(_ sender: Any) {
        self.btnAddEmp.setDisable()
        self.btnViewEmp.setEnable()
        self.goToEmpList()
    }
    
    @IBAction func btnMaleAction(_ sender: Any) {
        if(self.btnMale.isSelected == true){
            self.btnMale.isSelected = false
        }else{
            self.btnMale.isSelected = true
            self.btnFemale.isSelected = false
        }
    }
    
    @IBAction func btnFemaleAction(_ sender: Any) {
        if(self.btnFemale.isSelected == true){
            self.btnFemale.isSelected = false
        }else{
            self.btnFemale.isSelected = true
            self.btnMale.isSelected = false
        }
    }
    
    @IBAction func btnCheckboxAction(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 0:
            if(self.btnBechlor.isSelected == true){
                self.btnBechlor.isSelected = false
                if self.arrSelectedDegree.contains("Bechlor"){
                    self.arrSelectedDegree.removeFirstEqualItem("Bechlor")
                }
            }else{
                self.btnBechlor.isSelected = true
                self.arrSelectedDegree.append("Bechlor")
            }
        case 1:
            if(self.btnMaster.isSelected == true){
                self.btnMaster.isSelected = false
                if self.arrSelectedDegree.contains("Master"){
                    self.arrSelectedDegree.removeFirstEqualItem("Master")
                }
            }else{
                self.btnMaster.isSelected = true
                self.arrSelectedDegree.append("Master")
            }
        case 2:
            if(self.btnMPhil.isSelected == true){
                self.btnMPhil.isSelected = false
                if self.arrSelectedDegree.contains("M.Phil"){
                    self.arrSelectedDegree.removeFirstEqualItem("M.Phil")
                }
            }else{
                self.btnMPhil.isSelected = true
                self.arrSelectedDegree.append("M.Phil")
            }
        case 3:
            if(self.btnPhd.isSelected == true){
                self.btnPhd.isSelected = false
                if self.arrSelectedDegree.contains("PhD"){
                    self.arrSelectedDegree.removeFirstEqualItem("PhD")
                }
            }else{
                self.btnPhd.isSelected = true
                self.arrSelectedDegree.append("PhD")
            }
        default:
            print("Unknown Degree")
            return
        }
    }
    
    
    @IBAction func btnStartAction(_ sender: Any) {
        self.ValidateData()
    }
    
    //MARK: - Extra Method -
    func DisplayAlert(Title:String , Msg:String){
        
        let alert = UIAlertController(title: Title, message: Msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
        
    }
    
    private func goToEmpList(){
        if let EmpListVC = self.storyboard!.instantiateViewController(withIdentifier: "EmployeeListVC") as? EmployeeListVC{
            self.navigationController?.pushViewController(EmpListVC, animated: false)
        }
    }
    
    private func ValidateData(){
        
        let arrTextFields = [self.txtEmpName,self.txtEmpDesignation,self.txtEmpPhone,self.txtEmpEmail,self.txtEmpCity]
        for txt in arrTextFields
        {
            if (txt?.text == "")
            {
                self.DisplayAlert(Title: "Validation Error", Msg: "Please Enter All Fields.")
                return
            }
        }
        
        if(self.txtEmpName.text?.containsOnlyLettersAndWhitespace() == false){
            self.DisplayAlert(Title: "Validation Error", Msg: "Please Enter Valid Name.")
            return
        }
        
        if(self.txtEmpDesignation.text?.containsOnlyLettersAndWhitespace() == false){
            self.DisplayAlert(Title: "Validation Error", Msg: "Please Enter Valid Designation.")
            return
        }
        
        else if(self.txtEmpPhone.text?.isValidPhoneNumber == false){
            self.DisplayAlert(Title: "Validation Error", Msg: "Please Enter Valid Mobile Number.")
            return
        }
        
        if(self.txtEmpEmail.text?.isValidEmail == false){
            self.DisplayAlert(Title: "Validation Error", Msg: "Please Enter Valid Email.")
            return
        }
        
        else if(self.btnMale.isSelected == false && self.btnFemale.isSelected == false){
            self.DisplayAlert(Title: "Validation Error", Msg: "Please Select Gender.")
            return
        }
        
        else if(self.arrSelectedDegree.count <= 0){
            self.DisplayAlert(Title: "Validation Error", Msg: "Please Select Degree.")
            return
        }
        
        else{
            
            self.strDegree = self.arrSelectedDegree.joined(separator:",")
            self.strGender = self.btnMale.isSelected == true ? "Male" : "Female"
            
            self.createData()
        }
    }
    
    //MARK: - Coredata Methods
    func createData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "UserTable", in: managedContext)!
        
        var user = NSManagedObject()
        if(isEdit == true)
        {
            user = self.dictObj
        }
        else
        {
            user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        }
        
        user.setValue(self.txtEmpName.text, forKeyPath: "name")
        user.setValue(self.txtEmpDesignation.text, forKey: "designation")
        user.setValue(self.txtEmpPhone.text, forKey: "phone")
        user.setValue(self.txtEmpEmail.text, forKey: "email")
        user.setValue(self.txtEmpCity.text, forKey: "city")
        user.setValue(self.strGender, forKey: "gender")
        user.setValue(self.strDegree, forKey: "education")
        
        do {
            try managedContext.save()
            
            let alertController = UIAlertController(title: "Success", message:self.isEdit == true ? "Employee Updated Successfully." : "Employee Created Successfully.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.goToEmpList()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension ViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtEmpCity{
            return false
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmpCity {
            self.picker.reloadComponent(0)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtEmpCity {
            txtEmpCity.text = City[self.picker.selectedRow(inComponent: 0)]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return City.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return City[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtEmpCity.text = City[row]
    }
    
}

extension UIView {

    func addConstaintsToSuperview(leadingOffset: CGFloat, topOffset: CGFloat) {

        guard superview != nil else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        leadingAnchor.constraint(equalTo: superview!.leadingAnchor,
                                 constant: leadingOffset).isActive = true

        topAnchor.constraint(equalTo: superview!.topAnchor,
                             constant: topOffset).isActive = true
    }

    func addConstaints(height: CGFloat, width: CGFloat) {

        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

}
