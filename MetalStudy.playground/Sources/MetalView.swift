import Foundation
import MetalKit

public class MetalView: MTKView {

    var commandQueue: MTLCommandQueue?
    var rps: MTLRenderPipelineState?
    var vertexData: [Float]?
    var vertexBuffer: MTLBuffer?

   override init(frame: CGRect, device: MTLDevice?) {
        super.init(frame: frame, device: device)
        render()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render() {

        device = MTLCreateSystemDefaultDevice()
        // 创建顶点
        vertexData = [-1.0, -1.0, 0.0, 1.0,
                                   1.0, -1.0, 0.0, 1.0,
                                   0.0,  1.0, 0.0, 1.0]

        let data_size = vertexData!.count * MemoryLayout<Float>.size
        //创建顶点缓冲区
        vertexBuffer = device?.makeBuffer(bytes: vertexData!, length: data_size, options: [])

        // Metal提供的着色器函数库
        let library = device?.makeDefaultLibrary()

        // 顶点着色器
        let vertex_func = library?.makeFunction(name: "vertex_func")
        // 片段着色器
        let frag_func = library?.makeFunction(name: "fragment_func")

        // rpd: 渲染管线描述符
       let rpld = MTLRenderPipelineDescriptor()
       rpld.vertexFunction = vertex_func
       rpld.fragmentFunction = frag_func
       rpld.colorAttachments[0].pixelFormat = .bgra8Unorm
        // 渲染管线状态
       rps = try? device!.makeRenderPipelineState(descriptor: rpld)
    }

    public override func draw() {
        super.draw()
        if let drawable = currentDrawable, let rpd = currentRenderPassDescriptor{
            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1.0)
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
}

