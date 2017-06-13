//
//  ListOrdersRouter.swift
//  CleanStore
//
//  Created by Raymond Law on 10/31/15.
//  Copyright (c) 2015 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListOrdersRoutingLogic
{
  var dataStore: ListOrdersDataStore? { get }
  func routeToShowOrder(segue: UIStoryboardSegue)
  func routeToCreateOrder(segue: UIStoryboardSegue)
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic
{
  weak var viewController: ListOrdersViewController?
  var dataStore: ListOrdersDataStore?
  
  // MARK: Routing
  
  func routeToShowOrder(segue: UIStoryboardSegue)
  {
    let destinationVC = segue.destination as! ShowOrderViewController
    var destinationDS = destinationVC.router!.dataStore!
    passDataToShowOrder(source: dataStore!, destination: &destinationDS)
  }
  
  func routeToCreateOrder(segue: UIStoryboardSegue)
  {
    let destinationVC = segue.destination as! CreateOrderViewController
    var destinationDS = destinationVC.router!.dataStore!
    passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
  }
  
  // MARK: Navigation
  
  func navigateToShowOrder(source: ListOrdersViewController, destination: ShowOrderViewController)
  {
    source.show(destination, sender: nil)
  }
  
  func navigateToCreateOrder(source: ListOrdersViewController, destination: CreateOrderViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToShowOrder(source: ListOrdersDataStore, destination: inout ShowOrderDataStore)
  {
    let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
    destination.order = source.orders?[selectedRow!]
  }
  
  func passDataToCreateOrder(source: ListOrdersDataStore, destination: inout CreateOrderDataStore)
  {
  }
}
