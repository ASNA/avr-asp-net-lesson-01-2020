<link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">

### AVR for .NET ASP.NET Example 01

[Show annotated code](https://asna.github.io/avr-asp-net-lesson-01-2020)

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

### Master Pages



#### Master pages 

Master page info here

#### User authentication with ASP.NET Forms Authentication

When you create a new AVR ASP.NET Website with Visual Studio the `web.config` file shown below in Figure 3a is created for you. The only thing this basic configuration does is set debug mode to `false`. During development you'll want the `debug` value to be `true`. However, the first time you run the app from within Visual Studio, you'll be asked if its OK to change this value to `true`. So you don't have to worry about explicitly changing it to `true.`

> It is important to remember that you do have to worry about explicitly setting `debug` to false before deploying the application for production. Debug mode disables all caching and you would never want that in a production environment. 

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

<small>Figure 3a. Basic standard web.config</small>

In almost any application you'll want some kind of user authentication. ASP.NET has authentication, called Forms Authentication, available and it is very easy and flexible to use. Once enabled, prevents unauthorized users from using any part the site. This is also a way to configure exceptions to allow non-authorized users to see some parts of the site. 

While Forms Authentication offers the framework to protect your site from unauthorized users, it leaves how you authentication users up to you. For example, you could:

* Authenticate a user and password against the IBM i. This method is often used for sites intended for internal users with IBM i user accounts. 

* Authenticate against an external authentication database. This could be a table on the IBM i where you keep track of site users, it could be Microsoft's Active Directory, or even something as crude a text file on the Web server. You're in charge of this mechanism and can create it any way you want to.

    <?xml version="1.0"?>

    <!--
    For more information on how to configure your ASP.NET application, please visit
    http://go.microsoft.com/fwlink/?LinkId=169433
    -->
    <configuration>

    <system.web>
        <compilation debug="true" targetFramework="4.6.1"/>
        
        <!-- 
        // Enable Forms Authentication mode.
        -->    
        <authentication mode="Forms">
            <forms name="Loginform" loginUrl="views/login.aspx" timeout="30"/>
        <!-- 
        // The timeout value is specified in minutes. 
        // This value also determines how long the authentication cookie, if used,
        // persists.
        -->
        </authentication>
            
        <!--
        // Deny all unauthorized users from all pages unconditionally.
        -->
        <authorization>
            <deny users="?"/>
        </authorization>  
    </system.web>

    
    <!-- 
    // Unconditionally allow all users access to any pages in the 
    // 'public' folder. This provides exceptions to the rule above.
    // Add as a many of these chunks as necessary.
    -->
    <location path="public">
        <system.web>
        <authorization>
            <allow users="?" />
        </authorization>
        </system.web>
    </location>

    </configuration>    

<small>Figure 3b. web.config with user authentication specified</small>


### Runtime Database Name selection
### ListView control to render with a grid-like view
### Bootstrap to create a mobile-first user interface
### Using JavaScript to tweak ASP.NET rendered markup
### Classes to separate DB and business logic from ASP.NET code-behind logic
### Session start event to perform session startup 
