$(document).ready(() => {

    // Manage Users View ----------------------------------------------------------------------------------

    $("#button_manage_user").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const name = $("#iUserName").val();
        const role = $("#iUserRole").val();
        const rfid = $("#iUserRFID").val();

        const removeUser = document.querySelector("#popUpManageUser").getAttribute("data-remove");

        // remove and add user functionality
        if (removeUser === false) {

            $.ajax({
                
                url: "/addUser",
                method: "PUT",
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

                    // clears input fields
                    $("#iUserName").val("");
                    $("#iUserRole").val("");
                    $("#iUserRFID").val("");
                }
            });
        
        } else {

            const targetID = getDatabaseIDByLabel(name);

            $.ajax({
                
                url: "/removeUser",
                method: "DELETE",
                contentType: "application/json",
                data: JSON.stringify({
                    id: targetID
                }),

                success: (res) => {

                    $("#pManageUserResponse").css("display", "block");

                    if (res.status !== 200) {
                        
                        $("#pManageUserResponse").text("Failed to remove User. Error Code: " + res.status);
                        return;
                    }

                    $("#pManageUserResponse").text("Successfully removed User");
                    
                    $.fn.loadManageUserView();

                    // clears input fields
                    $("#iUserName").val("");
                }
            });
        }
    });

    // Manage Locations View ------------------------------------------------------------------------------

    $("#button_manage_location").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const locationName      = $("#iLocationName").val();
        const locationMACAdress = $("#iLocationMACAdress").val();
        
        const removeLocation = document.querySelector("#popUpManageLocation").getAttribute("data-remove");

        // remove and add user functionality
        if (removeLocation === false) {

            const targetID = getDatabaseIDByLabel(locationName);

            $.ajax({
                
                url: "/addLocation",
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({
                    id: targetID,
                }),

                success: (res) => {

                    $("#pManageLocationResponse").css("display", "block");

                    if (res.status !== 200) {
                        
                        $("#pManageLocationResponse").text("Failed to create new User. Error Code: " + res.status);
                        return;
                    }

                    $("#pManageLocationResponse").text("Successfully created a new User");
                    
                    $.fn.loadManageLocations();

                    // clears input fields
                    $("#iLocationName").val("");
                    $("#iLocationMACAdress").val("");
                }
            });
        
        } else {

            $.ajax({
                
                url: "/removeLocation",
                method: "DELETE",
                contentType: "application/json",
                data: JSON.stringify({
                    label: locationName,
                }),

                success: (res) => {

                    $("#pManageLocationResponse").css("display", "block");

                    if (res.status !== 200) {
                        
                        $("#pManageLocationResponse").text("Failed to create new Location. Error Code: " + res.status);
                        return;
                    }

                    $("#pManageLocationResponse").text("Successfully created a new Location");
                    
                    $.fn.loadManageLocations();

                    // clears input fields
                    $("#iLocationName").val("");
                    $("#iLocationMACAdress").val("");
                }
            });
        }
    });
});


// searches all elements of class trCurData for id trDate + imLabel
function getDatabaseIDByLabel(imTargetLabel) {

    const tableData = document.querySelectorAll(".trCurData");

    tableData.forEach(obj => {
        
        const objHTLMID = obj.id;

        if (objHTLMID === "trData" + imTargetLabel) {

            const targetID = obj.getAttribute("data-valueID");

            return targetID;
        }
    });
    
    console.error("Invalid Input. " + imTargetLabel + " cannot be found");
    return 0;
}