//: Swift
import UIKit

//Variables et constantes
var str = "Hello, playground"
str = "toto"

let i = 3

extension Int {
    func toto() {
        print("toto")
    }
}

4.toto()
let d = 5.0
let theTruth = false
let char = "c"

//Les collections
//Les tableaux
let arrayOne = [1,2,3]
var arrTwo = [Int]()
var arrayThree: [Int] = []
var arrayFour: Array<Int> = []
var arrFive = Array<Int>()


//let arrayTwo: [Any] = [1,2,3,"String"]
//let arrayThree: [Any] = []

//Les dictionnaires
let dictOne = ["one": 1, "two": 2]
var dictTwo = [String: Int]()
var dictThree: [String: Int] = [:]

var dictFour: Dictionary<String, Int> = [:]


//Boucles
for v in arrayOne {
    print(v)
}

for i in 0..<1 {
    print(arrayOne[i])
}

for n in 0..<2 {
    print(arrayOne[n])
}

//Tuples
let a = (32,"jon")
print(a.1)

let (age, name) = (38, "Iman")
print(age)
print(name)

let person = (age: 38, name: "Iman", address: "42 avenue de belfort")
print(person.name)

//Exemple de boucle avec les tuples
for (i,v) in arrayOne.enumerated() {
    print(i)
    print(v)
}

//Types complexes
class Person {
    let name: String
    var age = 38

    init(name: String) {
        self.name = name
    }
    
    func printName() {
        print(name)
    }
}

let me = Person(name: "Iman")

//Types complexes

//Classes
final class AgentDePolice: Person {
    let lastName = "Zarrabian"
    
    override func printName() {
        print(name + lastName)
    }
}

//Structs
protocol PrintableBatiment {
    func printAddress()
}

protocol Batiment {
    var address: String {get set}
    var nbEtage: Int {get set}
}

//Donne une impletentation par défaut
extension PrintableBatiment {
    func printAddress() {
        print("jfsdjidsjgjsdi")
    }
}


struct GratteCiel: PrintableBatiment, Batiment {
    var address: String = "test"
    var nbEtage: Int = 4
}

struct Maison: PrintableBatiment {
    var address: String
    var nbEtage: Int
    
    func printAddress() {
        print(address)
    }
}

let ici = GratteCiel()
ici.printAddress()

var one = 1
var two = one
one  = 3
print(one)
print(two)
two = 19
print(one)


//enum
enum BankBalance {
    case positif(Double, Int)
    case negatif(Double)

    func printBalance() {
        switch self {
        case .positif(let value):
            print("Youpi je suis dans le vert de \(value.0)")
        case .negatif(_) :
            print("ou la la")
        }
    }
}

let myBalance = BankBalance.positif(1000.0,30)
myBalance.printBalance()

enum ImageName: String {
    case firstImage = "asset.png"
    case secondImage
}

let myImage = ImageName.firstImage
print(myImage.rawValue)


//function
func add(a: Int, _ b: Int) -> Int {
    return a + b
}

let c = add(a: 3, 4)

//Parametre par défaut
func printValue(_ value: Int = 3) {
    print("THIS IS MY VALUE \(value)")
}

printValue()

func extractValueFromArray(_ array: [Int], at index: Int) -> Int {
    return array[index]
}
let value = extractValueFromArray([1,2,3], at: 2)


let f = extractValueFromArray
let result = f([1,2,3],2)


func applyOperator(a: Int, b: Int, op: (Int, Int) -> Int) -> Int {
    return op(a,b)
}

let resultOperator = applyOperator(a: 3, b: 13) { $0 * $1 }


// higher order function

//MAP prends un tableau
//elle boucle dessus
//pour chq element elle applique une fonction
//elle le remet dans le tableau

let arrayofValues = [1,2,3,4,5,6,7]

let timesTwo = arrayofValues.map { $0 * 2 }.filter { $0 > 4 }.reduce(0, +)

print(timesTwo)


//properties
struct Voiture {
    var nbDoors = 4 //stored property
    var isBig: Bool {
        get {
            //computed property
            return nbDoors > 2
        }
        set {
            nbDoors = newValue ? 4 : 2
        }
    }
    var color: String = "rouge" {
        didSet {
            print("didSet " + color)
        }
        willSet {
            print("willSet " + color) // ancienne valeur
            print("willSet " + newValue)
        }
    }
    
    var driverName: String = { //property intialized with a closure
        return "Iman Zarrabian"
    }()
    
    static func className() -> String { //methode static
        return "Voiture"
    }
}

var aCar = Voiture()
print(aCar.isBig)
aCar.isBig = true

aCar.color = "Bleu"
print(aCar.driverName)

print(Voiture.className())
//operation ternaire
let newResult = aCar.isBig ? "elle est grande" : "elle est petite"


//OPTIONAL
var optionalA: Int? // peut avoir une valeur et dans ce cas ça sera un int, ou nil
//optionalA = 3
print(optionalA)

//explicit unwrapping ou forced unwrapping
if optionalA != nil {
    print(optionalA!)
} else {
    print("y a rien dedans")
}

//optional binding
if let newOptionalA = optionalA {// optionalA != nil ET let newOptionalA = optionalA!
    print(newOptionalA)
} else {
    print("y a rien dedans")
}

func optionalOperator(a: Int?) -> String? {
    guard let a = a else {
        print("nil value found")
        return nil
    }
    return String(a)
}

//optional chaining
struct Individu {
    let name = "toto"
    let home: Home?
}

struct Home {
    let nbFloors = 2
}


let house = Home()
let n = house.nbFloors


let her = Individu(home: house)
let n2 = her.home?.nbFloors


//implicit unwrapping
struct Moto {
    var name: String!
    
    init(name: String) {
        self.name = name
    }
}

let aBike = Moto(name: "Kawasaki")
print(aBike.name)







