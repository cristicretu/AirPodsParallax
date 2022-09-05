//
//  ContentView.swift
//  AirpodsParallax
//
//  Created by Cristian Cretu on 05.09.2022.
//

import SwiftUI
import CoreMotion
import CameraView

struct ContentView: View {
    @State var yaw: Double = 0.0
    @State var pitch: Double = 0.0
    @State var roll: Double = 0.0
    
    let manager = CMHeadphoneMotionManager()
    
    var body: some View {
        ZStack {
            VStack {
                Image("bg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 340, height: 500)
                    .scaleEffect(1.6)
                    .offset(x: CGFloat(yaw * 90), y: CGFloat(pitch * 90))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .offset(x: CGFloat(-yaw * 5), y: CGFloat(-pitch * 5))
                    .animation(.linear(duration: 0.1), value: yaw)
                    .animation(.linear(duration: 0.1), value: pitch)
                
                ZStack {
                    CameraView(cameraPosition: .front)
                        .clipShape(Circle())
                        .frame(width: 180, height: 340)
                }
                .frame(height: 220)
            }
        }
        .onAppear {
            manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
                pitch = motionData!.attitude.pitch
                yaw = motionData!.attitude.yaw
                roll = motionData!.attitude.roll
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
