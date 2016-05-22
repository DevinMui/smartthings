import UIKit
import Alamofire

class random: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var currentImage: UIImageView!
    
    let uid = NSUserDefaults.standardUserDefaults().stringForKey("id")
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    var imagurl = NSURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set this controller as the camera delegate
        takePic()
        imagePicker.delegate = self
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retry(sender: UIButton) {
        takePic()
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    func takePic() {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }

    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        
        
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            //let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            //print(imageURL)//imagurl = imageURL
            
            let selectorToCall = Selector("imageWasSavedSuccessfully:didFinishSavingWithError:context:")
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, selectorToCall, nil)
        }
        imagePicker.dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user saves an image
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    func imageWasSavedSuccessfully(image: UIImage, didFinishSavingWithError error: NSError!, context: UnsafeMutablePointer<()>){
        print("Image saved")
        if let theError = error {
            print("An error happened while saving the image = \(theError)")
        } else {
            print("Displaying")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.currentImage.image = image
                
                let imageData:NSData = UIImagePNGRepresentation(image)!
                let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
                //Now use image to create into NSData format
                let headers = [
                    "app_id":  "0a97c88a",
                    "app_key": "60138ef18484a5028194e4710344f9de",
                    "Content-Type": "application/json"
                ]
                let params : [String : String] = [
                    "image": strBase64,
                    "selector":"FACE",
                    "subject_id": "\(id)",
                    "gallery_name": "idk",
                    "symmetricFill":"true",
                    "minHeadScale":".125",
                    "multiple_faces":"false"
                ]
                /*Alamofire.request(.POST, " https://api.kairos.com/enroll", parameters: params, headers: headers) .responseJSON { response in
                    print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    
                    
                    if (response.result.value == nil) {
                        
                        
                    } else if (response.result.value != nil) {
                        
                        
                    }
                }*/

                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}