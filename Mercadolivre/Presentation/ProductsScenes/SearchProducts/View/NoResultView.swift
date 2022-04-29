//
//  NoResultView.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import UIKit

class NoResultView: UIView {

    func initPopup(view: UIView) {
        view.addSubview(self)
        self.setupConstraints(view: view)
    }

    private func setupConstraints(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: (view.heightAnchor), constant: 0).isActive = true
        self.widthAnchor.constraint(equalTo: (view.widthAnchor), constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

}
