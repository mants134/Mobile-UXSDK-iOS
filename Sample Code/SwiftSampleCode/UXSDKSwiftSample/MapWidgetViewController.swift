//
//  MapWidgetViewController.swift
//  DJIUXSDK
//
//  Copyright © 2017 DJI. All rights reserved.
//

import UIKit
import DJIUXSDK

public class MapWidgetViewController: UIViewController {
    
    weak var mapWidget: DUXMapWidget?
    var mapWidgetController: DUXMapViewController?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapWidget()
    }
    
    // MARK: - Setup
    func setupMapWidget() {
        self.mapWidgetController = DUXMapViewController()
        self.mapWidget = self.mapWidgetController?.mapWidget!
        self.mapWidget?.translatesAutoresizingMaskIntoConstraints = false
        self.mapWidgetController?.willMove(toParent: self)
        self.addChild(self.mapWidgetController!)
        self.view.addSubview(self.mapWidgetController!.mapWidget)
        self.mapWidgetController?.didMove(toParent: self)
        
        self.mapWidget?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mapWidget?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.mapWidget?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapWidget?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.mapWidget?.setNeedsDisplay()
        self.view.sendSubviewToBack(self.mapWidget!)
    }
    
    
    // MARK: - Actions
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func customize(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MapWidget", bundle: Bundle(for: type(of: self)))
        let mapCustomizationViewController = storyboard.instantiateViewController(withIdentifier: "CustomMapViewController") as! CustomMapViewController
        mapCustomizationViewController.mapViewController = self.mapWidgetController
        
        self.addChild(mapCustomizationViewController)
        self.view.addSubview(mapCustomizationViewController.view)
        mapCustomizationViewController.didMove(toParent: self)
        
        mapCustomizationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mapCustomizationViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        mapCustomizationViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mapCustomizationViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        mapCustomizationViewController.view.widthAnchor.constraint(equalToConstant: self.view.frame.width/3).isActive = true
        mapCustomizationViewController.view.setNeedsLayout()
        mapCustomizationViewController.view.layoutIfNeeded()
    }
    
    @IBAction func mapTypeValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.mapWidgetController?.mapWidget.mapView.mapType = .standard
        } else if sender.selectedSegmentIndex == 1 {
            self.mapWidgetController?.mapWidget.mapView.mapType = .satellite
        } else if sender.selectedSegmentIndex == 2 {
            self.mapWidgetController?.mapWidget.mapView.mapType = .hybrid
        }
    }
    
    @IBAction func clearFlightPathButtonPressed(_ sender: UIButton) {
        self.mapWidgetController?.mapWidget.clearCurrentFlightPath()
    }
    
    @IBAction func syncCustomUnlockZonesButtonTapped(_ sender: UIButton) {
        self.mapWidgetController?.mapWidget.syncCustomUnlockZones()
    }
}
