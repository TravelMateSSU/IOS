//
//  EpilogueViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class EpilogueViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "EpilogueTimelineTableCell", bundle: nil), forCellReuseIdentifier: "EpilogueTimelineCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpilogueTimelineCell") as? EpilogueTimelineTableViewCell
        
        guard let epilogueCell = cell else {
            return UITableViewCell()
        }
        
        return epilogueCell
    }
}
