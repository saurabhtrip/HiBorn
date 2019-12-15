//
//  buyProductViewController.swift
//  HiBorn
//
//  Created by localadmin on 11/12/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import ImageSlideshow
import MBProgressHUD


struct ColorData: Decodable {
    let id: Int?
    let name: String?
    let style: String?
    let imageUrl: String?
    
    init(name: String!, id: Int! ,style : String! ,imageUrl : String!) {
        self.name = name
        self.id = id
        self.style = style
        self.imageUrl =  imageUrl
    }
    
}





class buyProductViewControllersliderView : ImageSlideshow {
    
    override func layoutPageControl() {
        if case .hidden = self.pageControlPosition {
            pageControl.isHidden = false
        } else {
            pageControl.isHidden = self.images.count < 0
        }
        
        pageControl.frame = CGRect(x: frame.size.width/2 - 25 , y: frame.size.height - 19, width: 50, height: 23)
        
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
    }
}

class buyProductViewController: UIViewController {
    @IBOutlet var slideShowImageView: buyProductViewControllersliderView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sleeveLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var miniumOrderLabel: UILabel!
    @IBOutlet weak var careInstructionLabel: UILabel!
    @IBOutlet weak var style_no: UILabel!

    @IBOutlet weak var collectioViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var plusQuantityButton: UIButton!
    @IBOutlet weak var minusQuantityButton: UIButton!
       @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var styleType : UIView!
    var dictColor = [String : Any]()
    @IBOutlet weak var fitTypeLabel: UILabel!
    var productDetailsList: [String: Any]?
    var colorGroup : [[String : Any]]?
    static     var productDetailsID  = 0
    var detaits = [String]()
    var moq = 0
    var sliderImagesArray = [SDWebImageSource]()
    
    var sizedetaits = [String]()
    var colordata = [ColorData]()
    
static  var buyDetails = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetilsFetch()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buyProductViewController.didTap))
        slideShowImageView.addGestureRecognizer(gestureRecognizer)
        
        
        let backButton  = UIImage(named: "back")!
        
        //        let editButton   = UIBarButtonItem(image: cartimage,  style: .plain, target: self, action: #selector(didTapEditButton))
        let backButtonNavigation = UIBarButtonItem(image: backButton,  style: .plain, target: self, action: #selector(didTapSearchButton))
        
        self.navigationItem.leftBarButtonItem = nil
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage (named: "navigation"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 60, height: 60)
        //button.addTarget(target, action: nil, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItems =  [backButtonNavigation,barButtonItem]

    }
    
  
    
    @IBAction func changeQuanityButtonAction(_ sender: UIButton) {
   
        if var quantity =  quantityLabel.text  {
            var quant =  (quantity as NSString).integerValue
            
            
                 if sender == plusQuantityButton {
                    quant = quant + 1
                 } else {
                    quant = quant - 1
                 }
   
            if quant >= 1   {
                quantityLabel.text = "\(quant)"

            }
   
        }
   
    
    }
    
    
    
    @objc func didTapSearchButton(sender: UIBarButtonItem){
        
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @objc func didTap() {
        slideShowImageView.presentFullScreenController(from: self)
    }
    
    
    fileprivate func setUpSlideShowView(imagesArray: [SDWebImageSource]) {
        
        slideShowImageView.slideshowInterval = 7.0
        slideShowImageView.backgroundColor = UIColor.white
        slideShowImageView.activityIndicator = DefaultActivityIndicator()
        if imagesArray.count > 0 {
            slideShowImageView.setImageInputs(imagesArray)
            
            
        }
        //          self.yourView.layer.borderWidth = 1
        slideShowImageView.contentScaleMode = .scaleAspectFit
        
        
        let image = UIImage.outlinedEllipse(size: CGSize(width: 7.0, height: 7.0), color: .init(red: 70/255, green: 130/255, blue: 180/255, alpha: 1.0))
        slideShowImageView.pageControl.pageIndicatorTintColor =  UIColor.init(patternImage: image!)
        
        slideShowImageView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center , vertical: .customBottom(padding: 10))
        
        slideShowImageView.pageControl.currentPageIndicatorTintColor = UIColor.black
        
        slideShowImageView.bringSubviewToFront(self.styleType)
        slideShowImageView.bringSubviewToFront(self.slideShowImageView.pageControl)
    }
    
    @IBAction func buyOn(_ sender: Any) {
        var   id   = 0
        buyProductViewController.buyDetails = [DataModel]()
        for    i in  buyProductViewController.buyDetails {
        
        
            if let colorGroup =    i.product   {
                id =  colorGroup["id"] as! Int
                          print(id)
                                
//                for product  in  (self.colorGroup)! {
//
//                    print(product["product"])
////                                    id  =  product["colorGroup"] as! Int
//
//                                }
                            }
        
        }

              if var  decodedColorsData = UserDefaults.standard.data(forKey: "items"),
                               let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: decodedColorsData) as? [DataModel] {
                             
            for i in colorsArray{
                buyProductViewController.buyDetails.append(DataModel(quantity  : i.quantity,product: i.product))

     
                
            }
                               
                           } else {
                               buyProductViewController.buyDetails = []
                           }

                buyProductViewController.buyDetails.append(DataModel(quantity  : Int("\(quantityLabel.text)") ,product:self.productDetailsList))
        
        

                        
                              let itemA =  buyProductViewController.buyDetails
                             let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemA)
                            UserDefaults.standard.set(encodedData, forKey: "items")
        
        
        for vc in self.navigationController!.viewControllers {
            if let myViewCont = vc as? ProductDetailsViewController
            {
                self.navigationController?.popToViewController(myViewCont, animated: true)
            }
        }
        
    }
    
}


extension buyProductViewController  {
    func productDetilsFetch()
    {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Please wait..."
        
        
        let url = "api/public/products/detail/\(buyProductViewController.productDetailsID)"
        
        let param = ["url": url]
        print(param)
        productDetailsList =  [String: Any]()
        sliderImagesArray = [SDWebImageSource]()
        sizedetaits = [String]()
        colordata = [ColorData]()
        detaits = [String]()
        APIManager.defaultManager.productsDetails(apiRouter: .productsDetails(param)) { (responseDict) in
            print(param)
            if let responseDict = responseDict {
                if let status = responseDict["status"] as? String {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.productDetailsList =  [String: Any]()
                    if status == "success" {
                        self.productDetailsList     =  responseDict["product_details"] as? [String : Any]
                        
//                        buyProductViewController.buyDetails(DataModel.init(product:   self.productDetailsList))
                        
                     
                        
                        
                        
                        
                        if let moq =  self.productDetailsList?["moq"] as? Int {
                            
                            self.miniumOrderLabel.text =   "\(moq)"
                              self.moq =   moq
                        }
//
//                             if let value = self.productDetailsList?["moq"] as? Int   {
//                                self.quantityLabel.text = "\(value)"
//                               }
                        
                        
                        if let name =  self.productDetailsList?["name"] as? String {
                            
                            self.NameLabel.text = name
                        }
                        
                        if let detail =  self.productDetailsList?["detail"] as? String {
                            
                            self.descriptionLabel.text = detail
                        }
                        
                        
                        if let fit_type =  self.productDetailsList?["fit_type"] as? String {
                            
                            self.fitTypeLabel.text = fit_type
                        }
                        
                        
                        if let sleeve =  self.productDetailsList?["sleeve"] as? String {
                            
                            self.sleeveLabel.text = sleeve
                        }
                        if let material =  self.productDetailsList?["material"] as? String {
                            
                            self.materialLabel.text = material
                        }
                        
                        if let price =  self.productDetailsList?["mrp"] as? String {
                            
                            self.priceLabel.text =  " ₹\(price)" + " (exclusive all taxes )"
                            self.priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                            self.priceLabel.textColor = UIColor.black
                            self.priceLabel.changeFont(ofText: "\(price)", with: UIFont.systemFont(ofSize: 14, weight: .bold))
                            self.priceLabel.changeTextColor(ofText: " (exclusive all taxes )", with: UIColor.lightGray)
                            
                            self.priceLabel.changeFont(ofText: " (exclusive all taxes )", with: UIFont.systemFont(ofSize: 9, weight: .regular))
                            
                        }
                        
                        
                        
                        
                        if let care_instruction =  self.productDetailsList?["care_instruction"] as? String {
                            
                            self.careInstructionLabel.text  = care_instruction
                        }
                        
                        
                        if let style_no =  self.productDetailsList?["style_no"] as? String {
                            
                            self.style_no.text  = style_no
                        }
                        
                        
                        if let care_instruction =  self.productDetailsList?["care_instruction"] as? String {
                            self.careInstructionLabel.text  = care_instruction
                        }
                        
                        
                        if let colorGroup =  self.productDetailsList?["colorGroup"]  as? [[String : Any]]{
                            self.colorGroup = colorGroup
                            
                            
                            for product  in  colorGroup {
                                
                                if let value = product["product"]  as? [String : Any]{
                                    
                                    var   thumbnail =       value["thumbnail"]
                                    var   style_no    =  value["style_no"]
                                    var   id  =  value["id"]
                                    var color = value["color"]
                                    
                                    self.colordata.append(ColorData(name : color as! String, id : id as! Int , style : style_no as! String , imageUrl : thumbnail as! String))
                                }
                                
                            }
                        }
                        
                        
                        
                        ////// find sizes 39 40
                        
                        let sizeDetails    =   self.productDetailsList!["sizes"] as? [[String : Any]]
                        for i in  sizeDetails!{
                            for (key,value) in  i {
                                
                                if key == "key" {
                                    
                                    if let sizesValue =  value  as? String {
                                        
                                        self.sizedetaits.append(sizesValue)
                                        print(self.sizedetaits)
                                        
                                        //                                                            self.sizeLabel.text = "\(self.sizedetaits)"
                                        
                                        self.sizeLabel.text =   self.sizedetaits.map({$0}).joined(separator: " ")
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        
                        let documentDetails    =   self.productDetailsList!["documents"] as? [[String : Any]]
                        
                        for i in  documentDetails!{
                            for (key,value) in  i {
                                
                                if key == "filename" {
                                    
                                    if let imageUrl =  value  as? String {
                                        
                                        self.detaits.append(imageUrl)
                                        print(self.detaits)
                                        
                                        self.sliderImagesArray  = [SDWebImageSource]()
                                        
                                        for photoes in self.detaits   {
                                            
                                            self.sliderImagesArray.append(SDWebImageSource(urlString: APIRouter.baseURLStringForResource + "/storage/" + "\(photoes)"  , placeholder: UIImage(named: "logo"))!)
                                            
                                        }
                                    }
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        self.setUpSlideShowView(imagesArray: self.sliderImagesArray)
                    }
                    self.collectionView.reloadData()
                }
                self.collectionView.reloadData()
                //
                //                                else   {
                //
                //    //                                let alertController = UIAlertController(title: status, message: message , preferredStyle: .alert)
                //    //                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                //    //                                alertController.addAction(defaultAction)
                //    //                                self.present(alertController, animated: true, completion: nil)
                //
                //                                }
                //
                
            }
        }
        
        
    }
}

extension buyProductViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count : Int = 0
        
        let value =  self.colordata
        if value.count == 0 {
            collectioViewHeight.constant    = 0
            collectionHeight.constant = 0
            
        }
        else{
            collectioViewHeight.constant    = 45
            collectionHeight.constant = 45
            
        }
        
        return value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: floor((collectionView.frame.width - 2) / 2), height: collectionView.frame.height / 3)
        
    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.frame.width.truncatingRemainder(dividingBy: 2) == 0 {
            return UIEdgeInsets.init(top: 0, left: -1, bottom: 0, right: 0)
            
        } else {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! buyProductCollectionViewCell
        
        
        let     model =    colordata[indexPath.row]
        sliderImagesArray = [SDWebImageSource]()
        
        if let imageUrlStr = model.imageUrl  as? String {
            
            cell.imageCircle.sd_setShowActivityIndicatorView(true)
            cell.imageCircle.sd_setIndicatorStyle(.gray)
            cell.imageCircle.sd_setImage(with: URL(string: APIRouter.baseURLStringForResource + "/storage/" + imageUrlStr), placeholderImage: UIImage.defaultImage(), options: .cacheMemoryOnly)
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let     model =    colordata[indexPath.row]
        productDetailsList =  [String: Any]()
        
        buyProductViewController.productDetailsID =  model.id as! Int
        productDetilsFetch()
        
    }
}


extension UIImage {
    
    /// Creates a circular outline image.
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


public extension String {
    
    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
}

public protocol ChangableFont: AnyObject {
    var text: String? { get set }
    var attributedText: NSAttributedString? { get set }
    var rangedAttributes: [RangedAttributes] { get }
    func getFont() -> UIFont?
    func changeFont(ofText text: String, with font: UIFont)
    func changeFont(inRange range: NSRange, with font: UIFont)
    func changeTextColor(ofText text: String, with color: UIColor)
    func changeTextColor(inRange range: NSRange, with color: UIColor)
    func resetFontChanges()
}
public struct RangedAttributes {
    
    let attributes: [NSAttributedString.Key: Any]
    let range: NSRange
    
    public init(_ attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        self.attributes = attributes
        self.range = range
    }
}

extension UILabel: ChangableFont {
    
    public func getFont() -> UIFont? {
        return font
    }
}

extension UITextField: ChangableFont {
    
    public func getFont() -> UIFont? {
        return font
    }
}

extension ChangableFont {
    
    public var rangedAttributes: [RangedAttributes] {
        guard let attributedText = attributedText else {
            return []
        }
        var rangedAttributes: [RangedAttributes] = []
        let fullRange = NSRange(
            location: 0,
            length: attributedText.string.count
        )
        attributedText.enumerateAttributes(
            in: fullRange,
            options: []
        ) { (attributes, range, stop) in
            guard range != fullRange, !attributes.isEmpty else { return }
            rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        }
        return rangedAttributes
    }
    
    public func changeFont(ofText text: String, with font: UIFont) {
        guard let range = (self.attributedText?.string ?? self.text)?.range(ofText: text) else { return }
        changeFont(inRange: range, with: font)
    }
    
    public func changeFont(inRange range: NSRange, with font: UIFont) {
        add(attributes: [.font: font], inRange: range)
    }
    
    public func changeTextColor(ofText text: String, with color: UIColor) {
        guard let range = (self.attributedText?.string ?? self.text)?.range(ofText: text) else { return }
        changeTextColor(inRange: range, with: color)
    }
    
    public func changeTextColor(inRange range: NSRange, with color: UIColor) {
        add(attributes: [.foregroundColor: color], inRange: range)
    }
    
    private func add(attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        guard !attributes.isEmpty else { return }
        
        var rangedAttributes: [RangedAttributes] = self.rangedAttributes
        
        var attributedString: NSMutableAttributedString
        
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = text {
            attributedString = NSMutableAttributedString(string: text)
        } else {
            return
        }
        
        rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        
        rangedAttributes.forEach { (rangedAttributes) in
            attributedString.addAttributes(
                rangedAttributes.attributes,
                range: rangedAttributes.range
            )
        }
        
        attributedText = attributedString
    }
    
    public func resetFontChanges() {
        guard let text = text else { return }
        attributedText = NSMutableAttributedString(string: text)
    }
}
extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
