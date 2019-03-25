//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, Wave, Princess, StarryNight, Scream, Wreck, Udnie, Muse, fromCamera, fromLibrary, aLittleBit, better, muchMore, twitter, polaroid, photoFrame)
import UIKit
import PlaygroundSupport

let Camera = pageThreeViewController()
//#-end-hidden-code
/*:
 In this chapter, you can use AR effects to place your photos on a table or on a wall.And you can choose photo paper to decorate your photos.
 
 Just click on the photo after the photo is processed to open the AR function.
 */
Camera.type = Type.<#Artworkname#>
Camera.source = Source.<#source#>
Camera.level = Level.<#level#>
// new feature
Camera.photoPaper = PhotoPaper.<#paper#>

Camera.launch()
//#-hidden-code
PlaygroundPage.current.liveView = Camera
//#-end-hidden-code
