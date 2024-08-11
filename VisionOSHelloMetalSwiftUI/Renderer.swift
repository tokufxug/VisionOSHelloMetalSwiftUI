//
//  Renderer.swift
//  VisionOSHelloMetalSwiftUI
//
//  Created by Sadao Tokuyama on 8/11/24.
//

import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    
    var parent: ContentView
    var metalDevice: MTLDevice!
    var metalCommandQueue: MTLCommandQueue
    
    init(_ parent: ContentView) {
        self.parent = parent
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        self.metalCommandQueue = metalDevice.makeCommandQueue()!
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else {
            return
        }
        let commandBuffer = metalCommandQueue.makeCommandBuffer()
        let renderPassDescriptar = view.currentRenderPassDescriptor
        renderPassDescriptar?.colorAttachments[0].clearColor =  MTLClearColorMake(1.0, 1.0, 0.0, 1.0)
        renderPassDescriptar?.colorAttachments[0].loadAction = .clear
        renderPassDescriptar?.colorAttachments[0].storeAction = .store
        
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptar!)
        
        renderEncoder?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
