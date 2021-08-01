# LastFM
Repo for the Case Exercise 

This project is developed using Swift, VIP and Clean Architecture.
This application has two screens 
## Album Search
1. Users can search for album and uses Combine and debounce to limit the number api calls
2. Show the list of Album with Image, Title and Artist,
3. Search display controller is used for Searching
4. UITableView with UITableViewDiffableDataSource is used to populate the view 

When the user click on the album, user will be redirected to Album details screen
## Album Details
1. It shows Album Image, Title and Artist
2. It loads the track from the backed api and shows the tracks below the details
3. UICollectionView with UICollectionViewCompositionalLayout used to show the header and tracks

## Need to LastFM Api key 

```
Use a correct LastFM Api key in the NetworkConfig.swift file 

Line Number: 46, 48
return (replace with your api key)

```
## Need SwiftLint
```
Used SwiftLint for quality, and need SwiftLint installed in the host machine
[SwiftLint](https://github.com/realm/SwiftLint)
```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt/)
