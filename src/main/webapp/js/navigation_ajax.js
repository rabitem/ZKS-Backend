// jquery navigation ajax ------------------------------------------------------------

$(document).ready(async () => {

    // load inital view: manage users
    $.fn.loadNewMainContent("/manageUsers", "- Manage Users");
    initializeManageUsers();
    
    // change views: epic roadmap View
    $("#navManageUsers").click(async (event) => {
        
        event.preventDefault();
        await $.fn.loadNewMainContent("/manageUsers", "- Manage Users");
        initializeManageUsers();

    });
});

// jquery function definitions ----------------------------------------------------

$.fn.loadNewMainContent = (imRoute, imViewName) => {

    // remove previous content
    $("#cMainContentSubFolder").remove();

    // enable loading visuals
    $("#spinnerMainContent").css("display", "block");

    // change main header to match view name
    $("#hCurView").text(imViewName);

    return $.ajax({
        
        url: imRoute,
        method: "POST",
        dataType: "html",
        contentType: "application/json; charset=utf-8",
                    
        success: (res) => {

            // add new main content
            $("#spinnerMainContent").css("display", "none");
            $(".cMainContent").append(res);
        }
    });
};