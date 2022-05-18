// jquery navigation ajax ------------------------------------------------------------

$(document).ready(async () => {

    // load inital view: manage users and enable buttons of view
    $.fn.loadManageUserView();
    
    // change views: epic roadmap View
    $("#navManageUsers").click(async (event) => {
        
        event.preventDefault();
        $.fn.loadManageUserView();
    });
});

// sub pages functions ---------------------------------------------------------------

$.fn.loadManageUserView = async () => {

    await $.fn.loadNewMainContent("/manageUsers", "- Manage Users");
    initializeManageUsers();
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