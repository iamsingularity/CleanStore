//
//  ListOrdersViewController.swift
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

protocol ListOrdersDisplayLogic: class
{
  func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
}

class ListOrdersViewController: UITableViewController, ListOrdersDisplayLogic
{
  var interactor: ListOrdersBusinessLogic?
  var router: (NSObjectProtocol & ListOrdersRoutingLogic)?
  var displayedOrders: [ListOrders.FetchOrders.ViewModel.DisplayedOrder] = []
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ListOrdersInteractor()
    let presenter = ListOrdersPresenter()
    let router = ListOrdersRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    fetchOrdersOnLoad()
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    fetchOrdersOnLoad()
  }
  
  // MARK: - Fetch orders
  
  func fetchOrdersOnLoad()
  {
    let request = ListOrders.FetchOrders.Request()
    interactor?.fetchOrders(request: request)
  }
  
  func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
  {
    displayedOrders = viewModel.displayedOrders
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return displayedOrders.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let displayedOrder = displayedOrders[indexPath.row]
    var cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell")
    if cell == nil {
      cell = UITableViewCell(style: .value1, reuseIdentifier: "OrderTableViewCell")
    }
    cell?.textLabel?.text = displayedOrder.date
    cell?.detailTextLabel?.text = displayedOrder.total
    return cell!
  }
}
