//
//  ProfileViewController.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 06/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//



class PersonalProfile:NSObject
{
    var  idInt : Int = 0
    var  name : String = ""
    var email: String = ""
    var mobile_number: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var dob : String = ""
    var address: String = ""
    var website: String = ""
    var photo: String = ""
    var gcm_token: String = ""
    var last_online_time: String = ""
    var  rating_average  = [AnyObject]()
    var  review_count = [AnyObject]()
}


import UIKit
import MobileCoreServices

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var selectedImages:UIImage?
    var personalProfile:PersonalProfile = PersonalProfile()
    @IBOutlet weak var reviewButton:UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView:UIImageView!
    
    @IBOutlet weak var nameLabel:UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imageView.makeImageRounded()
        getProfileData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    

    
}

extension ProfileViewController
{
    @IBAction func goToReviewScreen()
    {
        let rateANdReviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RateANdReviewViewController") as? RateANdReviewViewController
        self.navigationController!.pushViewController(rateANdReviewViewController!, animated: true)
    }
    
}

extension ProfileViewController
{
    
    func setProfileImgeForURL(urlString:String)
    {
        self.imageView.setImageWithURL(NSURL(string:urlString ))
    }
    
    func  getProfileData()
    {
        self.view.showSpinner()
        
        DataSessionManger.sharedInstance.getProfileData({ (response, personalProfile) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.view.removeSpinner()
                
                self.personalProfile = personalProfile
                self.nameLabel.text  = personalProfile.name
                self.tableView.reloadData()
                self.setProfileImgeForURL(personalProfile.photo)
                
                
            });
            
        }) { (error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.view.removeSpinner()
                
                
            });
            
        }
    }
}

extension ProfileViewController
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("EditProfileTableViewCell", forIndexPath: indexPath) as! EditProfileTableViewCell
        
        if indexPath.row == 0
        {
            cell.titleLabel.text = "Address"
            cell.dataLabel.text  = personalProfile.address
            
        }
        
        if indexPath.row == 1
        {
            cell.titleLabel.text = "Email"
            cell.dataLabel.text  = personalProfile.email
        }
        
        if indexPath.row == 2
        {
            cell.titleLabel.text = "Mobile"
            cell.dataLabel.text  = personalProfile.mobile_number
        }
        if indexPath.row == 3
        {
            cell.titleLabel.text = "Website"
            cell.dataLabel.text  = personalProfile.website
        }
        
        return cell
    }
}

extension ProfileViewController
{
    @IBAction func cameraButtonClicked(sender:UIButton)
    {

        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true,
                                   completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == "public.image"
        {
            // For Image
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedImages = selectedImage
            picker.dismissViewControllerAnimated(true, completion: nil)
            // self.delegate?.imageFileSelected(selectedImage)
            imageView.image = selectedImages
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
}


public extension UIView
{
    /// Extension to make a view rounded // need to move in a different file
    func makeImageRounded()
    {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
}
