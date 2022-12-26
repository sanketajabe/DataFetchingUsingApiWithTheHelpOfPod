//
//  ViewController.swift
//  podDemo
//
//  Created by Apple on 09/11/22.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingDataFromAPI()
        initDataAndDelegate()
        registerNib()
    }
    func initDataAndDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    func registerNib(){
      let nibname = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.tableView.register(nibname, forCellReuseIdentifier: "PostTableViewCell")
    }
    func fetchingDataFromAPI(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        var session = URLSession(configuration: .default)
        //dataTask is a method responsible for fetching raw data
        var dataTask = session.dataTask(with: request){data, response, error in
           print("Data\(data)")
            print("response\(response)")
            
            var getJsonObject = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            
            guard let data = data else{
                print("Data not found")
                print("Error\(error)")
                return
            }
            
            for dictionary in getJsonObject{
                let eachDictionary = dictionary as [String : Any]
                let pid = eachDictionary["id"] as! Int
                let ptitle = eachDictionary["title"] as! String
                let pbody = eachDictionary["body"] as! String
                
                var newPost = Post(id: pid, title: ptitle, body: pbody)
                self.posts.append(newPost)
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var postTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        postTableViewCell.idLabel.text = String(posts[indexPath.row].id)
        postTableViewCell.titleLabel.text = posts[indexPath.row].title
        postTableViewCell.bodyLabel.text = posts[indexPath.row].body
        return postTableViewCell
    }
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
