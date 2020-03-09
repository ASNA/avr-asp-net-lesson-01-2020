<%@ Page Language="AVR" MasterPageFile="~/MasterPageNav.master" AutoEventWireup="false" CodeFile="Index.aspx.vr" Inherits="Index" Title="Untitled Page" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
<%--#
// HttpContext.Current.IsDebuggingEnabled is true when the application 
// is running under debug. This lets you conditionally include different 
// code for debug/production. In this case the same code is included but 
// it would be good if the CSS were combined and minified for production.
// If you did that the combined and minified CSS would be specified 
// for the production version.
#--%>
    <%
    If (HttpContext.Current.IsDebuggingEnabled)     
    %>
    <link rel="stylesheet" href="/public/css/one-column-layout.css">
    <link rel="stylesheet" href="/public/css/grid.css">
    <%
    Else
    %>
    <link rel="stylesheet" href="/public/css/one-column-layout.css">
    <link rel="stylesheet" href="/public/css/grid.css">
    <%
    EndIf 
    %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">

<div class="container">
   <header>
      Customer List
   </header>
    
   <main>

 <%--#
// The search form isn't used in this version the app.
#--%>
       <!-- Search form -->
       <div class="mt-0 mb-2">
           <div class="position-to-container">
               <div class="">
                   <asp:TextBox ID="PositionTo" runat="server"></asp:TextBox>
               </div>
               <div class="">
                   <asp:LinkButton ID="linkbuttonPositionTo" class="btn btn-primary btn-sm" runat="server">Position-to</asp:LinkButton>
               </div>
           </div>
       </div>

<%--#
// The ListView provides far greater control over rendered output than the GridView does. 
// In this [Bootstrap CSS](https://getbootstrap.com/) enables a good way to render a responsive 
// grid. 
#--%>
 
       <div class="grid-wrapper">
        <asp:ListView ID="listviewCustomers" runat="server" OnItemCommand="listviewCustomersRowAction">
            <LayoutTemplate>

                <div class="row-header-wrapper">
                    <div class="row row-header">
                        <div class="col-sm heading">
                            Name
                        </div>
                        <div class="col-md heading">
                            City, State, Zip
                        </div>
                        <div class="col-sm heading">
                            Actions
                        </div>
                    </div>
                </div>

                <div class="row-header-wrapper-small">
                    <div class="row row-header">
                        <div class="col-md heading">
                            Customers
                        </div>
                    </div>
                </div>

                <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
            </LayoutTemplate>

            <ItemTemplate>
                <div class="row row-data">
                    <div class="col-sm">
                        <%# (Container.DataItem *As CMastNewL2_Entity).CMName.Trim() %>
                    </div>
                    <div class="col-md">
                        <%# (Container.DataItem *As CMastNewL2_Entity).CMCity.Trim() ++ 
                            ", " ++ 
                            (Container.DataItem *As CMastNewL2_Entity).CMState.Trim() ++ 
                            " " ++ 
                            (Container.DataItem *As CMastNewL2_Entity).CMPostCode.Trim() %>
                    </div>
                    <div class="col-sm">
                        <asp:LinkButton ID="linkbuttonUpdate" class="btn btn-primary btn-tiny" runat="server" 
                                CommandArgument="<%# Container.DisplayIndex %>" CommandName="updaterow">Update</asp:LinkButton>
                        <asp:LinkButton ID="linkbuttonEmail" class="btn btn-success btn-tiny" runat="server" 
                                CommandArgument="<%# Container.DisplayIndex %>" CommandName="sendemail">Email</asp:LinkButton>
                        <a href="update-customer?id=<%# (Container.DataItem *As CMastNewL2_Entity).CMCustNo.ToString().Trim()%>"
                            class="btn btn-warning btn-tiny">Select</a>
                    </div>                    
                </div>
            </ItemTemplate>
        </asp:ListView>
        </div>
   </main>
  
   <footer>
    </footer>
</div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" Runat="Server">
</asp:Content>
