//
//  PlayerVC.swift
//  downloadMusic
//
//  Created by 황지현 on 2022/06/15.
//

//음악 재생하기
//패키지임포트
import AVFoundation
import UIKit

class PlayerVC: UIViewController {
    //접근수준 지정
    public var position:Int = 0
    public var songs:[Song] = []
    
    //스토리보드 연결
    @IBOutlet var holder: UIView!
    //객체를 optional타입으로 두기위해 weak 선언
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var playPaiseBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    //player 변수 전역 선언
    var player: AVAudioPlayer?
   
    //viewcontroller의 subview를 레이아웃하려고 함
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        print("holder.subviews.count : \(holder.subviews.count)")
        if holder.subviews.count == 0{
            configure()
        }
    } 
    
    //player를 불러온 다음 음악을 자동 재생하는 것을 try로 묶음
    func configure(){
        let song = songs[position]
        
        let url = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            
            guard let urlString = url else {
                print("urlString is nil")
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                print("player is nil")
                return
            }
        //player 설정
           playPaiseBtn.setImage(UIImage.init(systemName: "pause"), for: .normal)
            player.volume = 0.5
            player.numberOfLoops = 0
            player.play()
            player.play()
            
        } catch {
            print("오류발생")
        }
        //player 화면 구성
        imageView.image = UIImage(named: song.imageName)
        titleLabel.text = song.albumName
        subLabel.text = song.trackName
    }
    
    //앞으로
    @IBAction func clickForwardBtn(_ sender: UIButton) {
        print("clickForwardBtn")
        if position < (songs.count - 1){
            position = position + 1
            player?.stop()
        }
        configure()
    }
    
    //플레이
    @IBAction func clickPlayPauseBtn(_ sender: UIButton) {
        print("clickPlayPauseBtn")
        
        if player?.isPlaying == true {
            player?.pause()
            playPaiseBtn.setImage(UIImage.init(systemName: "play"), for: .normal)
        } else {
            player?.play()
            playPaiseBtn.setImage(UIImage.init(systemName: "pause"), for: .normal)
        }
    }
    
    //뒤로
    @IBAction func clickBackBtn(_ sender: UIButton) {
        print("clickBackBtn")
        if position > 0 {
            position -= 1
            player?.stop()
        }
        configure()
    }
    
    //볼륨설정
    @IBAction func changeSlider(_ sender: UISlider) {
        print("changeSlider click: \(sender.value)")
        player?.volume = sender.value
    }
    
    //화면 나갈 때 음악 자동 재생
    //앨범커버 등등은 song객체에서 불러옴
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let player = player {
        player.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
