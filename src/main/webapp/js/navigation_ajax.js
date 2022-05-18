// jquery navigation ajax ------------------------------------------------------------

$(document).ready(() => {

    // load inital view: manage users and enable buttons of view
    $.fn.loadManageUserView();
    
    // change views: manage users
    $("#navManageUsers").click((event) => {
        
        event.preventDefault();
        $.fn.loadManageUserView();
    });

    // change views: manage locations
    $("#navManageLocations").click((event) => {
    
        event.preventDefault();
        $.fn.loadManageLocations();
    });

    // change views: manage authorizations
    $("#navManageAccess").click((event) => {

        event.preventDefault();
        $.fn.loadManageAuthorizations();
    });

    // change views: view temparatures
    $("#navTemparature").click((event) => {

        event.preventDefault();
        $.fn.loadTempView();
    });

    // change views: view logs
    $("#navLogs").click((event) => {

        event.preventDefault();
        $.fn.loadLogsViews();
    });
});

// sub pages functions ---------------------------------------------------------------

$.fn.loadManageUserView = async () => {

    await $.fn.loadNewMainContent("/manageUsers", "- Manage Users");
    initializeAddUsers();
    initializeRemoveUsers();
}

$.fn.loadManageLocations = async () => {

    await $.fn.loadNewMainContent("/manageLocations", "- Manage Locations");
    initializeManageLocations();
}

$.fn.loadManageAuthorizations = async () => {

    await $.fn.loadNewMainContent("/manageAuthorizations", "- Manage Authorizations");
    initializeManageAuthorizations();
}

$.fn.loadTempView = () => {

    $.fn.loadNewMainContent("/viewTemperature", "- View Temperatures");
}

$.fn.loadLogsViews = () => {

    $.fn.loadNewMainContent("/viewLogs", "- View Logs");
}

// insert sub page content -----------------------------------------------------------

$.fn.loadNewMainContent = (imRoute, imViewName) => {

    // remove previous content
    $("#cMainContentSubFolder").remove();

    // enable loading visuals
    $("#spinnerMainContent").css("display", "block");

    // change main header to match view name
    $("#hCurView").text(imViewName);

    return $.ajax({
        
        url: imRoute,
        method: "GET",
        dataType: "html",
        contentType: "application/json; charset=utf-8",
                    
        success: (res) => {

            // add new main content
            $("#spinnerMainContent").css("display", "none");
            $(".cMainContent").append(res);
        }
    });
};