import Foundation
import XCTest


//MARK: Протокол для фигур
// Протокол для того, чтобы была возможность добавления новых типов фигур (классов), у которых будет метод area()
// Также мы можем вызывать метод area() для любого объекта, который реализует протокол Shape, даже не зная конкретного типа
// фигуры во время компиляции.
protocol Shape {
    func area() -> Double
}


//MARK: Класс для круга

final class Circle: Shape {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    //Площадь круга по радиусу
    func area() -> Double {
        return Double.pi * pow(radius, 2)
    }
}

//MARK: Класс для треугольника

final class Triangle: Shape {
    let sideA: Double
    let sideB: Double
    let sideC: Double
    
    init(sideA: Double, sideB: Double, sideC: Double) {
        self.sideA = sideA
        self.sideB = sideB
        self.sideC = sideC
    }
    //Площадь тругольника по 3-м сторонам (Формула Герона)
    func area() -> Double {
        let semiPerimeter = (sideA + sideB + sideC) / 2
        return sqrt(semiPerimeter * (semiPerimeter - sideA) * (semiPerimeter - sideB) * (semiPerimeter - sideC))
    }
    //Проверка является ли треугольник прямоугольным
    func isRightTriangle() -> Bool {
        let sides = [sideA, sideB, sideC].sorted()
        return sides[0] * sides[0] + sides[1] * sides[1] == sides[2] * sides[2]
    }
}


//MARK: Пример использования

let circle = Circle(radius: 5.0)
let circle2 = Circle(radius: 7.0)

let triangle = Triangle(sideA: 3.0, sideB: 4.0, sideC: 5.0)
let triangle2 = Triangle(sideA: 7.0, sideB: 7.0, sideC: 7.0)

print("Площадь круга с радиусом \(circle.radius) равна \(circle.area())")
print("Площадь круга с радиусом \(circle2.radius) равна \(circle2.area())")


print("Площадь треугольника с сторонами \(triangle.sideA), \(triangle.sideB) и \(triangle.sideC) равна \(triangle.area())")
print("Треугольник прямоугольный: \(triangle.isRightTriangle())")

print("Площадь треугольника с сторонами \(triangle2.sideA), \(triangle2.sideB) и \(triangle2.sideC) равна \(triangle2.area())")
print("Треугольник прямоугольный: \(triangle2.isRightTriangle())")


//MARK: Юнит-тесты

class GeometryCalculatorTests: XCTestCase {
    
    func testCircleArea() {
        let circle = Circle(radius: 5.0)
        XCTAssertEqual(circle.area(), 78.53981633974483)
        
        let circle2 = Circle(radius: 7.0)
        XCTAssertEqual(circle2.area(), 153.93804002589985)

    }
    
    func testTriangleArea() {
        let triangle = Triangle(sideA: 3.0, sideB: 4.0, sideC: 5.0)
        XCTAssertEqual(triangle.area(), 6.0)
        
        let triangle2 = Triangle(sideA: 7.0, sideB: 7.0, sideC: 7.0)
        XCTAssertEqual(triangle2.area(), 21.21762239271875)
    }
    
    func testRightTriangle() {
        let triangle1 = Triangle(sideA: 3.0, sideB: 4.0, sideC: 5.0)
        XCTAssertTrue(triangle1.isRightTriangle())
        
        let triangle2 = Triangle(sideA: 5.0, sideB: 12.0, sideC: 13.0)
        XCTAssertTrue(triangle2.isRightTriangle())
        
        let triangle3 = Triangle(sideA: 1.0, sideB: 2.0, sideC: 3.0)
        XCTAssertFalse(triangle3.isRightTriangle())
    }
}

let testSuite = GeometryCalculatorTests.defaultTestSuite
testSuite.run()

