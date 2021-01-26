//
//  MetalView.swift
//  MetalStudy
//
//  Created by Passion on 2020/5/25.
//  Copyright © 2020 Passion. All rights reserved.
//

import Cocoa
import MetalKit

struct Vertex {
    var position: vector_float4
    var color: vector_float4
}

class MetalView: MTKView {
    
    var commandQueue: MTLCommandQueue?
    var rps: MTLRenderPipelineState?
    var vertexData: [Float]?
    var vertexBuffer: MTLBuffer?
    
    override init(frame: CGRect, device: MTLDevice?) {
        super.init(frame: frame, device: device)
        render()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    func render() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device?.makeCommandQueue()
        
        createBuffer()
        registerShaders()
    }
    
    func createBuffer() {
        // 创建顶点
        let vertex_data = [
            Vertex(position: [-1.0, -1.0, 0.0, 1.0], color: [1, 0, 0, 1]),
            Vertex(position: [1.0, -1.0, 0.0, 1.0], color: [0, 1, 0, 1]),
            Vertex(position: [0.0, 1.0, 0.0, 1.0], color: [0, 0, 1, 1]),
        ]
        
        //创建顶点缓冲区
        vertexBuffer = device?.makeBuffer(bytes: vertex_data, length: MemoryLayout<Vertex>.size * vertex_data.count, options: [])
    }
    
    func registerShaders() {
        // Metal提供的着色器函数库
        let library = device?.makeDefaultLibrary()
        
        // 顶点着色器
        let vertex_func = library?.makeFunction(name: "vertex_func")
        // 片段着色器
        let frag_func = library?.makeFunction(name: "fragment_func")
        
        // rpld: 渲染管线描述符
        let rpld = MTLRenderPipelineDescriptor()
        rpld.vertexFunction = vertex_func
        rpld.fragmentFunction = frag_func
        rpld.colorAttachments[0].pixelFormat = .bgra8Unorm
        // 渲染管线状态
        rps = try? device!.makeRenderPipelineState(descriptor: rpld)
    }
    
    func sendToGpu() {
            // drawable: 颜色纹理
        if let drawable = currentDrawable,
            // rpd: 渲染通道描述符
            let rpd = currentRenderPassDescriptor {
            
            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 0.5, 1.0) // 屏幕的背景色
            // 命令缓冲区
            let commandBuffer = commandQueue!.makeCommandBuffer()
            let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd)
            commandEncoder?.setRenderPipelineState(rps!)
            commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
            commandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
    
    public override func draw() {
        super.draw()
        sendToGpu()
    }
}
