//
//  ViewController.swift
//  Assiignment_1_Albums
//
//  Created by Deepali on 23/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var AlbumTableView: UITableView!
    var uiNib : UINib?
    var albumTableViewCell : AlbumTableViewCell?
    private var albumTableViewCellIdentifier = "AlbumTableViewCell"
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var albums: [Album] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerialization()
        initializeTableView()
        registerXIBWithTableViewCell()
     
    }

    
    func initializeTableView(){
        AlbumTableView.dataSource = self
        AlbumTableView.delegate = self
    }
    
    func registerXIBWithTableViewCell(){
       let uiNib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        self.AlbumTableView.register(uiNib, forCellReuseIdentifier: "AlbumTableViewCell")
        
    }
    func jsonSerialization(){
         url = URL(string: "https://jsonplaceholder.typicode.com/albums")
         urlRequest = URLRequest(url: url!)
         urlRequest?.httpMethod = "GET"
         urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!) {
            data, response, error in
            print(data)
            print(response)
            print(error)
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!)as! [[String:Any]]
            for eachAlbum in jsonResponse
            {
                let eachAlbumUserId = eachAlbum["userId"] as! Int
                let eachAlbumId = eachAlbum["id"] as! Int
                let eachAlbumTitle = eachAlbum["title"] as! String
                let eachAlbumObject = Album(userId: eachAlbumUserId, id: eachAlbumId, title: eachAlbumTitle)
                self.albums.append(eachAlbumObject)
            }
            
            DispatchQueue.main.async {
                self.AlbumTableView.reloadData()
            }
            
        }
        dataTask?.resume()

    }

}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        albumTableViewCell = (self.AlbumTableView.dequeueReusableCell(withIdentifier: albumTableViewCellIdentifier, for: indexPath)as! AlbumTableViewCell)
        albumTableViewCell?.userIdLabel.text = String(albums[indexPath.row].userId)
        albumTableViewCell?.idLabel.text = String(albums[indexPath.row].id)
        albumTableViewCell?.titleLabel.text = albums[indexPath.row].title
        return albumTableViewCell!
    }
}


extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}

