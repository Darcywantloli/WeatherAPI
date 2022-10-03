//
//  SearchPageViewController.swift
//  weatherAPI
//
//  Created by Hung-Ming Chen on 2022/9/25.
//

import UIKit

class SearchPageViewController: UIViewController {

    @IBOutlet weak var showCityTableView: UITableView!
    
    let cityNameEN = ["Keelung", "Xinbei", "Taipei", "Taoyuan", "Hsinchu", "Miaoli", "Taichung", "Changhua", "Nantou", "Yunlin", "Chiayi", "Tainan", "Kaohsiung", "Pingtung", "Yilan", "Hualien", "Taitung", "Penghu"]
    let cityNameCN = ["基隆", "新北", "臺北", "桃園", "新竹", "苗栗", "臺中", "彰化", "南投", "雲林", "嘉義", "臺南", "高雄", "屏東", "宜蘭", "花蓮", "臺東", "澎湖"]
    
    var searchPageDelegate: chooseCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registreCell()
        
    }
    
    func registreCell() {
        showCityTableView.register(UINib(nibName: "SearchPageTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        showCityTableView.delegate = self
        showCityTableView.dataSource = self
    }
}
extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityNameEN.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showCityTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchPageTableViewCell
        
        cell.cityName.text = cityNameCN[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = showCityTableView.frame.height
        let cellHeight = tableViewHeight / 8
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchPageDelegate?.chooseCity(nameEN: cityNameEN[indexPath.row], nameCN: cityNameCN[indexPath.row] )
        
        self.navigationController?.popViewController(animated: true)
    }
}

protocol chooseCityDelegate {
    func chooseCity(nameEN: String, nameCN: String)
}
