//
// AppDelegate.swift
// MyFirstSampleApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 07/04/17
//

import SAPFiori
import SAPFoundation

import SAPCommon
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    private let logger: Logger = Logger.shared(named: "AppDelegateLogger")
    private var deviceToken: Data?
    private var remoteNotificationClient: SAPcpmsRemoteNotificationClient!
    var myPrefixMyServiceClass: MyPrefixMyServiceClassDataAccess!
    var urlSession: SAPURLSession? {
        didSet {
            self.myPrefixMyServiceClass = MyPrefixMyServiceClassDataAccess(urlSession: urlSession!)
            self.uploadLogs()
        }
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {

        // set the default log level. Note: LogLevel.all may be too much for your use case! Maybe prefer LogLevel.error.
        Logger.root.logLevel = LogLevel.debug

        do {
            // Attaches a LogUploadFileHandler instance to the root of the logging system.d
            try SAPcpmsLogUploader.attachToRootLogger()
        } catch {
            self.logger.error("Failed to attach to root logger. Error: \(error.localizedDescription)")
        }

        UINavigationBar.applyFioriStyle()

        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self

        // Show the actual authentication' view controller
        self.window?.makeKeyAndVisible()
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
        if (storyboard != nil) {
            let splitViewController = self.window!.rootViewController as! UISplitViewController
            let logonViewController = (storyboard?.instantiateViewController(withIdentifier: "BasicAuth"))! as! BasicAuthViewController
            splitViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            splitViewController.preferredDisplayMode = .allVisible
            splitViewController.present(logonViewController, animated: false, completion: {})
        }
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsMasterController = secondaryAsNavController.topViewController as? MasterViewController else { return false }
        // Without this, on iPhone the main screen is the detailview and the masterview can not be reached.
        if (topAsMasterController.collectionType == .none) {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }

        return false
    }

    // MARK: - Remote Notification handling

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            // Enable or disable features based on authorization.
        }
        center.delegate = self
        return true
    }

    // Called to let your app know which action was selected by the user for a given notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Void) {
        self.logger.info("App opened via user selecting notification: \(response.notification.request.content.body)")
        // Here is where you want to take action to handle the notification, maybe navigate the user to a given screen.
        completionHandler()
    }

    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        self.logger.info("Remote Notification arrived while app was in forground: \(notification.request.content.body)")
        // Currently we are presenting the notification alert as the application were in the backround.
        // If you have handled the notification and do not want to display an alert, call the completionHandle with empty options: completionHandler([])
        completionHandler([.alert, .sound])
    }

    func registerForRemoteNotification() -> Void {
        guard let deviceToken = self.deviceToken else {
            // Device token has not been acquired
            return
        }

        self.remoteNotificationClient = SAPcpmsRemoteNotificationClient(sapURLSession: self.urlSession!, settingsParameters: Constants.configurationParameters)
        self.remoteNotificationClient.registerDeviceToken(deviceToken, completionHandler: { (error: Error?) -> Void in
            if error != nil {
                self.logger.error("Register DeviceToken failed")
            } else {
                self.logger.info("Register DeviceToken succeeded")
            }
        })
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.logger.error("Failed to register for Remote Notification")
    }

    // This function is invoked on every application start, but you can reuse it to manually triger the logupload.
    private func uploadLogs() {
        guard let sapUrlSession = self.urlSession else {
            return
        }
        let sapcpmsConfigurationParameters = SAPcpmsSettingsParameters(backendURL: Constants.sapcpmsUrl, applicationID: Constants.appId)
        SAPcpmsLogUploader.uploadLogs(sapURLSession: sapUrlSession, settingsParameters: sapcpmsConfigurationParameters, completionHandler: { error in
            if let error = error {

                self.logger.error("Error happened during log upload: \(error.localizedDescription)")
                return
            }

            self.logger.info("Logs have been uploaded successfully.")
        })
    }
}
