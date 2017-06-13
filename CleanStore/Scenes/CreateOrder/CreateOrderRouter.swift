//
//  CreateOrderRouter.swift
//  CleanStore
//
//  Created by Raymond Law on 8/22/15.
//  Copyright (c) 2015 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateOrderRoutingLogic
{
  var dataStore: CreateOrderDataStore? { get }
  func routeToListOrders()
  func routeToShowOrder()
}

class CreateOrderRouter: NSObject, CreateOrderRoutingLogic
{
  weak var viewController: CreateOrderViewController?
  var dataStore: CreateOrderDataStore?
  
  // MARK: Routing
  
  func routeToListOrders()
  {
    let index = viewController!.navigationController!.viewControllers.count - 2
    let destinationVC = viewController?.navigationController?.viewControllers[index] as! ListOrdersViewController
    var destinationDS = destinationVC.router!.dataStore!
    passDataToListOrders(source: dataStore!, destination: &destinationDS)
    navigateToListOrders(source: viewController!, destination: destinationVC)
  }
  
  func routeToShowOrder()
  {
    let index = viewController!.navigationController!.viewControllers.count - 2
    let destinationVC = viewController?.navigationController?.viewControllers[index] as! ShowOrderViewController
    var destinationDS = destinationVC.router!.dataStore!
    passDataToShowOrder(source: dataStore!, destination: &destinationDS)
    navigateToShowOrder(source: viewController!, destination: destinationVC)
  }
  
  // MARK: Navigation
  
  func navigateToListOrders(source: CreateOrderViewController, destination: ListOrdersViewController)
  {
    source.navigationController?.popViewController(animated: true)
  }
  
  func navigateToShowOrder(source: CreateOrderViewController, destination: ShowOrderViewController)
  {
    source.navigationController?.popViewController(animated: true)
  }
  
  // MARK: Passing data
  
  func passDataToListOrders(source: CreateOrderDataStore, destination: inout ListOrdersDataStore)
  {
  }
  
  func passDataToShowOrder(source: CreateOrderDataStore, destination: inout ShowOrderDataStore)
  {
    destination.order = source.orderToEdit
  }
}
