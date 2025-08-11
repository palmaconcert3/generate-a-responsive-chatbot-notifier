import UIKit

// Chatbot Notifier Class
class ChatbotNotifier {
    var notificationCount: Int = 0
    var notificationList: [String] = []
    
    func addNotification(message: String) {
        notificationCount += 1
        notificationList.append(message)
    }
    
    func getNotifications() -> String {
        var notificationString = ""
        for message in notificationList {
            notificationString += "\(message)\n"
        }
        return notificationString
    }
}

// UI Classes
class ChatbotNotifierView: UIView {
    let notifier = ChatbotNotifier()
    let notificationLabel = UILabel()
    let notificationButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        notificationLabel.font = UIFont.systemFont(ofSize: 17)
        notificationLabel.textColor = .black
        notificationLabel.numberOfLines = 0
        
        notificationButton.setTitle("Show Notifications", for: .normal)
        notificationButton.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        
        addSubview(notificationLabel)
        addSubview(notificationButton)
        
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        
        notificationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        notificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        notificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        notificationButton.topAnchor.constraint(equalTo: notificationLabel.bottomAnchor, constant: 16).isActive = true
        notificationButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc func showNotifications() {
        let alertController = UIAlertController(title: "Notifications", message: notifier.getNotifications(), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
    }
}

// Chatbot Class
class Chatbot {
    let notifier = ChatbotNotifier()
    
    func sendMessage(message: String) {
        notifier.addNotification(message: message)
    }
}

// ViewController
class ViewController: UIViewController {
    let chatbot = Chatbot()
    let notifierView = ChatbotNotifierView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(notifierView)
        notifierView.translatesAutoresizingMaskIntoConstraints = false
        
        notifierView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        notifierView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        notifierView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        chatbot.sendMessage(message: "Hello!")
        chatbot.sendMessage(message: "How can I assist you today?")
    }
}