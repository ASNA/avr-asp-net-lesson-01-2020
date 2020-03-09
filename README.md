### AVR for .NET ASP.NET Example 01

>[Show annotated code](https://asna.github.io/avr-asp-net-lesson-01-2020)

This example shows: 
* Master pages 
* User authentication with ASP.NET Forms Authentication
* Runtime Database Name selection
* ListView control to render with a grid-like view
* Bootstrap to create a mobile-first user interface
* Using JavaScript to tweak ASP.NET rendered markup
* Classes to separate DB and business logic from ASP.NET code-behind logic
* Session start event to perform session startup 

### Mobile screen shots 

![](https://asna.com/filebin/marketing/article-figures/avr-asp-net-examples-2020/example-01-login.aspx-mobile.png)

<small>Figure 1a. Login screen</small>

![](https://asna.com/filebin/marketing/article-figures/avr-asp-net-examples-2020/example-01-mobile-grid.png)

<small>Figure 1b. Customer data rendered with ListView control</small>

### Desktop screen shots 

![](https://asna.com/filebin/marketing/article-figures/avr-asp-net-examples-2020/example-01-login.aspx.png)

<small>Figure 2a. Login screen</small>

![](https://asna.com/filebin/marketing/article-figures/avr-asp-net-examples-2020/example-01-grid.png)

<small>Figure 2b. Customer data rendered with ListView control</small>

* Master pages 
* User authentication with ASP.NET Forms Authentication
* Runtime Database Name selection
* ListView control to render with a grid-like view
* Bootstrap to create a mobile-first user interface
* Using JavaScript to tweak ASP.NET rendered markup
* Classes to separate DB and business logic from ASP.NET code-behind logic
* Session start event to perform session startup 

### A quick look a the folder structure

Before we dig into detail on each of the above sections, lets preview the basic directory structure for this ASP.NET Web application. This is an opinionated structure and you can change it any way you see fit. However, we don't recommend that until you are very comfortable with ASP.NET. The structure presented here as worked well for us for a long time and many Web apps.
```
.
└── root
    ├── App_Code        AVR Classes
    ├── Bin             Referenced binary files
    ├── docs            * See note on this folder below
    ├── public          public folder
    │   ├── vendor      Vendor-provided CSS and JS
    │   ├── css         App-specific CSS
    │   ├── images      App-specific images
    │   ├── js          App-specific JavaScript
    │   └── views       ASPX pages available to anonymous users
    ├── pycco           * See note on this folder below
    └── views           ASPX pages for authenticated users
```

The `pycco` folder isn't really part of this application. It contains a Python script and related files that produce [annotated code](https://asna.github.io/avr-asp-net-lesson-01-2020/) which is placed in the `docs` folder. The `pycco` folder can be deleted--you're not likely to need it. You probably won't produce annotated code and can use the `docs` folder for you own projects' documentation.

`Global.asax`, `web.config`, `web.debug.config`, and master pages are stored in the root. 

You may also see `.gitignore` and `README.md` files in the root. These are are for Git and GitHub source control. 

### Master Pages



#### Master pages 

Master page info here

### User authentication with ASP.NET Forms Authentication

In almost any Web application you'll want some kind of user authentication. ASP.NET has authentication, called Forms Authentication, available and it is very easy and flexible to use. Once enabled, prevents unauthorized users from using any part the site. This is also a way to configure exceptions to allow non-authorized users to see some parts of the site. 

While Forms Authentication offers the framework to protect your site from unauthorized users, it leaves how you authentication users up to you. For example, you could:

* Authenticate a user and password against the IBM i. This method is often used for sites intended for internal users with IBM i user accounts. 

* Authenticate against an external authentication database. This could be a table on the IBM i where you keep track of site users, it could be Microsoft's Active Directory, or even something as crude a text file on the Web server. You're in charge of this mechanism and can create it any way you want to. 

User authentication is enabled by:
* adding some configuration values to the `web.config` file 
* Providing a login form that prompts for user ID and password
* Add authentication logic to the login form 

When you create a new AVR ASP.NET Website with Visual Studio the `web.config` file shown below in Figure 3a is created for you. The only thing this basic configuration does is set debug mode to `false`. During development you'll want the `debug` value to be `true`. However, the first time you run the app from within Visual Studio, you'll be asked if its OK to change this value to `true`. So you don't have to worry about explicitly changing it to `true.`

> It is important to remember that you do have to worry about explicitly setting `debug` to false before deploying the application for production. Debug mode disables all caching and you would never want that in a production environment. 
```
    <?xml version="1.0"?>

    <!--
    For more information on how to configure your ASP.NET application, please visit
    http://go.microsoft.com/fwlink/?LinkId=169433
    -->

    <configuration>

        <system.web>
            <compilation debug="false" targetFramework="4.5.2" />
        </system.web>

    </configuration>
```
<small>Figure 3. Basic standard `web.config`</small>

#### To configure ASP.NET Forms Authentication 

##### 1. Add configuration values to `web.config`

Add these two XML nodes in the <system.web> node directly under the `<compilation>` node:
```
<authentication mode="Forms">
    <forms loginUrl="views/login.aspx" timeout="30"/>
</authentication>

<authorization>
    <deny users="?"/>
</authorization>  
```
<small>Figure 4a. The `authentication` and `authorization` nodes needed for basic Forms Authentication.</small>

The `authentication` node enables Forms Authentication. It's attributes are:

* **loginUrl** - Specifies the URL to which the request is redirected for logon if no valid authentication cookie is found. The default value is default.aspx.
* **timeout** - Specifies the amount of time, in integer minutes, after which the cookie expires. 

> `web.config` settings are all case-sensitive! 

The `authorization` node denies access to all anonymous users to all pages in the application. ASP.NET has a built-in exception for this global denial for the page at the URL specified with `loginUrl` from the `authentication` node.

[Read more about all of the `web.config` schema and its values.](https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-1.1/b5ysx397%28v%3dvs.71%29)

Add this node to the root of `web.config`:
```
<location path="public">
    <system.web>
        <authorization>
            <allow users="?" />
        </authorization>
    </system.web>
</location>
```
<small>Figure 4b. The `location` node needed for basic Forms Authentication.</small>

The `location` node provides exceptions to the global `authorization` node from the previous step. This `location` says that any user can access content or pages in the root's `public` folder. This is where you should put all runtime assets such as JavaScript, CSS, and images. 

Put any .ASPX pages that should be accessible by anonymous users in the `public/views` folder. 

Having made these changes, the full `web.config` should now look like the one shown below in Figure 4c. 

```
    <?xml version="1.0"?>

    <!--
    For more information on how to configure your ASP.NET application, please visit
    http://go.microsoft.com/fwlink/?LinkId=169433
    -->
    <configuration>

    <system.web>
        <compilation debug="true" targetFramework="4.6.1"/>
        
        <!-- 
        // Change #1: Enable Forms Authentication mode.
        -->    
        <authentication mode="Forms">
            <forms name="Loginform" loginUrl="views/login.aspx" timeout="30"/>
        <!-- 
        // The timeout value is specified in minutes. 
        // This value also determines how long the authentication cookie,
        // if used, persists.
        -->
        </authentication>
            
        <!--
        // Deny all unauthorized users from all pages unconditionally.
        -->
        <authorization>
            <deny users="?"/>
        </authorization>  
        <!-- 
        // End of change #1.
        -->    
    </system.web>

    <!-- 
    // Change #2: Unconditionally allow all users access to any 
    // pages in the 'public' folder. This provides exceptions to 
    // the ' deny users'rule above. Add as a many <location...> 
    // chunks as necessary.
    -->
    <location path="public">
        <system.web>
            <authorization>
                <allow users="?" />
            </authorization>
        </system.web>
    </location>
    <!-- 
    // End of change #2.
    -->    

    </configuration>    
```    

<small>Figure 4c. The full `web.config` with user authentication specified</small>

##### Create a login form 

The basic logic for Forms Authentication is: 
* User requests a given page (let's say `Index.aspx`)
* ASP.NET checks to see if the user has a previously-created, and va:lid, credential cookie
    * If so, the user is redirected to the requested page. 
    * If not the user is redirected to the login page.
* The login page checks to see if the credentials entered are valid:
    * If so, the user is redirected to the requested page. 
    * If not the user is redirected to the login page with a login error message displayed.

To fetch user credentials, ASP.NET provides a [login control](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.login?view=netframework-4.8), but it isn't responsive and is pretty easy to replicate, so we don't use it. The login screens and this app uses are shown at the top of this document in Figures 1a (mobile) and Figure 2a (desktop). 

> This application uses the [Bootstrap 4.x CSS library](https://getbootstrap.com/). We'll discuss that topic later, so the code below doesn't include any CSS. In this section we focus on login logic. 

The login UI needs x controls:

* A user ID textbox
* Required field validator for the user ID
* A password textbox 
* A required field validator for the password
* A remember-me checkbox (to govern caching credientials in a cookie)
* A button to initiate the login 
* A custom validator to show a error if the login failed

These controls, without CSS, are shown below in Figure 5a:
```
            <asp:TextBox 
                         ID="user" 
                         runat="server">
            </asp:TextBox>

            <asp:RequiredFieldValidator 
                         ID="userRequiredValidator" 
                         ControlToValidate="user" 
                         runat="server" 
                         ErrorMessage="Please enter user name" Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:TextBox  
                         ID="password" 
                         runat="server" 
                         TextMode="Password">
            </asp:TextBox>

            <asp:RequiredFieldValidator 
                         ID="passwordRequiredValidator" 
                         ControlToValidate="user"
                         runat="server" 
                         ErrorMessage="Please enter your password" Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:CheckBox 
                         ID="rememberme" 
                         runat="server" />

            <asp:Button 
                         ID="buttonlogin"
                         runat="server" 
                         Text="Login" />                         

            <asp:CustomValidator 
                         ID="loginFailedValidator" 
                         runat="server" 
                         ErrorMessage="Login failed" 
                         Display="Dynamic">
            </asp:CustomValidator>
```
<small>Figure 5a. The basic controls needed for user login.</small>

The `buttonLogin's` `Click` event provides the login logic. 
```
BegSr buttonlogin_Click Access(*Private) Event(*This.buttonlogin.Click)
    DclSrParm sender Type(*Object)
    DclSrParm e Type(System.EventArgs)

    DclFld ex Type(ASNA.DataGate.Common.dgException) 

    // Check credentials against IBM i.
    ex = CheckIBMiCredentials(user.Text, password.Text)
    // The user was validated if no exception was thrown.
    If ex = *Nothing 
        // After validating a user, RedirectFromLoginPage redirects
        // the user to the page requested.
        FormsAuthentication.RedirectFromLoginPage(user.Text, rememberme.Checked) 
    Else 
        // Show a detailed error message only if debug mode is on. 
        If (context.Current.IsDebuggingEnabled)     
            loginFailedValidator.ErrorMessage = ex.Message 
        Else 
            LoginFailedValidator.ErrorMessage = 'Login failed'
        EndIf
    EndIf
EndSr
```
<small>Figure 5b. `buttonLogin's` click event code.</small>

Figure 5b's logic validates the credentials entered against an IBM i (we'll at that code in a moment). If that function validates the credentials the `FormsAuthentication.RedirectFromLoginPage` method shows the page the user originally requested. The user name and the status of the "remember me" checkbox is passed as arguments to the `RedirectFromLoginPage` method. The user name is stored internally and can easily be fetched for display or other users. If the "remember me" checkbox was checked (its value was true) the user credentials cookies is created (or updated with a new expiry date)

Note that the logic in 5B uses ASP.NET's globally available `context.Current.IsDebuggingEnabled` value to determine what error message should be displayed. If is running under debug, the exact CPF error message is shown. If the program is not running under debug, a nebulous "Login failed" error message is shown. This limits the login status information provided to avoid potential security risks (don't give Internet black hats any more clues than necessary!). 

```
BegFunc CheckIBMiCredentials Type(ASNA.DataGate.Common.dgException) 
    DclSrParm User     Type(*String) 
    DclSrParm Password Type(*String) 

    DGDB.DBName = Session['dbname'].ToString()
    DGDB.User = User
    DGDB.Password = Password

    Try 
        Connect DGDB 
    Catch ex Type(ASNA.DataGate.Common.dgException)
        LeaveSR ex 
    Finally
        Disconnect DGDB 
    EndTry 

    LeaveSr *Nothing 
EndFunc 
```
<small>Figure 5c. A way to validate against the IBM i.</small>

The logic in Figure 5b validates the credentials calling the `CheckIBMiCredentials` function which tries to connect to the IBM i with the credentials provided (as shown directly above in Figure 5c). If the login succeeds the function returns *Nothing and it it fails the function returns the related exception (which contains the IBM i CPF error message). 

```
BegFunc CheckWebUserCredentials Type(*Boolean)
    DclSrParm User     Type(*String) 
    DclSrParm Password Type(*String) 

    // Check data store for user with given password. 
    // For example, you create a "user" table on the IBM i which 
    // has user_id and hash_password columns (at least). Check this 
    // table for a user's row and compare the hash_password value against
    // the hashed value of the password the user provided. 
    
    // Don't store passwords in plain text! Store only [hashed, salted passwords](https://auth0.com/blog/hashing-passwords-one-way-road-to-security/)
    // in your data store. 

    // This is no test here so everyone gets validated. 
    LeaveSr *True 
EndFunc 
```

### Runtime Database Name selection
### ListView control to render with a grid-like view
### Bootstrap to create a mobile-first user interface
### Using JavaScript to tweak ASP.NET rendered markup
### Classes to separate DB and business logic from ASP.NET code-behind logic
### Session start event to perform session startup 
