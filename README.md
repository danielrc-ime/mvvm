# MVVM Design Pattern
Haciendo apuntes para cuando pierda la memoria

## Comenzando 🚀

- Crear carpetas Model, View, ViewModel
- Crear struct con Modelo de Datos
    ```swift
struct SimpsonsModel: Codable {
    let quote: String
    let character: String
    let image: String
    let characterDirection: String
}
```
- Crear clase de ViewModel que conecta con View

```swift
class RequestModel {
    //1.- Se crea metodo para enlazar vista con modelo de vista
    var refreshData = { () -> () in }
    var dataArray: [SimpsonsModel] = [] {
        didSet {
            refreshData()
        }
    }
    
    func getSimpsonData() {...

}
```
- En View llamar al request de ViewModel
```swift
var viewModel = RequestManager()

...
viewModel.getSimpsonData()
...

//Llamar función de enlace
func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }

```




## Referencias:
-Resize Image

https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift

-Column settings

https://stackoverflow.com/questions/38394810/display-just-two-columns-with-multiple-rows-in-a-collectionview-using-storyboar

