//
//  CollectionViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 3/20/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectioncell", for: indexPath) as! CollectionCell
        
        return cell
    }
    

    @IBOutlet weak var collectiontable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectiontable.delegate = self
        collectiontable.dataSource = self
        // Do any additional setup after loading the view.
        collectiontable.register(UINib(nibName: "CollectionCell", bundle: nil), forCellReuseIdentifier: "collectioncell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HomeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
