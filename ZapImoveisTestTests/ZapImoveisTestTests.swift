//
//  ZapImoveisTestTests.swift
//  ZapImoveisTestTests
//
//  Created by Matheus Ruschel on 8/18/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import XCTest
@testable import ZapImoveisTest

class ZapImoveisTestTests: XCTestCase {
    
    var communicationModel = CommunicationModel()
    var imoveisAPI = RealStateCommunicationModel()
    var imoveisViewModel = ImoveisViewModel()
    var imovelViewModel:ImovelViewModel!
    var expectation:XCTestExpectation!
    var callBackCalled = false
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imoveisViewModel.delegate = self
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImovelViewModel() {
        
        // invalidID
        imovelViewModel = ImovelViewModel(imovelId: 12345)
        
        expectation = self.expectationWithDescription("wait for delegate")
        
        imovelViewModel.fetchImovel()
        imovelViewModel.delegate = self
        
        waitForExpectationsWithTimeout(5, handler: { error in
            
            if let _ = error {
                XCTFail()
            } else {
                
                XCTAssertNil(self.imovelViewModel.dormitoriosString)
                XCTAssertNil(self.imovelViewModel.estadoString)
                XCTAssertNil(self.imovelViewModel.enderecoString)
                XCTAssertNil(self.imovelViewModel.precoLocacaoString)
                XCTAssertNil(self.imovelViewModel.precoVendaString)
                XCTAssertNil(self.imovelViewModel.areaString)
                XCTAssertNil(self.imovelViewModel.suitesString)
                XCTAssertNil(self.imovelViewModel.tipoString)
                XCTAssertNil(self.imovelViewModel.vagasString)
            }
            
        })
        
        // valid id
        imovelViewModel = ImovelViewModel(imovelId: 9234772)
        
        expectation = self.expectationWithDescription("wait for delegate")
        
        imovelViewModel.fetchImovel()
        imovelViewModel.delegate = self
        
        waitForExpectationsWithTimeout(5, handler: { error in
            
            if let _ = error {
                XCTFail()
            } else {
                
                XCTAssertNotNil(self.imovelViewModel.dormitoriosString)
                XCTAssertNotNil(self.imovelViewModel.estadoString)
                XCTAssertNotNil(self.imovelViewModel.enderecoString)
                XCTAssertNil(self.imovelViewModel.precoLocacaoString)
                XCTAssertNotNil(self.imovelViewModel.precoVendaString)
                XCTAssertNotNil(self.imovelViewModel.areaString)
                XCTAssertNotNil(self.imovelViewModel.suitesString)
                XCTAssertNotNil(self.imovelViewModel.tipoString)
                XCTAssertNotNil(self.imovelViewModel.vagasString)
            }
            
        })

        
    }
    
    func testImoveisViewModel() {
        
        XCTAssertTrue(imoveisViewModel.numberOfRowsInSection == 0)
        
        expectation = self.expectationWithDescription("wait for delegate")
        
        imoveisViewModel.fetchImoveis()
        imoveisViewModel.delegate = self
        
        waitForExpectationsWithTimeout(5, handler: { error in
            
            if let _ = error {
                XCTFail()
            } else {
                
                XCTAssertTrue(self.imoveisViewModel.numberOfRowsInSection > 0)
                XCTAssertTrue(self.imoveisViewModel.numberOfAnunciosText != "")
                XCTAssertTrue(self.imoveisViewModel.objectForIndexPath(NSIndexPath(forRow: 0, inSection: 0)) != nil)
            }
            
        })
        
    }
    
    func testImoveisAPI() {
        
        imoveisAPI.fetchImoveis({
            imoveisCallBack in
            
            do {
                try imoveisCallBack()
                XCTAssertTrue(true)
            } catch _ {
                XCTAssertTrue(false)
            }
            
        })
        
        imoveisAPI.fetchImovel(forId: 12345, completion: {
        
            imovelCallBack in
            
            do {
                try imovelCallBack()
                XCTAssertTrue(false)
            } catch _ {
                XCTAssertTrue(true)
            }
        
        })
        
        imoveisAPI.fetchImovel(forId: 9234776, completion: {
            
            imovelCallBack in
            
            do {
                try imovelCallBack()
                XCTAssertTrue(true)
            } catch _ {
                XCTAssertTrue(false)
            }
            
        })
        
        
    }
    
    func testCommunicationModel() {
        
        var url = NSURL(string: "https://raw.githubusercontent.com/ccezar/sample-data/master/imoveis.json")
        communicationModel.fetchDataOnline(url!, completion: {
        data in
            
            do {
                try data()
                XCTAssertTrue(true)
            } catch _ {
                XCTAssertTrue(false)
            }
        
        })
        
        url = NSURL(string: "https://raw.githubusercontent.com/ccezar/sample-data/master/12345.json")
        communicationModel.fetchDataOnline(url!, completion: {
            data in
            
            do {
                try data()
                XCTAssertTrue(false)
            } catch _ {
                XCTAssertTrue(true)
            }
            
        })

        
    }
    
    func testBuildURL() {
    
        let url = URLBuilder.buildURLForImovelId(12345)
        XCTAssertNotNil(url)
        
        let urlString = "https://raw.githubusercontent.com/ccezar/sample-data/master/12345.json"
        
        XCTAssertTrue(urlString == url!.absoluteString)
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension ZapImoveisTestTests: ImoveisViewModelDelegate {
    
    
    func didFinishLoadingImoveis(imoveisViewModel: ImoveisViewModel, sucess: Bool, errorMsg: String?) {
        expectation.fulfill()
    }
}
extension ZapImoveisTestTests: ImovelViewModelDelegate {
    
    func didFinishLoadingImovel(imoveisViewModel: ImovelViewModel, sucess: Bool, errorMsg: String?) {
         expectation.fulfill()
    }
    
    func didFinishLoadingImage(imoveisViewModel: ImovelViewModel, image: UIImage?, errorMsg: String?) {
         expectation.fulfill()
    }
    
}


