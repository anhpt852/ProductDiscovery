
Product Discovery App

Requirement:

+ Complete app with given UI design
+ Complete some major features of 2 modules

1. List product module

- Fetch data from API
- Display response data from API in App UI (List type)
- Check and handle some different cases such as: product doesn't have price, product is not sold anymore
- Load more feature: Load new data and seperate data to pages
- Refresh feature: User can pull from top of screen to bottom to do refeshing action. All data will be reset
- Searching: User can type and find product they want to . (In search mode, all others features of normal view mode is hold on)

2. Product Detail Information

- Fetch data from API
- Display response data from API in App UI . With current requirement, this screen has 3 sections with different design. Each of them contains some others type of view component
- Check and handle some different cases such as: product doesn't have price, product is not sold anymore

3. Caching API and show loading indicator 

Approach and Solution:

- App is applied MVC pattern
- I use BaseViewController as root view controller. It will include all common functions like creating navbar, navbar button,...I also use MainNavigationViewController for root Navigation Controller. In here , I can implement checking network feature and presenting popup to let user know the internet connection situation. 
- Model:  I using AlamofireObjectMapper for create model from API ressponse
- All API will be cache by Realm database. Each time an api is called, it is pulled from database to display firstly, then real api request will be called. After an api request success, data will be saved into Realm.

1. With List product module, UI build with table view and SkeletonView library is used to do loading indicator animation

- Data will be reload when table view is scrolled to item in half of current page of item
- Refresh is making by UIRefreshController

2. With detail module, I seperate screen into 3 child view controllers , all logic handle will be implement in view controller . By this way,  I dont have to put too much logic in just 1 screen. As MVC pattern, i also don't want to put logic handle in UIView so i use view controller instead

- In top container , Photos is displayed by iCarousel
- in mid container, we have 3 sections, i use CASPageMenu Library to make this part. Each time user change section, height of this section is calculated and UI is updated. The first section is product describle section so i use webview to display it. I think webview is the most suitable view to display this info which require some text decorator and some others special displaying properties . Height of webview is also calculated and updated as html webpage content height 
- In bottom container, it is horizontal product list in here. I use collection view for this part (Because almost products dont have  some field like "relatedProducts" or something like that. I have to use the same api with List product module to display UI in here )

