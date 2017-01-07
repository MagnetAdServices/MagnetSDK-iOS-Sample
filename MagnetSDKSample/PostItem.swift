//
//  PostItem.swift
//  MagnetSDKSample
//
//  Created by Saeed on 1/4/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit

class PostItem {

  var name: String
  var description: String
  var photo: UIImage

  init(name: String, description: String, photo: UIImage) {

    // Initialize stored properties.
    self.name = name
    self.description = description
    self.photo = photo
  }

  convenience init?(dictionary: [String: Any]) {

    guard let name = dictionary["name"] as? String,
        let description = dictionary["description"] as? String,
        let photoFileName = dictionary["photo"] as? String,
        let photo = UIImage(named: photoFileName) else {
      return nil;
    }

    self.init(name: name, description: description, photo: photo)
  }
}
