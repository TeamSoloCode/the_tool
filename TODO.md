Support validator for t_select_field
Too much data in context data
#-------------------------------------------------

Appbar not display properly
Move base react component , app.js, vendor.js and js-module to server
Load all needed page in isolate thread

Support get data from exportPageContext
Add refresh page button for development mode
Split widget with Deferred components

Use dart2js to support lazy loading for web (web)
Support customizable for t_select_field items
Support for basic on SliverAppBar, SliverGrid
Support common json widget on layout.json
Support get and merge layout.json from another layout.json
Support config UI base on platform in layout.json
Support config theme base on platform in theme.json
Support build mode (development/production) in context page data
Support child config for t_button type that has child property
Support simple operator for binding data ( {{ !state.isGood | eq(state.isGood, "bad") }} )
Support pages app bar custom actions
Support theme for t_input

Support onSubmit for t_form

#-------------------------------------------------

-Support call api from dart (mobile)
-Support call api from dart (web) (Cant return data to js side from dart side)
-Fix bug cannot call api from mobile webview
-Make sure the response data from dart to js have have all information about the req and res
-Make sure can return data when call dart from js (web)
-Fix bug setPageData clear data when call on multi place
-Support for basic input field and form
-Reduce rerendering of all t_widgets

-The props when pass into t_widget still not totally binding
-Support set key and dynamic key for all t_widget
-Support route (web)
-Set page context data back to t_input base on name property
-Support post method in client_api
-Support basic selection input field
-Move config json to server
-Use Freeze to generate DTO class
-Move theme json to server
-Fix bug reload page got redirected to initial page instead of current route
-Support dispatch form action form js side
-Support basic form action for t_form widget
-Support asking/granting permission
-Exclude WebView from web build (web)
-Fix bug #primaryColor have been replace even on the text property (issue from replace base color on widget props)
-Support get forms validation result from t_from to js (web)
-Support t_block to insert t_widget as json to json layout
-Cached t_component if possible
-Support inlayout t_component in layout.json (like t_component but only being used in 1 page) + Support merge property
-Hidden property not working properly
-Fix bug can loadData (static html/js) of webview on mobile
-Do not show text "Unsupported widget. Type: null" when child is not defined
-Cannot scroll t_row when is overflow
-Support validator for t_text_field
-Support auto validation for text_field
