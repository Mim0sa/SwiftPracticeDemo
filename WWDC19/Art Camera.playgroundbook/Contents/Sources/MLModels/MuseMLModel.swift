//
// MuseMLModel.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
public class MuseMLModelInput : MLFeatureProvider {

    /// input image as color (kCVPixelFormatType_32BGRA) image buffer, 480 pixels wide by 640 pixels high
    var input1: CVPixelBuffer

    public var featureNames: Set<String> {
        get {
            return ["input1"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "input1") {
            return MLFeatureValue(pixelBuffer: input1)
        }
        return nil
    }
    
    public init(input1: CVPixelBuffer) {
        self.input1 = input1
    }
}

/// Model Prediction Output Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
public class MuseMLModelOutput : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// output image as color (kCVPixelFormatType_32BGRA) image buffer, 480 pixels wide by 640 pixels high
    lazy var output1: CVPixelBuffer = {
        [unowned self] in return self.provider.featureValue(for: "output1")!.imageBufferValue
    }()!

    public var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    public init(output1: CVPixelBuffer) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["output1" : MLFeatureValue(pixelBuffer: output1)])
    }

    public init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
public class MuseMLModel {
    var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: MuseMLModel.self)
        return bundle.url(forResource: "MuseMLModel", withExtension:"mlmodelc")!
    }

    /**
        Construct a model with explicit path to mlmodelc file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    public init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    public convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration
        - parameters:
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    public convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct a model with explicit path to mlmodelc file and configuration
        - parameters:
           - url: the file url of the model
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    public init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as MuseMLModelInput
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as MuseMLModelOutput
    */
    func prediction(input: MuseMLModelInput) throws -> MuseMLModelOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as MuseMLModelInput
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as MuseMLModelOutput
    */
    func prediction(input: MuseMLModelInput, options: MLPredictionOptions) throws -> MuseMLModelOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return MuseMLModelOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - input1: input image as color (kCVPixelFormatType_32BGRA) image buffer, 480 pixels wide by 640 pixels high
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as MuseMLModelOutput
    */
    func prediction(input1: CVPixelBuffer) throws -> MuseMLModelOutput {
        let input_ = MuseMLModelInput(input1: input1)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [MuseMLModelInput]
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [MuseMLModelOutput]
    */
    func predictions(inputs: [MuseMLModelInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [MuseMLModelOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [MuseMLModelOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  MuseMLModelOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
