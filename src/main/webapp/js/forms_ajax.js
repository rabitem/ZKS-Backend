$(document).ready(() => {

    // manage (add & remove) user form
    $("#button_manage_user").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const userName = $("#iUserName").val();
        const userRole = $("#iUserRole").val();
        const userRFID = $("#iUserRFID").val();

        // execute post request
        $.ajax({
            
            url: "/addNewUser",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                newUserName: userName,
                newUserRole: userRole,
                newUserRDIF: userRFID
            }),

            success: (res) => {

                $("#pManageUserResponse").css("display", "block");

                if (res.status !== 200) {
                    
                    $("#pManageUserResponse").text("Failed to create new User. Error Code: " + res.status);
                    return;
                }

                $("#pManageUserResponse").text("Successfully created a new User");
                
                $.fn.loadManageUserView();
            }
        });
    });
});