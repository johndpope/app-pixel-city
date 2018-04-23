//
//  ViewController.swift
//  pixel-city
//
//  Created by David Brunstein on 2018-04-17.
//  Copyright © 2018 David Brunstein. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import Alamofire
import AlamofireImage

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var photoGalleryView: UIView!
    @IBOutlet weak var photoGalleryHeightConstraint: NSLayoutConstraint!
    
    // Variables
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadious: Double = 1000                // meters
    
    var screenSize = UIScreen.main.bounds
    var loadingPhotosSpinner: UIActivityIndicatorView?
    var loadingPhotosProgressLbl: UILabel?
    let loadingPhotosProgressLblWidth:CGFloat = 250
    
    var flowLayout = UICollectionViewFlowLayout()
    var photoGalleryCollectionView: UICollectionView?
    var photoUrlArray = [String]()
    var photoArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self

        configureLocationServices()
        addDoubleTap()
        
        // Photo gallery
        photoGalleryCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        photoGalleryCollectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        photoGalleryCollectionView?.delegate = self
        photoGalleryCollectionView?.dataSource = self
        photoGalleryCollectionView?.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        photoGalleryView.addSubview(photoGalleryCollectionView!)
        
        // Registering the photo gallery collection view to tell where to take the rectangle from
        registerForPreviewing(with: self, sourceView: photoGalleryCollectionView!)
        
     }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(MapVC.dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }
    
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(MapVC.animatePhotoGalleryViewDown))
        swipe.direction = .down
        photoGalleryView.addGestureRecognizer(swipe)
    }
    
    func animatePhotoGalleryViewUp() {
        photoGalleryHeightConstraint.constant = 300                     // from 1 to 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animatePhotoGalleryViewDown() {
        cancelAllSessions()
        photoGalleryHeightConstraint.constant = 1                     // from 300 to 1
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addSpinner() {
        loadingPhotosSpinner = UIActivityIndicatorView()
        loadingPhotosSpinner?.center = CGPoint(x: (screenSize.width / 2) - ((loadingPhotosSpinner?.frame.width)! / 2), y: 150)
        loadingPhotosSpinner?.activityIndicatorViewStyle = .whiteLarge
        loadingPhotosSpinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        loadingPhotosSpinner?.startAnimating()
        photoGalleryCollectionView?.addSubview(loadingPhotosSpinner!)
    }
    
    func removeSpinner() {
        // First check if there is a spinner to be removed
        if loadingPhotosSpinner != nil {
            loadingPhotosSpinner?.removeFromSuperview()
        }
    }
    
    func addProgressLabel() {
        loadingPhotosProgressLbl = UILabel()
        loadingPhotosProgressLbl?.frame = CGRect(x: (screenSize.width / 2) - (loadingPhotosProgressLblWidth / 2),
                                                 y: 175, width: loadingPhotosProgressLblWidth, height: 40)
        loadingPhotosProgressLbl?.font = UIFont(name: "Avenir Next", size: 14)
        loadingPhotosProgressLbl?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        loadingPhotosProgressLbl?.textAlignment = .center
        //loadingPhotosProgressLbl?.text = "12/40 photos loaded..."
        photoGalleryCollectionView?.addSubview(loadingPhotosProgressLbl!)
    }
    func removeProgressLabel() {
        if loadingPhotosProgressLbl != nil {
            loadingPhotosProgressLbl?.removeFromSuperview()
        }
    }


    @IBAction func centerMapBtnPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapInUserLocation()
        }
    }
    
}

extension MapVC: MKMapViewDelegate {
    
    func centerMapInUserLocation() {
//        guard let deviceLatitude = locationManager.location?.coordinate.latitude else { return }
//        guard let deviceLongitude = locationManager.location?.coordinate.longitude else { return }
//        let locationcoordinates = CLLocationCoordinate2D(latitude: deviceLatitude, longitude: deviceLongitude)
//        let zoomSpan = MKCoordinateSpan(latitudeDelta: regionRadious, longitudeDelta: regionRadious)
//        let coordinateRegion = MKCoordinateRegion(center: locationcoordinates, span: zoomSpan)

        guard let deviceCoordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(deviceCoordinate, regionRadious * REGION_ZOOM, regionRadious * REGION_ZOOM)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        // drop the pin on the map
        removeAllPins()
        removeSpinner()
        removeProgressLabel()
        cancelAllSessions()
        
        photoUrlArray = []
        photoArray = []
        photoGalleryCollectionView?.reloadData()
        
        
        animatePhotoGalleryViewUp()
        addSwipe()
        addSpinner()
        addProgressLabel()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: PIN_IDENTIFIER)
        mapView.addAnnotation(annotation)
        
        // Set the annotation in the center of the map
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadious * REGION_ZOOM, regionRadious * REGION_ZOOM)
        mapView.setRegion(coordinateRegion, animated: true)
        
        //flickrUrl(withAnnotation: annotation, andNumberOfPhotos: 40)
        retrieveUrls(forAnnotation: annotation) { (success) in
            if success {
                print(self.photoUrlArray)
                self.retrievePhotos(handler: { (success) in
                    if success {
                        // hide spinner, lable, reload the photo collection view
                        self.removeSpinner()
                        self.removeProgressLabel()
                        self.photoGalleryCollectionView?.reloadData()
                    }
                })
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Check if the annotation is the blue location of the user location.
        // We don't want to change the user location
        if annotation is MKUserLocation {
            return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: PIN_IDENTIFIER)
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func removeAllPins() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func retrieveUrls(forAnnotation annotation: DroppablePin, handler: @escaping (_ status: Bool) -> ()) {
        self.loadingPhotosProgressLbl?.text = "Starting to download photos..."
        Alamofire.request(flickrUrl(withAnnotation: annotation)).responseJSON { (response) in
            if response.result.error == nil {
                guard let jsonDict = response.result.value as? Dictionary<String, AnyObject> else { return }
                let photosDict = jsonDict["photos"] as! Dictionary<String, AnyObject>
                let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
                for photo in photosDictArray {
                    let farm = photo["farm"]!
                    let server = photo["server"]!
                    let photoId = photo["id"]!
                    let secret = photo["secret"]!
                    
                    let photoUrl = "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_h_d.jpg"
                    self.photoUrlArray.append(photoUrl)
                }
                handler(true)
            } else {
                debugPrint(response.result.error as Any)
                handler(false)
            }
        }
    }
    
    func retrievePhotos(handler: @escaping (_ status: Bool) -> ()) {
        // Retrieve each photo from Flickr and store them into the photo array
        for photoUrl in photoUrlArray {
            Alamofire.request(photoUrl).responseImage { (response) in
               if response.result.error == nil {
                    guard let image = response.result.value else { return }
                    self.photoArray.append(image)

                    self.loadingPhotosProgressLbl?.text = "\(self.photoArray.count)/\(FLICKR_API_NUMBER_OF_PHOTOS) photos downloaded..."
                    if self.photoArray.count == self.photoUrlArray.count {
                        handler(true)
                    }
               }
            }
        }
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            // cancel all the session data tasks
            sessionDataTask.forEach({ $0.cancel() })
            
            // cancel all the download data tasks
            downloadData.forEach({ $0.cancel() })
        }
    }
    
}

extension MapVC: CLLocationManagerDelegate {
    
    func configureLocationServices() {

        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapInUserLocation()
    }
}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell {
            
            let photoImageView = UIImageView(image: self.photoArray[indexPath.row])
            cell.addSubview(photoImageView)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // photo array count
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // This function is called when one of the cells is tapped
        
        // 1. Instantiate PopVC from storyboard
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return }
        
        // 2. pass the selected image to PopVC
        popVC.initData(forImage: self.photoArray[indexPath.row])
        
        // 3. present the view controller
        present(popVC, animated: true, completion: nil)
        
        
    }
}

extension MapVC: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Setup PopVC when the user push all the way down to pop the photo
        // We give an idea where the user is pressing to have an idea where to animate from
        
        guard let indexPath = photoGalleryCollectionView?.indexPathForItem(at: location), let cell = photoGalleryCollectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return nil }
        popVC.initData(forImage: self.photoArray[indexPath.row])
        
        previewingContext.sourceRect = cell.contentView.frame
        return popVC
        
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Setup the peak part, when the user push a little bit to take a peak of the photo
        show(viewControllerToCommit, sender: self)
    }
}
