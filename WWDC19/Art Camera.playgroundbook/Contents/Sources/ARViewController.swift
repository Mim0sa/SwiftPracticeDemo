//
//  ARViewController.swift
//  Book_Sources
//
//  Created by 吉乞悠 on 2019/3/24.
//

import UIKit
import SceneKit
import ARKit
import PlaygroundSupport

struct CollisionCategory {
    let rawValue: Int
    
    static let bottom = CollisionCategory(rawValue: 1 << 0)
    static let cube = CollisionCategory(rawValue: 1 << 1)
}

@available(iOS 11.0, *)
@objc(Book_Sources_ARViewController)
public class ARViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    let hintLabel = UILabel()
    
    public var passImage = UIImage()
    
    var sceneView: ARSCNView!
    var planes = [UUID:Plane]() // 字典，存储场景中当前渲染的所有平面
    var boxes = [SCNNode]() // 包含场景中渲染的所有小方格
    var arConfig: ARWorldTrackingConfiguration!
    //let spotLight = SCNLight()
    
    public var photoPaper: PhotoPaper?
    let card = UIImageView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
        
        hintLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        hintLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        hintLabel.adjustsFontSizeToFitWidth = true
        hintLabel.textColor = UIColor.white
        hintLabel.text = "Find a plane"
        sceneView.addSubview(hintLabel)
        
        setupScene()
        setupRecognizers()
        //insertSpotLight(SCNVector3Make(0, 0, 0))
        
        arConfig = ARWorldTrackingConfiguration()
        arConfig.isLightEstimationEnabled = true
        if #available(iOS 11.3, *) {
            arConfig.planeDetection = .horizontal
        } else {
            arConfig.planeDetection = .horizontal
        }
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupScene() {
        // 设置 ARSCNViewDelegate——此协议会提供回调来处理新创建的几何体
        sceneView.delegate = self
        
        // 显示统计数据（statistics）如 fps 和 时长信息
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
        // 开启 debug 选项以查看世界原点并渲染所有 ARKit 正在追踪的特征点
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
        // 添加 .showPhysicsShapes 可以查看物理作用的几何边界
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        // 在物理作用中，我会在世界原点下方几米处放置一个巨大的 node，发射冲击波后，如果添加的几何体掉到了这个表面上，由于这个表面在所有表面的下方很远处，
        // ARKit 检测到后就会认为这些几何体已从世界脱离并将其删除
        let bottomPlane = SCNBox(width: 1000, height: 0.5, length: 1000, chamferRadius: 0)
        let bottomMaterial = SCNMaterial()
        bottomMaterial.diffuse.contents = UIColor(white: 1, alpha: 0)
        bottomPlane.materials = [bottomMaterial]
        let bottomNode = SCNNode(geometry: bottomPlane)
        bottomNode.position = SCNVector3Make(0, -10, 0)
        bottomNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        bottomNode.physicsBody?.categoryBitMask = CollisionCategory.bottom.rawValue
        bottomNode.physicsBody?.contactTestBitMask = CollisionCategory.cube.rawValue
        sceneView.scene.rootNode.addChildNode(bottomNode)
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    func setupSession() {
        // 创建 session 配置（configuration）实例
        let configuration = ARWorldTrackingConfiguration()
        
        // 明确表示需要追踪水平面。设置后 scene 被检测到时就会调用 ARSCNViewDelegate 方法
        if #available(iOS 11.3, *) {
            configuration.planeDetection = .horizontal
        } else {
            // Fallback on earlier versions
            configuration.planeDetection = .horizontal
        }
        
        // 运行 view 的 session
        sceneView.session.run(configuration)
    }
    
    func setupRecognizers() {
        // 轻点一下就会往场景中插入新的几何体
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.handleTapFrom(recognizer:) ))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        // 按住会发射冲击波并导致附近的几何体移动
        //        let explosionGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleHoldFrom(recognizer:)))
        //        explosionGestureRecognizer.minimumPressDuration = 0.5
        //        sceneView.addGestureRecognizer(explosionGestureRecognizer)
        //
        //        let hidePlanesGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleHidePlaneFrom(recognizer:)))
        //        hidePlanesGestureRecognizer.minimumPressDuration = 1
        //        hidePlanesGestureRecognizer.numberOfTouchesRequired = 2
        //        sceneView.addGestureRecognizer(hidePlanesGestureRecognizer)
    }
    
    @objc func handleTapFrom(recognizer: UITapGestureRecognizer) {
        // 获取屏幕空间坐标并传递给 ARSCNView 实例的 hitTest 方法
        let tapPoint = recognizer.location(in: sceneView)
        let result = sceneView.hitTest(tapPoint, types: .existingPlaneUsingExtent)
        
        // 如果射线与某个平面几何体相交，就会返回该平面，以离摄像头的距离升序排序
        // 如果命中多次，用距离最近的平面
        if let hitResult = result.first {
            insertGeometry(hitResult)
        }
    }
    
    //    @objc func handleHoldFrom(recognizer: UILongPressGestureRecognizer) {
    //        if recognizer.state != .began {
    //            return
    //        }
    //
    //        //使用屏幕坐标执行命中测试来查看用户是否点击了某个平面
    //        let holdPoint = recognizer.location(in: sceneView)
    //        let result = sceneView.hitTest(holdPoint, types: .existingPlaneUsingExtent)
    //        if let hitResult = result.first {
    //            DispatchQueue.main.async {
    //                self.explode(hitResult)
    //            }
    //        }
    //    }
    
    //    @objc func handleHidePlaneFrom(recognizer: UILongPressGestureRecognizer) {
    //        if recognizer.state != .began {
    //            return
    //        }
    //
    //        // 隐藏所有平面
    //        for (_, plane) in planes {
    //            plane.hide()
    //        }
    //
    //        // 停止检测新平面或更新当前平面
    //        if let configuration = sceneView.session.configuration as? ARWorldTrackingConfiguration{
    //            configuration.planeDetection = .init(rawValue: 0) // ARPlaneDetectionNone
    //            sceneView.session.run(configuration)
    //        }
    //
    //        sceneView.debugOptions = []
    //    }
    
    //    func explode(_ hitResult: ARHitTestResult) {
    //        // 发射冲击波(explosion)，需要发射的世界位置和世界中每个几何体的位置。然后获得这两点之间的距离，离发射处越近，几何体被冲击的力量就越强
    //
    //        // hitReuslt 是某个平面上的点，将发射处向平面下方移动一点以便几何体从平面上飞出去
    //        let explosionYOffset: Float = 0.1
    //
    //        let position = SCNVector3Make(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y - explosionYOffset, hitResult.worldTransform.columns.3.z)
    //
    //        // 需要找到所有受冲击波影响的几何体，理想情况下最好有一些类似八叉树的空间数据结构，以便快速找出冲击波附近的所有几何体
    //        // 但由于我们的物体个数不多，只要遍历一遍当前所有几何体即可
    //        for cubeNode in boxes {
    //            // 冲击波和几何体间的距离
    //            var distance = SCNVector3Make(cubeNode.worldPosition.x - position.x, cubeNode.worldPosition.y - position.y, cubeNode.worldPosition.z - position.z)
    //
    //            let len = sqrtf(distance.x * distance.x + distance.y * distance.y + distance.z * distance.z)
    //
    //            // 设置受冲击波影响的最大距离，距离冲击波超过 2 米的东西都不会受力影响
    //            let maxDistance: Float = 2
    //            var scale = max(0, (maxDistance - len))
    //
    //            // 扩大冲击波威力
    //            scale = scale * scale * 2
    //
    //            // 将距离适量调整至合适的比例
    //            distance.x = distance.x / len * scale
    //            distance.y = distance.y / len * scale
    //            distance.z = distance.z / len * scale
    //
    //            // 给几何体施加力，将此力施加到小方块的一角而不是重心来让其旋转
    //            cubeNode.physicsBody?.applyForce(distance, at: SCNVector3Make(0.05, 0.05, 0.05), asImpulse: true)
    //        }
    //    }
    
    //MARK: - uiview转uiimage
    func getImageFromView(view: UIImageView) -> UIImage {
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func insertGeometry(_ hitResult: ARHitTestResult) {
        // 现在先插入简单的小方块，后面会让它变得更好玩，有更好的纹理和阴影
        
        let dimension: CGFloat = 0.15
        
        let img = passImage
        
        let imgView = UIImageView(image: img)
        let ratio = imgView.frame.width / imgView.frame.height
        
        let photoPaper:PhotoPaper = self.photoPaper!
        switch photoPaper {
        case .twitter:
            card.frame = CGRect(x: 0, y: 0, width: 390, height: 300)
            imgView.frame = CGRect(x: 195-175, y: 150-175, width: 350, height: 350)
            let twImgV = UIImageView(frame: card.frame)
            twImgV.image = UIImage(named: "twitter")
            card.addSubview(imgView)
            card.addSubview(twImgV)
            card.clipsToBounds = true
        case .polaroid:
            card.frame = CGRect(x: 0, y: 0, width: 300, height: 300*ratio)
            card.image = UIImage(named: "pld")
            imgView.frame = CGRect(x:50 , y: 75*ratio, width: 200, height: 200*ratio)
            card.addSubview(imgView)
        case .photoFrame:
            card.frame = CGRect(x: 0, y: 0, width: 300, height: 300*ratio)
            card.image = UIImage(named: "xk")
            imgView.frame = CGRect(x: 30, y: 30, width: 240, height: 240*ratio)
            card.addSubview(imgView)
        }
        
        var cube = SCNBox(width: dimension, height: 0.0001, length: dimension * ratio, chamferRadius: 0)
        if photoPaper == .twitter {
            cube = SCNBox(width: dimension, height: 0.0001, length: dimension * 1.3, chamferRadius: 0)
        }
        let material = SCNMaterial()
        material.diffuse.contents = getImageFromView(view: card)
        
        // 由于正在使用立方体，但却只需要渲染表面的网格，所以让其他几条边都透明
        let transparentMaterial = SCNMaterial()
        transparentMaterial.diffuse.contents = UIColor(white: 1, alpha: 0)
        
        cube.materials = [transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, material, transparentMaterial]
        
        let node = SCNNode(geometry: cube)
        
        // physicsBody 会让 SceneKit 用物理引擎控制该几何体
        //        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        //
        //        node.physicsBody?.mass = 0
        //        node.physicsBody?.categoryBitMask = CollisionCategory.cube.rawValue
        
        // 把几何体插在用户点击的点再稍高一点的位置，以便使用物理引擎来掉落到平面上
        let insertionYOffset: Float = 0.01
        node.position = SCNVector3Make(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + insertionYOffset, hitResult.worldTransform.columns.3.z)
        sceneView.scene.rootNode.addChildNode(node)
        boxes.append(node)
        PlaygroundPage.current.assessmentStatus = .pass(message: "Success!!Thank you for your experience!!")
    }
    
    //    func insertSpotLight(_ position: SCNVector3) {
    //        spotLight.type = .spot
    //        spotLight.spotInnerAngle = 45
    //        spotLight.spotOuterAngle = 45
    //        spotLight.intensity = 1000
    //
    //        let spotNode = SCNNode()
    //        spotNode.light = spotLight
    //        spotNode.position = position
    //
    //        spotNode.eulerAngles = SCNVector3Make(-.pi/2.0, 0, 0)
    //        sceneView.scene.rootNode.addChildNode(spotNode)
    //    }
    
    // MARK: - ARSCNViewDelegate
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        //        guard let estimate = sceneView.session.currentFrame?.lightEstimate else {
        //            return
        //        }
        
        //spotLight.intensity = estimate.ambientIntensity
        
        //print("光线估算：%f", estimate.ambientIntensity)
        
        // 1000 为中间值，但对于环境光照强度 1.0 才是中间值，所以需要缩小 ambientIntensity 值
        //        let intensity = estimate.ambientIntensity / 1000
        //        sceneView.scene.lightingEnvironment.intensity = intensity
    }
    
    /**
     实现此方法来为给定 anchor 提供自定义 node。
     
     @discussion 此 node 会被自动添加到 scene graph 中。
     如果没有实现此方法，则会自动创建 node。
     如果返回 nil，则会忽略此 anchor。
     @param renderer 将会用于渲染 scene 的 renderer。
     @param anchor 新添加的 anchor。
     @return 将会映射到 anchor 的 node 或 nil。
     */
    //    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    //        return nil
    //    }
    
    /**
     将新 node 映射到给定 anchor 时调用。
     
     @param renderer 将会用于渲染 scene 的 renderer。
     @param node 映射到 anchor 的 node。
     @param anchor 新添加的 anchor。
     */
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else {
            return
        }
        
        // 检测到新平面时创建 SceneKit 平面以实现 3D 视觉化
        let plane = Plane(withAnchor: anchor, isHidden: false)
        planes[anchor.identifier] = plane
        node.addChildNode(plane)
        hintLabel.text = "Now click this plane"
    }
    
    /**
     使用给定 anchor 的数据更新 node 时调用。
     
     @param renderer 将会用于渲染 scene 的 renderer。
     @param node 更新后的 node。
     @param anchor 更新后的 anchor。
     */
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let plane = planes[anchor.identifier] else {
            return
        }
        
        // anchor 更新后也需要更新 3D 几何体。例如平面检测的高度和宽度可能会改变，所以需要更新 SceneKit 几何体以匹配
        //        print(planes.count)
        //        for e in planes {
        //            if e.value == plane {
        //                let width = e.value.anchor.extent.x
        //                let height = e.value.anchor.extent.z
        //                if (width > 0.15 && height > 0.25) || (width > 0.25 && height > 0.15) { print("no"); return }
        //            }
        //        }
        plane.update(anchor: anchor as! ARPlaneAnchor)
        hintLabel.text = "Now click this plane"
    }
    
    /**
     从 scene graph 中移除与给定 anchor 映射的 node 时调用。
     
     @param renderer 将会用于渲染 scene 的 renderer。
     @param node 被移除的 node。
     @param anchor 被移除的 anchor。
     */
    public func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // 如果多个独立平面被发现共属某个大平面，此时会合并它们，并移除这些 node
        //        for e in planes {
        //            if e.value.anchor == anchor {
        //                let width = e.value.anchor.extent.x
        //                let height = e.value.anchor.extent.z
        //                if (width > 0.15 && height > 0.25) || (width > 0.25 && height > 0.15) { print("no0"); return }
        //            }
        //        }
        planes.removeValue(forKey: anchor.identifier)
        hintLabel.text = "Now click this plane"
    }
    
    /**
     将要用给定 anchor 的数据来更新时 node 调用。
     
     @param renderer 将会用于渲染 scene 的 renderer。
     @param node 即将更新的 node。
     @param anchor 被更新的 anchor。
     */
//    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
//    }
//
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//
//    }
//
//    func sessionWasInterrupted(_ session: ARSession) {
//        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//
//    }
//
//    func sessionInterruptionEnded(_ session: ARSession) {
//        // Reset tracking and/or remove existing anchors if consistent tracking is required
//
//    }
}
