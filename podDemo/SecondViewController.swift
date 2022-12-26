//
//  SecondViewController.swift
//  podDemo
//
//  Created by Apple on 23/11/22.
//

import UIKit
import SDWebImage
class SecondViewController: UIViewController {
    var posts = [Post]()
    @IBOutlet var tableViewToDisplayPosts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewToDisplayPosts.delegate = self
        tableViewToDisplayPosts.dataSource = self
        registerNIB()
        downloadJSONData{
            self.tableViewToDisplayPosts.reloadData()
        }
    }
    func registerNIB(){
        let UINIB = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableViewToDisplayPosts.register(UINIB, forCellReuseIdentifier: "PostTableViewCell")
    }
    func downloadJSONData(completed : @escaping() -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let  url = URL(string: urlString) else{
            print("did not fetch url")
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            if(error == nil){
                do{
                    let jsonDecoder = JSONDecoder()
                    self.posts = try! jsonDecoder.decode([Post].self, from: data!)
                   
                 }catch{
                    print("error")
                }
                DispatchQueue.main.async {
                    completed()
                }
            }
        }.resume()
    }
}
extension SecondViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.tableViewToDisplayPosts.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        postTableViewCell.idLabel.text = String(posts[indexPath.row].id)
        postTableViewCell.titleLabel.text = posts[indexPath.row].title
        postTableViewCell.bodyLabel.text = posts[indexPath.row].body
        return postTableViewCell
    }
}
extension SecondViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
