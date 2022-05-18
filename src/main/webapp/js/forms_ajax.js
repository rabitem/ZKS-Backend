$(document).ready(() => {

    // manage (add & remove) user form
    $("#button_manage_user").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const name = $("#iUserName").val();
        const role = $("#iUserRole").val();
        const rfid = $("#iUserRFID").val();

        // execute post request
        $.ajax({
            
            url: "/addUser",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                name: name,
                role: role,
                rfid: rfid
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