//
// StarryNightMLModel.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
public class StarryNightMLModelInput : MLFeatureProvider {

    /// inputImage as color (kCVPixelFormatType_32BGRA) image buffer, 720 pixels wide by 720 pixels high
    var inputImage: CVPixelBuffer

    public var featureNames: Set<String> {
        get {
            return ["inputImage"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "inputImage") {
            return MLFeatureValue(pixelBuffer: inputImage)
        }
        return nil
    }
    
    init(inputImage: CVPixelBuffer) {
        self.inputImage = inputImage
    }
}

/// Model Prediction Output Type
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
public class StarryNightMLModelOutput : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// outputImage as color (kCVPixelFormatType_32BGRA) image buffer, 720 pixels wide by 720 pixels high
    lazy var outputImage: CVPixelBuffer = {
        [unowned self] in return self.provider.featureValue(for: "outputImage")!.imageBufferValue
    }()!

    public var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    public init(outputImage: CVPixelBuffer) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["outputImage" : MLFeatureValue(pixelBuffer: outputImage)])
    }

    public init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
public class StarryNightMLModel {
    var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: StarryNightMLModel.self)
        return bundle.url(forResource: "StarryNightMLModel", withExtension:"mlmodelc")!
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
           - input: the input to the prediction as StarryNightMLModelInput
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as StarryNightMLModelOutput
    */
    func prediction(input: StarryNightMLModelInput) throws -> StarryNightMLModelOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as StarryNightMLModelInput
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as StarryNightMLModelOutput
    */
    func prediction(input: StarryNightMLModelInput, options: MLPredictionOptions) throws -> StarryNightMLModelOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return StarryNightMLModelOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - inputImage as color (kCVPixelFormatType_32BGRA) image buffer, 720 pixels wide by 720 pixels high
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as StarryNightMLModelOutput
    */
    func prediction(inputImage: CVPixelBuffer) throws -> StarryNightMLModelOutput {
        let input_ = StarryNightMLModelInput(inputImage: inputImage)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [StarryNightMLModelInput]
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [StarryNightMLModelOutput]
    */
    func predictions(inputs: [StarryNightMLModelInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [StarryNightMLModelOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [StarryNightMLModelOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  StarryNightMLModelOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
