import SwiftFormatRules

final class NeverUseImplicitlyUnwrappedOptionalsTests: DiagnosingTestCase {
  func testInvalidVariableUnwrapping() {
    let input =
      """
      import Core
      import Foundation
      import SwiftSyntax

      var foo: Int?
      var s: String!
      var c, d, e: Float
      @IBOutlet var button: UIButton!
      """
    performLint(NeverUseImplicitlyUnwrappedOptionals.self, input: input)
    XCTAssertNotDiagnosed(.doNotUseImplicitUnwrapping(identifier: "Int"))
    XCTAssertDiagnosed(.doNotUseImplicitUnwrapping(identifier: "String"))
    XCTAssertNotDiagnosed(.doNotUseImplicitUnwrapping(identifier: "Float"))
    XCTAssertNotDiagnosed(.doNotUseImplicitUnwrapping(identifier: "UIButton"))
  }

  func testIgnoreTestCode() {
    let input =
      """
      import XCTest

      var s: String!
      """
    performLint(NeverUseImplicitlyUnwrappedOptionals.self, input: input)
    XCTAssertNotDiagnosed(.doNotUseImplicitUnwrapping(identifier: "String"))
  }
}
