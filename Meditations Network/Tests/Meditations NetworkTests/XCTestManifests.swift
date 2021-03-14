import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Meditations_NetworkTests.allTests),
    ]
}
#endif
