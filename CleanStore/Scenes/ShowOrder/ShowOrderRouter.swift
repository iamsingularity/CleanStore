//
//  ShowOrderRouter.swift
//  CleanStore
//
//  Created by Raymond Law on 2/17/16.
//  Copyright (c) 2016 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  so you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ShowOrderRoutingLogic
{
  var dataStore: ShowOrderDataStore? { get }
  func routeToEditOrder(segue: UIStoryboardSegue)
}

class ShowOrderRouter: NSObject, ShowOrderRoutingLogic
{
  weak var viewController: ShowOrderViewController?
  var dataStore: ShowOrderDataStore?
  
  // MARK: Routing
  
  func routeToEditOrder(segue: UIStoryboardSegue)
  {
    let destinationVC = segue.destination as! CreateOrderViewController
    var destinationDS = destinationVC.router!.dataStore!
    passDataToEditOrder(source: dataStore!, destination: &destinationDS)
  }
  
  // MARK: Navigation
  
  func navigateToEditOrder(source: ShowOrderViewController, destination: CreateOrderViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToEditOrder(source: ShowOrderDataStore, destination: inout CreateOrderDataStore)
  {
    destination.orderToEdit = source.order
  }
}
