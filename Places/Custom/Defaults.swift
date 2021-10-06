//
//  Defaults.swift
//  Places
//
//  Created by Rehan Saleem on 05/10/2021.
//

import Foundation

// MARK: Top Pickups
let TopPlaces: [Place] = [
    grandHotel, germanosPastry, malakTawook, burgerHouse, collegeOriental, veroMODA
]

// MARK: Random Pickups
let RandomPlaces: [Place] = [
    malakTawook, veroMODA, burgerHouse
]

/// Places List

fileprivate let grandHotel = Place(
    id: 0,
    name: "Grand Kadri Hotel By Cristal Lebanon",
    lat: 33.85148430277257,
    long: 35.895525763213946
)

fileprivate let germanosPastry = Place(
    id: 0,
    name: "Germanos - Pastry",
    lat: 33.85217073479985,
    long: 35.89477838111461
)

fileprivate let malakTawook = Place(
    id: 0,
    name: "Malak el Tawook",
    lat: 33.85334017189446,
    long: 35.89438946093824
)

fileprivate let burgerHouse = Place(
    id: 0,
    name: "Z Burger House",
    lat: 33.85454300475094,
    long: 35.894561122304474
)

fileprivate let collegeOriental = Place(
    id: 0,
    name: "Collège Oriental",
    lat: 33.85129821373707,
    long: 35.89446263654391
)

fileprivate let veroMODA = Place(
    id: 0,
    name: "VERO MODA",
    lat: 33.85048738635312,
    long: 35.89664059012788
)
