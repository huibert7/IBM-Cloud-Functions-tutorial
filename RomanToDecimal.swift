/**
  *
  * main() will be run when you invoke this action
  *
  * @param Cloud Functions actions accept a single parameter, which must be Codable.
  *
  * @return The completion function, which takes as output a Codable and Error?.
  *
  */
struct Input: Codable {
    let romanNumber: String?
}
struct Output: Codable {
    let decimalValue: Int
}
func main(param: Input, completion: (Output?, Error?) -> Void) -> Void {

    let table:[String] = ["MMM","MM","M","CM","DCCC","DCC","DC","D","CD","CCC","CC","C","XC","LXXX","LXX","LX","L","XL","XXX","XX","X","IX","VIII","VII","VI","V","IV","III","II","I"]
    let values:[Int]   = [3000,2000,1000,900,800,700,600,500,400,300,200,100,90,80,70,60,50,40,30,20,10,9,8,7,6,5,4,3,2,1]

    var i:Int = 0
    var calcValue:Int = 0
    var tempRomanNumber:String? = param.romanNumber
    
    if tempRomanNumber != nil {
        while tempRomanNumber!.count > 0 && i < 30 {
            if tempRomanNumber!.starts(with: table[i]){
                calcValue += values[i]
                tempRomanNumber = String(tempRomanNumber!.dropFirst(table[i].count))
            }
            i += 1
        }
    }

    let result = Output(decimalValue: calcValue)
    completion(result, nil)
}
