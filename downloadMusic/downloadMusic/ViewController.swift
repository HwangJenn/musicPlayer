//
//  ViewController.swift
//  downloadMusic
//
//  Created by 황지현 on 2022/06/15.
//

//음악리스트
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //tableview로 음악 리스트 보여주기
    @IBOutlet var table: UITableView!
    //음악 변수 선언
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 음악 리스트 구현
        configureSongs()
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    //리스트 보여주기
    func configureSongs(){
        //배역선언
        for i in 1 ..< 5 {
            //음악 상수로 선언
            let song = Song(name: "무료음악\(i).mp3", albumName: "유튜브 무료음악", artistName:"artistName", imageName:"album", trackName: "무료음악\(i)")
            //배열 추가
            songs.append(song)
        }
    }
    
    //리스트에 음악 세로 배열 카운트
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
       }
       
    //리스트 셀 선언
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           //셀 읽어옴
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           //음악 테이블 뷰 셀에 선언
           let song = songs[indexPath.row]
           //셀 설정
           cell.textLabel?.text = song.trackName
           cell.detailTextLabel?.text = song.albumName
           cell.accessoryType = .disclosureIndicator
           cell.imageView?.image = UIImage(named: song.imageName)
           cell.textLabel?.font = UIFont(name: "System", size: 24)
           cell.detailTextLabel?.font = UIFont(name: "System", size: 20)
           
           return cell
       }
       
    //셀 선택 되었을 때 화면 전환하기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.row
        //playerVC를 vc로 식별
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerVC else {
            return
        }
        vc.songs = songs
        vc.position = position
        //회면 이동하기
        present(vc, animated: true, completion: nil)
        
    }
    
    //테이블 뷰 개별 행 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
       
}

//음악 구조체
struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}

