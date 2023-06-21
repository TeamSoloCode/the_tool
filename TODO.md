FIXME: Sequence validating field is not working properly when run field validation js function
(this because validation js function run after form validate function)

SUPPORT: Invoke dart function with emitter

FIXME: Remove reflectable of layout_props, because it consume 200kb of bundle

SUPPORT: responsive with device version
SUPPORT: Use metadata to specify layout property is a string or number
SUPPORT: RichText

SUPPORT: Blowfish encryption to encrypt data passing to js side to execute

SUPPORT: image picker field in register layout
SUPPORT: file picker field

UPDATE: merge function of LayoutProps class to auto merge all simple properties. Check mergeObjects function in layout_props.dart

UPDATE: Check widget props what contain any screen_util unit before start to re-computeWidgetProps in t_widget base

UPDATE: DO not use http://localhost:8081 in index.html==============

<!--
    <script src="http://localhost:8081/vendors.js" defer></script>
    <script src="http://localhost:8081/app.js" defer></script>
-->

===================================================================

SUPPORT: Error Widget for twidgets
SUPPORT: SVG widget
SUPPORT: dynamic for using "style" property in json layout

#-------------------------------------------------
FIXME: prevent user access to the context in console and run function in the page context
implement seo_renderer, meta_seo
UPDATE: Using emitter instead of using eval to call a function
UPDATE: Using custom expansion panel instead of the built-in to test the perf when open side navigation

Support format number for t_textfield
Reduce bundle size
Fix bug: User press button home and go back to the app => cannot use emit to js side

Appbar not display properly

Load all needed page in isolate thread
Add refresh page button for development mode

SUPPORT: Text animation with flutter_animate, animated_text_kit package
Support customizable UI for t_select_field items
Support for basic on SliverAppBar, SliverGrid
Support config UI base on platform in layout.json
Support config theme base on platform in theme.json
Support build mode (development/production) in context page data
Support child config for t_button type that has child property
Support simple operator for binding data ( {{ !state.isGood | eq(state.isGood, "bad") }} )
Support pages app bar custom actions
Support alert, dialog, snackbar, ScaffoldMessenger

#-------------------------------------------------

-FIXME: cannot execute js function that call another func as a param ex: validateFormLogin(getPageData())
-FIXME: Cannot emit full function. Ex: goTo("abcd_page") in json layout
-SUPPORT: set min/max date for field date
-SUPPORT: Continue support t_bottom_sheet feature
-FIXME: the auto validate of the form is validaing when not input anything web (prod/dev), android (prod)
-FIXME: The text color in the side navigation is not properly when change theme from dark to light
-SUPPORT: merge inline TextStyle when using with google_fonts TextStyle in Theme
-SUPPORT: google_fonts for theme
-Update the function that update the theme json into js side
-FIXME: Cannot declare 2 variables with the same name on 2 difference page in js side
-UPDATE: Check that if the Map, List property in in widget props can be binding properly
-UPDATE: Merge navigator in web/mobile invoke into one place
-UPDATE: Use reflectable package to avoid compute LayoutProps property in LayoutProps class
-SUPPORT: Load core page before loading any other page
-SUPPORT: Set authContext from js side
-Add login page base on design image
-SUPPORT: Auth route for the app
-SUPPORT: Change icon size in prefix/suffix icon of TextField
Support MediaScreenOnly for all t_widgets
\_index and \_selected key being removed after click select all button on table
-Support call api from dart (mobile)
-Support call api from dart (web) (Cant return data to js side from dart side)
-Fix bug cannot call api from mobile webview
-Make sure the response data from dart to js have have all information about the req and res
-Make sure can return data when call dart from js (web)
-Fix bug setPageData clear data when call on multi place
-Support for basic input field and form
-Reduce rerendering of all t_widgets
-Support onSubmit for t_form
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
-Support validator for t_select_field
-Use dart2js to support lazy loading for web (web)
-Split widget with Deferred components
-Support navigation pop function
-Navigate Login => Register => click button Back to Login => press Back button on the Phone => -Login Page did unmount
-Support FormBuilderVaidator for t_textfield
-Support number type text field
-Support common validators for t_selectfield
-Support field date time picker
-Support get root page data
-Support drawer for page
-Add paging for DataTable
-Support LayoutBuilder for responsive layout
-Fix bug: rows of table in state have selected = true but not show select when use with Layout Builder
-Support className for mediaScreenOnly item
-Support mediaScreenOnly when children have Expanded/Flexible on Row/Column/Stack
-Support Avatar widget
-Support ListView builder
-Update input of all t_widgets into a Map to reduce code in t_widgets.dart
-Support ListTile
-Support Card widget
-Support merge deep nested when using built-in json component(child)
-Support merge deep nested when using built-in json component(children)
-Support get current ThemeData in JS side
-Fix bug: Cannot setPageData in dashboard when open drawer and expanting one nav
-Fix bug: contextData still hold unmounted pageData
-setPageData shouldn't depenpended on any dependencies in js side
-Fixbug: Table still show loading indicator on the first select all row
-implement url_strategy (remove the # in the link)
-Support ExpansionPanel widget
-Fixbug: The widget type component in the drawer did not unmount on React when close drawer, but it mount new node in React when drawer opened
-Fixbug: The Drawer is too slow and laggy when open it on release/debug mode
-Fixbug: The child component in block_page is not display text properly
-Try to use ThemeData in json layout and js code
-Fixbug: TextTheme not merge properly when change theme in SideNavigation
-Try to use #theme.textTheme.bodyLarge.color, ... in json layout property
-Fix performance issue of the twidget when the theme changing
-Move base react component , app.js, vendor.js and js-module to server
-FIXME: Do not update theme JSON on every time context state changed
-implement flutter_modular (make the routing easier)
-FIXME: When theme changed there are 8 times contextState update
-Support a js hook that with call when widget size change
-Support common json widget on layout.json
-FIXME: Add select all row function on js for tdatatable, change single row and all row not working properly when change table page
-FIXME: Modular: Cannot routing in test_page project
-SUPPORT: Add queryParams of Modular into js side
-SUPPORT: TS on js-module
-SUPPORT: Binding context state into all value binding props in computeWidgetProps
-FIXME: The auto validate in the password field is not working properly when change pwd
-FIXME: After the password correct need to click twice on the Login button to login in
