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
    let decimalNumber: Int?
}
struct Output: Codable {
    let romanValue: String
}
enum RomanNumberError: Error {
    case illegalValue
    case outOfBounds
}

func main(param: Input, completion: (Output?, Error?) -> Void) -> Void {

   let thousands:[String?] = {[nil,"M","MM","MMM"]}()
   let hundreds:[String?]  = {[nil,"C","CC","CCC","CD","D","DC","DCC","DCCC","CM"]}()
   let tens:[String?]      = {[nil,"X","XX","XXX","XL","L","LX","LXX","LXXX","XC"]}()
   let units:[String?]     = {[nil,"I","II","III","IV","V","VI","VII","VIII","IX"]}()

   var tempValueString:String = ""

   if let intNumber:Int = param.decimalNumber {
       if intNumber > 0 && intNumber < 4000 {
          var tempValue = intNumber
 
          if tempValue >= 1000 {
            tempValueString = thousands[Int(tempValue/1000)]!
            tempValue = tempValue - Int(tempValue/1000) * 1000
          }
          if tempValue >= 100 {
            tempValueString = tempValueString + hundreds[Int(tempValue/100)]!
            tempValue = tempValue - Int(tempValue/100) * 100
          }
          if tempValue >= 10 {
            tempValueString = tempValueString + tens[Int(tempValue/10)]!
            tempValue = tempValue - Int(tempValue/10) * 10
          }
          if tempValue > 0 {
            tempValueString = tempValueString + units[Int(tempValue)]!
          }

          let result = Output(romanValue: tempValueString)
          completion(result, nil)
       }
       else {
          completion(nil, RomanNumberError.outOfBounds)
       }
   }
   else {
      completion(nil, RomanNumberError.illegalValue)
   }
}
