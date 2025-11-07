//
//  LocationHandaler.swift
//  weather_swift_ui
//
//  Created by Siddhant Chouhan on 04/11/25.
//

import CoreLocation
import Foundation
import Combine

@MainActor
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    enum LoadingState {
        case idle
        case loading
        case loaded(WeatherModel)
        case failed(String)
    }
    
    private let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        manager.delegate = self
        requestLocationAuthorization()
        requestLocation()
    }
    
    // MARK: - Permissions
    
    func requestLocationAuthorization() {
        manager.requestWhenInUseAuthorization() // or requestAlwaysAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    @Published var state: LoadingState = .idle
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.state = .loading
        guard let latestLocation = locations.first else { return }
        
        // Update coordinate
        location = latestLocation.coordinate
        print("SIUUUZ \(location?.latitude ?? 0.0),\(location?.longitude ?? 0.0)")
        
        NetworkManager.shared.fetchWeather(for: "\(location?.latitude ?? 0.0),\(location?.longitude ?? 0.0)", completed: {(weather, errorMessage) in
            DispatchQueue.main.async {
                if let weather = weather {
                    self.state = .loaded(weather)
                } else if let errorMessage = errorMessage {
                    self.state = .failed(errorMessage)
                }
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Location error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
