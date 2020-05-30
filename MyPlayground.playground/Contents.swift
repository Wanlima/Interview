import Foundation


let str = "Hello World"

str[str.startIndex...str.index(str.startIndex, offsetBy: 4)]


func lengthOfLongestSubstring(_ s: String) -> Int {
    
    var ans = 0,start = 0,end = 0
    let characters = Array(s)
    var cache:[Character: Int] = [:]
    let length = s.count
    while start < length && end < length {
        let char = characters[end]
        if let cacheVal = cache[char] {
            start = max(start, cacheVal)
        }
        end += 1
        ans = max(ans, end - start )
        cache[char] = end
    }
    return ans
}


lengthOfLongestSubstring("dvdf")

