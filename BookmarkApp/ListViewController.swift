//
//  ListViewController.swift
//  BookmarkApp
//
//  Created by Yessenali Zhanaidar on 22.01.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private var links: [LinkData] = Storage.linkModels {
        didSet {
            if links.count > 0 {
                checkLinks()
            }
            if  links.count == 0 {
                checkLinks()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLinks()
        initialize()
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "bgColor")
        tableView.isHidden = true
        return tableView
    }()
    
    let navTitleList: UILabel = {
        let title = UILabel()
        title.text = "List"
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return title
    }()
    
    let navTitleBookmark: UILabel = {
        let title = UILabel()
        title.text = "Bookmark App"
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return title
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Save your first\n     bookmark"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    @objc public func buttonPressed() {
        alert()
    }

    public func alert() {
        let alert = UIAlertController(
            title: "New Bookmark",
            message: "Please write the link with https://",
            preferredStyle: .alert)
        
        alert.addTextField { field in field.placeholder = "Bookmark title" }
        alert.addTextField { field in field.placeholder = "Bookmark link" }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { UIAlertAction in
            guard let fields = alert.textFields, fields.count == 2 else { return }
            guard let name = fields[0].text, !name.isEmpty,
                  let link = fields[1].text, !link.isEmpty
            else { return }
            
            self.links.append(LinkData(name: name, link: link))
            Storage.linkModels.append(LinkData(name: name, link: link))
            self.tableView.reloadData()
        }))
    
    present(alert, animated: true)
    }
    
    private func checkLinks() {
        if links.isEmpty {
            tableView.isHidden = true
            navTitleBookmark.isHidden = false
            navTitleList.isHidden = true
            mainLabel.isHidden = false
        }
        else {
            tableView.isHidden = false
            navTitleList.isHidden = false
            navTitleBookmark.isHidden = true
            mainLabel.isHidden = true
        }
    }

    public func initialize() {
        view.backgroundColor = UIColor(named: "bgColor")
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(navTitleList)
        navTitleList.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
        }
        view.addSubview(navTitleBookmark)
        navTitleBookmark.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(addButton)
            addButton.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(58)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        addButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell
        else { return UITableViewCell() }
        cell.backgroundColor = UIColor(named: "bgColor")
        cell.configure(data: links[indexPath.row].name, link: links[indexPath.row].link)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: links[indexPath.row].link) {
            print("link is tapped")
            UIApplication.shared.open(url)
        }
    }
    
    func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {

        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.links.remove(at: indexPath.row)
            Storage.linkModels.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        return action
    }
    
    func wrongAlert() {
        let alert = UIAlertController(title: "Note😅", message: "While the change button is not working", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    func edit(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Change") { [weak self] (_, _, _) in
            guard let self = self else { return }
            print("number of index is \(indexPath.row)")
            
            self.wrongAlert()
            self.tableView.reloadData()
        }
        action.backgroundColor = .systemBlue
        return action
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathAt: indexPath)
        let edit = self.edit(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipe
    }
}
