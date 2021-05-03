//
//  EmployeeListVC.swift
//  Tej's Practical
//
//  Created by PCS29 on 11/04/21.
//

import UIKit
import CoreData

class EmployeeListVC: UIViewController {
    
    @IBOutlet weak var btnAddEmp: BottomButton!
    @IBOutlet weak var btnViewEmp: BottomButton!
    @IBOutlet weak private var tblVwEmpDetails: UITableView!
    
    var arrEmpData = Array<Any>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func prepareView(){
        self.btnViewEmp.setEnable()
        setUpTable()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "View Employee"
    }
    
    //MARK: - button action methods
    @IBAction func btnAddEmpAction(_ sender: Any) {
        self.btnAddEmp.setEnable()
        self.btnViewEmp.setDisable()
        self.goToAddEmp()
    }
    
    @IBAction func btnViewEmpAction(_ sender: Any) {
        self.btnAddEmp.setDisable()
        self.btnViewEmp.setEnable()
    }
    
    //MARK: - extra Methods
    private func goToAddEmp(){
        if let EmpListVC = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
            self.navigationController?.pushViewController(EmpListVC, animated: false)
        }
    }
    
    func setUpTable()  {
        self.tblVwEmpDetails.isHidden = true
        self.tblVwEmpDetails.register(UINib(nibName: "EmpListCell", bundle: nil), forCellReuseIdentifier: "EmpListCell")
        self.tblVwEmpDetails.delegate = self
        self.tblVwEmpDetails.dataSource = self
        self.tblVwEmpDetails.separatorStyle = .none
        self.tblVwEmpDetails.isScrollEnabled = true
        self.retrieveData(Delete: false, indexpath: 0)
    }
    
    //MARK: - CoreData Methods
    func retrieveData(Delete:Bool , indexpath:Int) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
        
        if (Delete == true)
        {
            do
            {
                let test = try managedContext.fetch(fetchRequest)
                
                let objectToDelete = test[indexpath] as! NSManagedObject
                managedContext.delete(objectToDelete)
                
                do{
                    try managedContext.save()
                    self.retrieveData(Delete: false, indexpath: 0)
                }
                catch
                {
                    print(error)
                }
            }
            catch
            {
                print(error)
            }
        }
        
        do {
            self.arrEmpData = try managedContext.fetch(fetchRequest)
            self.tblVwEmpDetails.isHidden = false
            self.tblVwEmpDetails.reloadData()
        } catch {
            print("Failed")
        }
    }
}


extension EmployeeListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmpData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpListCell", for: indexPath) as! EmpListCell
        
        let dictData = self.arrEmpData[indexPath.row] as? NSManagedObject
        cell.setData(dictData: dictData!)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictData = self.arrEmpData[indexPath.row] as? NSManagedObject
        if let EmployeeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
            EmployeeDetailVC.isEdit  = true
            EmployeeDetailVC.dictObj = dictData
            self.navigationController?.pushViewController(EmployeeDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.retrieveData(Delete: true, indexpath: indexPath.row)
        }
    }
}
