//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, Wave, Princess, StarryNight, Scream, Wreck, Udnie, Muse, fromCamera, fromLibrary, aLittleBit, better, muchMore)
import UIKit
import PlaygroundSupport

let Camera = pageTwoViewController()
//#-end-hidden-code
/*:
 In this chapter, you can set the parameters of the art camera yourself! I have provided you with these famous paintings.
 
 ![demo2](demo2.png)
 
 At the same time, you can set the level of style migration and the source of the photo according to your preferences.
 
 Just **click the placeholder** in the code and click the option you want on the toolbar to replace it. After you have finished selecting, click the run my code button.
 
 After trying some, you can go to [The Next Page](@next).
 */
Camera.type = Type.<#Artworkname#>
Camera.source = Source.<#source#>
Camera.level = Level.<#level#>
Camera.launch()
//#-hidden-code
PlaygroundPage.current.liveView = Camera
//#-end-hidden-code
