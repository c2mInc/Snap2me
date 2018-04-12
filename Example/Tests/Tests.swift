// https://github.com/Quick/Quick

import Quick
import Nimble
import Snap2me

class TableOfContentsSpec: QuickSpec {
    override func spec() {
   
                describe("guidlines should give the correct distance") {
        
                    it("vertical") {
                       let guideLine = GuideLine.create(axisPercentages: [GuideLine.AxisPercentage(axis: .vertical, percentage: 0.5)], size: CGSize(width: 100, height: 100))

                        guideLine.forEach{
                            expect($0.distance) == 50
                        }
                    }
                    it("horizontal") {
                        let guideLine = GuideLine.create(axisPercentages: [GuideLine.AxisPercentage(axis: .horizontal, percentage: 0.5)], size: CGSize(width: 100, height: 100))
                        
                        guideLine.forEach{
                            expect($0.distance) == 50
                        }
                    }
                }
    }
}
