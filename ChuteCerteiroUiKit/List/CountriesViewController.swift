//
//  CountriesViewController.swift
//  ChuteCerteiroUiKit
//
//  Created by Marcos Abreu on 08/09/23.
//

import UIKit

class CountriesViewController: UIViewController {
    private var countries: [Country] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Lista de Países"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        Task {
            do {
                try await fetchRemoteCountries()
            } catch {
                print("Erro: \(error)")
            }
        }
    }
    
    private func addViewsInHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchRemoteCountries() async throws -> Void {
        let url = URL(string: "https://apiv3.apifootball.com/?action=get_countries&APIkey=fe56acd2acb45d94a9f1331149dc55aa2846896f38ecf1484de36d6a3cea87f0")!

        let request = URLRequest(url: url)
        
        print("Ok!")

        let (data, _) = try await URLSession.shared.data(for: request)

        self.countries = try JSONDecoder().decode([Country].self, from: data)

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        print("Ok!")

        return
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CountryCell()
        let country = countries[indexPath.row]
        cell.configure(country: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailViewController.country = countries[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

