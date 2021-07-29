//
//  ProductViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class ProductViewController: UIViewController {
    var product:Product!
    private var imageView:UIImageView!
    private var nameLabel:UILabel!
    private var stackView:UIInformationStackView!

    override func loadView() {
        super.loadView()
        imageView = UIImageView()
        stackView = UIInformationStackView()
        nameLabel = UILabel()
        [imageView!, stackView!, nameLabel!].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1 / 2),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stackView.dataSource = self
        stackView.spacing = 10
        stackView.reloadData()
        imageView.backgroundColor = .systemGray6
        nameLabel.font = .systemFont(ofSize: 26, weight: .medium)
        nameLabel.textColor = .systemPink
        nameLabel.text = product.name
        nameLabel.textAlignment = .center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        downloadImage { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
    }
    
    func downloadImage(comlpetion:@escaping (UIImage?) -> ()) {
        let string = ["https://bipbap.ru/wp-content/uploads/2017/04/maxresdefault-13.jpg",
        "https://proza.ru/pics/2018/10/03/1345.jpg",
        "https://pro100-vkusno.ru/wp-content/uploads/2019/03/spaghetti-2931846_640-1.jpg",
        "https://kidpassage.com/images/publications/images/Frukty-Kipra-03.jpg",
        "https://sevastopolfm.ru/wp-content/uploads/2020/06/fr2.jpg",
        "https://www.menslife.com/upload/iblock/d30/yagody_frukty_i_ovoshchi_dlya_uma1.jpg",
        "https://cdn25.img.ria.ru/images/07e4/07/1f/1575206426_0:104:2001:1229_600x0_80_0_0_ead279c37f4b4a139837b233a72f16bb.jpg"]
            .randomElement()
        guard let url = URL(string: string!),
              let image = UIImage(data: try! NSData(contentsOf: url) as Data) else { return comlpetion(nil)}
        comlpetion(image)
    }


}

extension ProductViewController: UIInformationStackViewDataSourse {
    func countElements(infomation stackView: UIInformationStackView) -> Int {
        return 4
    }
    
    func infomationForRow(infomation stackView: UIInformationStackView, row: Int) -> (name: String, text: String?) {
        switch row {
        case 0: return ("date: ", product.date)
        case 1: return ("ccal in product: ", String(product.ccal ?? 0))
        case 2: return ("create: ", product.createdAt?.convertToDate(at: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ", to: "HH:mm  dd MMMM yyyy"))
        case 3: return ("update: ", product.updatedAt?.convertToDate(at: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ", to: "HH:mm  dd MMMM yyyy"))
        default: return ("", "")
        }
     
    }
    
    
}
