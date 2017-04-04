//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Bhagat Singh on 4/4/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var storePicker : UIPickerView!
    @IBOutlet weak var titleField : UITextField!
    @IBOutlet weak var priceField : UITextField!
    @IBOutlet weak var detailsField : UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit : Item?
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        let store1 = Store(context: context)
//        store1.name = "Target"
//        let store2 = Store(context: context)
//        store2.name = "Macy's"
//        let store3 = Store(context: context)
//        store3.name = "Amazon"
//        let store4 = Store(context: context)
//        store4.name = "K Mart"
//        let store5 = Store(context: context)
//        store5.name = "Fresh Foods"
//        let store6 = Store(context: context)
//        store6.name = "Dollar Store"
        
        //ad.saveContext()
        getStores()
        
        if itemToEdit != nil{
            loadItemData()
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when selected
        
    }
    
    func getStores(){
        let fetchRequest : NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch{
            let error = error as NSError
            print("\(error)")
        }
        
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        var  item : Item!
        
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        
        
        if itemToEdit == nil{
            item = Item(context: context)
        }else{
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text{
            item.title = title
        }
        
        if let price = priceField.text{
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text{
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    func loadItemData(){
        if let item = itemToEdit{
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
        
        
        if let store = item.toStore{
            var index = 0
            repeat{
                
                let s = stores[index]
                if s.name == store.name{
                    storePicker.selectRow(index, inComponent: 0, animated: true)
                }
                index = index + 1
                
                }while(index < stores.count)
            }
                    
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        
        if itemToEdit != nil{
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageSelectButtonPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    

}
