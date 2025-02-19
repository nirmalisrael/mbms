using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using System.Web.UI.WebControls;
using Microsoft.AspNet.FriendlyUrls;

namespace MBMS_APP
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            routes.MapPageRoute("Admin Dashboard", "admin-dashboard", "~/WebUI/Dashboard/Dashboard.aspx");
            routes.MapPageRoute("Purchase Orders", "purchase-orders", "~/WebUI/Purchase/Orders.aspx");
            routes.MapPageRoute("Add Admin", "add-admin", "~/WebUI/Admin/AddAdmin.aspx");
            routes.MapPageRoute("New Request", "purchase-orders/new-request", "~/WebUI/Purchase/NewPurchaseRequest.aspx");
            routes.MapPageRoute("View Admin", "view-admin", "~/WebUI/Admin/ViewAdmin.aspx");
            routes.MapPageRoute("Add Staff", "add-staff", "~/WebUI/Staff/AddStaff.aspx");
            routes.MapPageRoute("View Staff", "view-staff", "~/WebUI/Staff/ViewStaff.aspx");
            routes.MapPageRoute("Member", "member", "~/WebUI/Member/Member.aspx");
            routes.MapPageRoute("Add Member", "add-member", "~/WebUI/Member/AddMember.aspx");

            // Support data
            routes.MapPageRoute("Role", "role", "~/WebUI/Support_Data/Role.aspx");
            routes.MapPageRoute("Organization", "organization", "~/WebUI/Support_Data/Organization.aspx");
            routes.MapPageRoute("Measurement", "measurement", "~/WebUI/Support_Data/Measurement.aspx");
            routes.MapPageRoute("Goods", "goods", "~/WebUI/Support_Data/Goods.aspx");
            routes.MapPageRoute("Purchase Status", "purchase-status", "~/WebUI/Support_Data/PurchaseStatus.aspx");
        }
    }
}
