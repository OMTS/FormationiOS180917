//: Protocols and Delegation



class Person {
    var coffeeMakerDelegate: CoffeeMaker!
    
    func haveCoffee() {
        //make and drink coffee
        drinkCoffee(coffee: coffeeMakerDelegate.makeCoffee())
    }
    func drinkCoffee(coffee: String) {
        print("mmmm " + coffee + " is so good")
    }
}

protocol CoffeeMaker {
    func makeCoffee() -> String
}

class Starbucks: CoffeeMaker {
    func makeCoffee() -> String {
        return "Latte"
    }
}

class DunkinDonut: CoffeeMaker {
    func makeCoffee() -> String {
        return "Latte Soja"
    }
}

class Brasserie: CoffeeMaker {
    func makeCoffee() -> String {
        return "Espresso"
    }
}

let me = Person()
me.coffeeMakerDelegate = Starbucks()
me.haveCoffee()


me.coffeeMakerDelegate = DunkinDonut()
me.haveCoffee()

me.coffeeMakerDelegate = Brasserie()
me.haveCoffee()