import XCTest
import StoreKitTest
import FlyingFox
import StoreKitTestingProxy
import os

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!,
                            category: String(describing: maestro_driver_iosUITests.self))

class maestro_driver_iosUITests: XCTestCase {

    private var service: StoreKitTestingService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let url = URL(string: "/PATH/TO/STOREKIT_CONFIG.storekit")!
        let data = FileManager.default.contents(atPath: url.absoluteString) ?? Data()
        service = StoreKitTestingService()
        service.saveConfigurationData(data, forBundleID: "com.allthecooks.ios") { error in
            if let error {
                logger.error("Error: \(error)")
            } else {
                logger.debug("Loaded configuration successfully")
            }
        }

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service.removeConfiguration(forBundleID: "com.allthecooks.ios") { error in
            if let error {
                logger.error("Error: \(error)")
            } else {
                logger.debug("Removed configuration successfully")
            }
        }
    }

    func testHttpServer() async throws {
        let server = XCTestHTTPServer()
        try await server.start()
    }
}
