# CollectionViewNotes
Haciendo apuntes para cuando pierda la memoria

## Comenzando 🚀

- Crear CollectionView desde StoryBoard

- Agregar Label en Celda

![alt text](https://i.stack.imgur.com/veuvJ.png)

- Crear Cocoa Touch Class para la Celda
```swift
import UIKit
class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
}
```

- Crear @IBOutlet hacia ViewController
```swift
@IBOutlet weak var collectionView: UICollectionView!
```
- Declarar delegate y datasource

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
```
- Declarar Array y nombre de celda para Identifier
```swift
let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
```
- Declarar Delegate y Datasource en clase
```swift
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
```
- Agregar protocolos para TableView
```swift
// tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.row] // The row value is the same as the index of the desired text within the array.
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
```

## Control de columnas

- Añadir UICollectionViewDelegateFlowLayout
```swift
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {...
```
```swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let padding: CGFloat =  50
           let collectionViewSize = collectionView.frame.size.width - padding

           return CGSize(width: collectionViewSize/columnsItems, height: collectionViewSize/columnsItems)
       }
```

## Referencias:
-Simple collection view

https://stackoverflow.com/questions/31735228/how-to-make-a-simple-collection-view-with-swift

-Column settings

https://stackoverflow.com/questions/38394810/display-just-two-columns-with-multiple-rows-in-a-collectionview-using-storyboar

