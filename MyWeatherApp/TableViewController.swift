//
//  TableViewController.swift
//  MyWeatherApp
//
//  Created by Alexandr on 3/5/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = weatherItems {
            return items.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weatherItemCell", for: indexPath) as! WeatherTableViewCell
        cell.commonInit(time: weatherItems![indexPath.row].time!, place: "\(weatherItems![indexPath.row].place) (\(weatherItems![indexPath.row].latitude) \(weatherItems![indexPath.row].longitude))")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = DetailViewController()

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss dd.MM.YY"
        let time = formatter.string(from: weatherItems![indexPath.row].time!)

        newVC.commonInit(time: time, coordinates: "\(weatherItems![indexPath.row].latitude)   \(weatherItems![indexPath.row].longitude)", place: "\(weatherItems![indexPath.row].place)", temperature: weatherItems![indexPath.row].temperature, info: weatherItems![indexPath.row].info)
        self.navigationController?.pushViewController(newVC, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    
    var weatherItems : Array<WeatherObject>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nibName = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "weatherItemCell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTable()
    }
    private func updateTable() {
        weatherItems = WeatherModel.getAllItems()
        tableView.reloadData()
    }
    

    func tryToClearDatabase() {
        
        if self.weatherItems!.count > 0 {
        
            let alert = UIAlertController(title: "Do you want to clear database?", message: "Action will be undone", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
                switch action.style{
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    WeatherModel.deleteAllItems()
                    self.updateTable()
                    
                case .default:
                    print("default")
                }}))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Nothing to clear", message: "Database is empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        tryToClearDatabase()
    }
    

}
