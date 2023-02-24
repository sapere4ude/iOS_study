import Foundation

class Movie {
    var movieTitle: String
    var genre: String
    var ageLimit: Int?
    
    init(movieTitle: String, genre: String) {
        self.movieTitle = movieTitle
        self.genre = genre
    }

    convenience init(movieTitle: String, genre: String, ageLimit: Int) {
        self.init(movieTitle: movieTitle, genre: genre)
        self.ageLimit = ageLimit
    }
}

// ageLimit 파라미터를 사용하지 않고 객체 생성
let spiderMan = Movie(movieTitle: "SpiderMan", genre: "Action")
spiderMan.genre
spiderMan.ageLimit // ageLimit 을 옵셔널로 설정했기때문에 nil 이 찍힘

// convenience init 사용으로 ageLimit 파라미터를 넣을 수 있는 상황
let spiderMan2 = Movie(movieTitle: "SpiderMan2", genre: "Action", ageLimit: 15)
spiderMan2.ageLimit
