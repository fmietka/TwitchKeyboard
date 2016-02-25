import UIKit

class KeyboardViewController: UIInputViewController, UIScrollViewDelegate {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    var deleteButton: UIButton!
    var scrollView: UIScrollView!
    var containerView: UIView!
    var buttonRow1: CGFloat!
    var buttonRow2: CGFloat!
    var buttonRow3: CGFloat!
    var buttonRow4: CGFloat!
    var totalEmotes = 199
    var totalRows = 4
    var amountOfSpace: CGFloat!
    var portrait = true
    var button: UIButton!
    let folders = ["faces", "toon", "turbo", "betterTwitchTv", "watchmeblink1",
        "summit1g", "sodapoppin", "reynad", "rekful", "lirik", "forsen"]
    var totalXValue = CGFloat(0.0)
    var lastFaceEmoteX = CGFloat(0.0)
    var lastTurboEmoteX = CGFloat(0.0)
    var lastToonEmoteX = CGFloat(0.0)
    var lastTVEmoteX = CGFloat(0.0)
    var firstSubEmoteX = CGFloat(0.0)
    var firstNavButton: UIButton!
    var secondNavButton: UIButton!
    var thirdNavButton: UIButton!
    var fourthNavButton: UIButton!
    var fifthNavButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView = UIScrollView()
        
        self.scrollView.delegate = self
        
        containerView = UIView()
        containerView.userInteractionEnabled = true
        
        scrollView.userInteractionEnabled = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(containerView)
        
        self.view.addSubview(scrollView)
        
        addNextKeyboardButton()
        addDeleteButton()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.x > lastFaceEmoteX && scrollView.contentOffset.x < lastToonEmoteX) {
            firstNavButton.backgroundColor = UIColor.clearColor()
            secondNavButton.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0)
            secondNavButton.layer.cornerRadius = 0.5 * 25
            thirdNavButton.backgroundColor = UIColor.clearColor()
            fourthNavButton.backgroundColor = UIColor.clearColor()
            fifthNavButton.backgroundColor = UIColor.clearColor()
        } else if (scrollView.contentOffset.x > lastToonEmoteX && scrollView.contentOffset.x < lastTurboEmoteX) {
            firstNavButton.backgroundColor = UIColor.clearColor()
            secondNavButton.backgroundColor = UIColor.clearColor()
            thirdNavButton.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0)
            thirdNavButton.layer.cornerRadius = 0.5 * 25
            fourthNavButton.backgroundColor = UIColor.clearColor()
            fifthNavButton.backgroundColor = UIColor.clearColor()
        } else if (scrollView.contentOffset.x < lastFaceEmoteX) {
            firstNavButton.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0)
            firstNavButton.layer.cornerRadius = 0.5 * 25
            secondNavButton.backgroundColor = UIColor.clearColor()
            thirdNavButton.backgroundColor = UIColor.clearColor()
            fourthNavButton.backgroundColor = UIColor.clearColor()
            fifthNavButton.backgroundColor = UIColor.clearColor()
        } else if (scrollView.contentOffset.x > lastTurboEmoteX && scrollView.contentOffset.x < lastTVEmoteX) {
            firstNavButton.backgroundColor = UIColor.clearColor()
            secondNavButton.backgroundColor = UIColor.clearColor()
            thirdNavButton.backgroundColor = UIColor.clearColor()
            fourthNavButton.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0)
            fourthNavButton.layer.cornerRadius = 0.5 * 25
            fifthNavButton.backgroundColor = UIColor.clearColor()
        } else if (scrollView.contentOffset.x > lastTVEmoteX) {
            firstNavButton.backgroundColor = UIColor.clearColor()
            secondNavButton.backgroundColor = UIColor.clearColor()
            thirdNavButton.backgroundColor = UIColor.clearColor()
            fourthNavButton.backgroundColor = UIColor.clearColor()
            fifthNavButton.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0)
            fifthNavButton.layer.cornerRadius = 0.5 * 25
        }
    }
    
    func addNextKeyboardButton() {
        nextKeyboardButton = UIButton(type: .System)
        
        nextKeyboardButton.frame = CGRectMake(0, 0, 50, 50)
        
        nextKeyboardButton.setTitle(NSLocalizedString("ABC", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        
        nextKeyboardButton.sizeToFit()
        
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextKeyboardButton.titleLabel?.font = UIFont(name: "Arial", size: 15)
        
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: +10.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    func addDeleteButton() {
        deleteButton = UIButton(type: .System) as UIButton
        
        deleteButton.frame = CGRectMake(0, 0, 50, 50)
        
        deleteButton.setTitle("⌫", forState: .Normal)
        
        deleteButton.sizeToFit()
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.titleLabel?.font = UIFont(name: "Arial", size: 17)
        
        deleteButton.addTarget(self, action: "didTapDelete", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.deleteButton)
        
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: deleteButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: deleteButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func addFirstNavButton(xValue: CGFloat, title: String) {
        
        firstNavButton = UIButton(type: .System) as UIButton
        
        firstNavButton.frame = CGRectMake(0, 0, 50, 50)
        
        firstNavButton.setTitle(title
            , forState: .Normal)
        
        firstNavButton.sizeToFit()
        
        firstNavButton.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0)
        
        firstNavButton.layer.cornerRadius = 0.5 * 25
        
        firstNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstNavButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        
        firstNavButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        
        firstNavButton.addTarget(self, action: "didTapFace", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(firstNavButton)
        
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: firstNavButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: firstNavButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func addSecondNavButton(xValue: CGFloat, title: String) {
        
        secondNavButton = UIButton(type: .System) as UIButton
        
        secondNavButton.frame = CGRectMake(0, 0, 50, 50)
        
        secondNavButton.setTitle(title, forState: .Normal)
        
        secondNavButton.sizeToFit()
        
        secondNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        secondNavButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        
        secondNavButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        
        secondNavButton.addTarget(self, action: "didTapToon", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(secondNavButton)
        
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: secondNavButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: secondNavButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func addThirdNavButton(xValue: CGFloat, title: String) {
        
        thirdNavButton = UIButton(type: .System) as UIButton
        
        thirdNavButton.frame = CGRectMake(0, 0, 50, 50)
        
        thirdNavButton.setTitle(title, forState: .Normal)
        
        thirdNavButton.sizeToFit()
        
        thirdNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        thirdNavButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        
        thirdNavButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        
        thirdNavButton.addTarget(self, action: "didTapTurbo", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(thirdNavButton)
        
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: thirdNavButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: thirdNavButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func addFourthNavButton(xValue: CGFloat, title: String) {
        
        fourthNavButton = UIButton(type: .System) as UIButton
        
        fourthNavButton.frame = CGRectMake(0, 0, 50, 50)
        
        fourthNavButton.setTitle(title, forState: .Normal)
        
        fourthNavButton.sizeToFit()
        
        fourthNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        fourthNavButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        
        fourthNavButton.titleLabel?.font = UIFont(name: "Arial", size: 17)
        
        fourthNavButton.addTarget(self, action: "didTapTV", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(fourthNavButton)
        
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: fourthNavButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: fourthNavButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -7.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func addFifthNavButton(xValue: CGFloat, title: String) {
        
        fifthNavButton = UIButton(type: .System) as UIButton
        
        fifthNavButton.frame = CGRectMake(0, 0, 50, 50)
        
        fifthNavButton.setTitle(title, forState: .Normal)
        
        fifthNavButton.sizeToFit()
        
        fifthNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        fifthNavButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        
        fifthNavButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        
        fifthNavButton.addTarget(self, action: "didTapSub", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(fifthNavButton)
        
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: fifthNavButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: fifthNavButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func createButtonWithTitle(title: String, folder: String, xValue: CGFloat, yValue: CGFloat) {
        
        let button = UIButton(type: .System) as UIButton
        
        button.setTitle("", forState: .Normal)
        
        let photoName = folder + "/" + title
        
        button.setBackgroundImage(UIImage(named: photoName), forState: .Normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
        
        self.containerView.addSubview(button)
        
        let buttonLeftSideConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: self.containerView, attribute: .Left, multiplier: 1.0, constant: xValue)
        let buttonTopConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: self.containerView, attribute: .Top, multiplier: 1.0, constant: yValue)
        
        containerView.addConstraints([buttonLeftSideConstraint, buttonTopConstraint])
        
    }
    
    func didTapButton(sender:UIButton) {
        
        let image = sender.backgroundImageForState(.Normal)
        
        let pb = UIPasteboard.generalPasteboard()
        
        let pngType = UIPasteboardTypeListImage[0] as! String
        
        pb.image = image
        
        pb.setData(UIImagePNGRepresentation(image!)!, forPasteboardType: pngType)
        
    }
    
    func didTapDelete() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.deleteBackward()
    }
    
    func didTapFace() {
        self.scrollView.contentOffset.x = 0.0
    }
    
    func didTapToon() {
        self.scrollView.contentOffset.x = lastFaceEmoteX + 60.0
    }
    
    func didTapTurbo() {
        self.scrollView.contentOffset.x = lastToonEmoteX + 60.0
    }
    
    func didTapTV() {
        self.scrollView.contentOffset.x = lastTurboEmoteX + 60.0
    }
    
    func didTapSub() {
        self.scrollView.contentOffset.x = lastTVEmoteX + 60.0
    }
    
    func fillPage(portrait: Bool) {
        var index = 1
        var xValue = CGFloat(10.0)
        
        self.buttonRow1 = CGFloat((amountOfSpace / CGFloat(2.0))) - 10.0 as CGFloat!
        
        self.buttonRow2 = (self.buttonRow1 + self.amountOfSpace) as CGFloat!
        
        self.buttonRow3 = (self.buttonRow2 + self.amountOfSpace) as CGFloat!
        
        if (portrait) {
            self.buttonRow4 = (self.buttonRow3 + self.amountOfSpace) as CGFloat!
        }
        
        let resourcePath = NSBundle.mainBundle().resourcePath
        
        for (var i = 0; i < self.folders.endIndex; i++) {
            let databasePath = resourcePath! + "/" + self.folders[i]
            
            let fileManager = NSFileManager.defaultManager()
            let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(databasePath)!
            
            if (i > 0 && i < 5) {
                xValue = xValue + 75.0
            }
            
            while let element = enumerator.nextObject() {
                if (index == 1) {
                    let photoName = (element as! String)
                    createButtonWithTitle(photoName, folder: self.folders[i], xValue: xValue, yValue: self.buttonRow1)
                    index++
                } else if (index == 2) {
                    let photoName = (element as! String)
                    createButtonWithTitle(photoName, folder: self.folders[i], xValue: xValue, yValue: self.buttonRow2)
                    index++
                } else if (index == 3) {
                    let photoName = (element as! String)
                    createButtonWithTitle(photoName, folder: self.folders[i], xValue: xValue, yValue: self.buttonRow3)
                    index++
                } else if (portrait && index == 4) {
                    let photoName = (element as! String)
                    createButtonWithTitle(photoName, folder: self.folders[i], xValue: xValue, yValue: self.buttonRow4)
                    index = 1
                    if (enumerator.nextObject() != nil) {
                        xValue = xValue + 50.0
                    }
                } else {
                    index = 1
                    if (enumerator.nextObject() != nil) {
                        xValue = xValue + 50.0
                    }
                }
            }
            
            index = 1
            
            if (i == 0) {
                lastFaceEmoteX = xValue
            } else if (i == 1) {
                lastToonEmoteX = xValue
            } else if (i == 2) {
                lastTurboEmoteX = xValue
            } else if (i == 3) {
                lastTVEmoteX = xValue
            } else if (i == 4) {
                firstSubEmoteX = xValue
            }
        }
        
        totalXValue = xValue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = CGSizeMake(totalXValue + 30.0, 0)
        
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, self.view.bounds.height)
        
        scrollView.frame = view.bounds
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.view.bounds.width <= 414.0) {
            self.amountOfSpace = (self.view.bounds.height / CGFloat(5.0)) as CGFloat!
            totalRows = 4
            portrait = true
        } else {
            self.amountOfSpace = (self.view.bounds.height / CGFloat(4.0)) as CGFloat!
            totalRows = 3
            portrait = false
        }
        
        addFirstNavButton(55.0, title: "☺︎")
        addSecondNavButton(85.0, title: "✐")
        addThirdNavButton(115.0, title: "✇")
        addFourthNavButton(145.0, title: "TV")
        addFifthNavButton(175.0, title: "♒︎")
        fillPage(portrait)
    }
    
    func Delete(sender: AnyObject) {
        let subviews = self.containerView.subviews as [UIView]
        for v in subviews {
            if let button = v as? UIButton {
                button.removeFromSuperview()
            }
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        if (self.view.bounds.width <= 414.0) {
            self.amountOfSpace = (self.view.bounds.height / CGFloat(5.5)) as CGFloat!
            totalRows = 3
            portrait = false
        } else {
            self.amountOfSpace = ((self.view.bounds.height / CGFloat(4.0)) + 1.5) as CGFloat!
            totalRows = 4
            portrait = true
        }
        
        Delete(UIButton)
        fillPage(portrait)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        var backGround: UIColor
        
        let proxy = self.textDocumentProxy
        
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
            backGround = UIColor.clearColor()
        } else {
            textColor = UIColor.darkGrayColor()
            backGround = UIColor(red: 232/255, green: 235/255, blue: 235/255, alpha: 1.0)
        }
        
        self.view.layer.backgroundColor = backGround.CGColor
        
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
        
        self.deleteButton.setTitleColor(textColor, forState: .Normal)
    }
    
}
