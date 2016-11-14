//
//  EpilogueViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class EpilogueViewController: UIViewController {

    var epilogues: [EpilogueModel] = []
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        networkManager.loadEpilogueTimeline(time: Date(), loadMoreCount: 0, {
            epilogues, code in
            if code == 200 {
                print("성공")
                self.epilogues = epilogues
                self.tableView.reloadData()
            } else {
                print("실패")
            }
        })
    }
}

extension EpilogueViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "EpilogueTimelineCell", bundle: nil), forCellReuseIdentifier: "EpilogueTimelineCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return epilogues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpilogueTimelineCell", for: indexPath) as? EpilogueTimelineCell
        
        guard let epilogueCell = cell else {
            return UITableViewCell()
        }
        
        let epilogue = epilogues[indexPath.row]
        epilogueCell.epilogue = epilogue
        epilogueCell.nameLabel.text = epilogue.author.name
        epilogueCell.createdAtLabel.text = Date(timeIntervalSince1970: Double(epilogue.createdAt)).description
        epilogueCell.descriptionLabel.text = epilogue.contents
        return epilogueCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
