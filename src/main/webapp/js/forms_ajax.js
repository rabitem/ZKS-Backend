$(document).ready(() => {

    // Add Users Form ----------------------------------------------------------------------------------

    $("#addUserForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const name = $("#iUserName").val();
        const role = $("#pUserRole").text();
        const rfid = $("#iUserRFID").val();

        $.ajax({

            url: "/addUser",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                name: name,
                role: role,
                rfid: rfid
            }),

            success: () => {

                updateStatusText("#pAddUserResponse", 200, "Successfully created a new user!");

                $.fn.loadManageUserView();

                // clear input fields
                $("#iUserName").val("");
                $("#iUserRole").val("");
                $("#iUserRFID").val("");
            },

            error: (err) => {

                updateStatusText("#pAddUserResponse", err.status,
                    "Failed to add a new User! Error Code: " + err.status);
            }
        });
    });

    // Remove Users Form -------------------------------------------------------------------------------

    $("#removeUserForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();
        
        const id = $("#pRemoveUserDropFirst").attr("data-id");
        
        $.ajax({

            url: "/removeUserById",
            method: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({
                id: id
            }),

            success: () => {

                updateStatusText("#pRemoveUserResponse", 200, "Successfully removed user!");

                $.fn.loadManageUserView();

            },

            error: (err) => {

                updateStatusText("#pRemoveUserResponse", err.status,
                    "Failed to remove User! Error Code: " + err.status);
            }
        });
    });

    // Add Locations View ------------------------------------------------------------------------------

    $("#addLocationForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const locationName      = $("#iLocationName").val();
        const locationMACAdress = $("#iLocationMACAdress").val();

        $.ajax({

            url: "/addLocation",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                label: locationName,
                macAddress: locationMACAdress
            }),

            success: () => {

                updateStatusText("#pAddLocationResponse", 200, "Successfully added new location " + locationName + "!");

                $.fn.loadManageLocations();

                // clear input fields
                $("#iUserName").val("");
                $("#iUserRole").val("");
                $("#iUserRFID").val("");
            },

            error: (err) => {

                updateStatusText("#pAddLocationResponse", err.status,
                    "Failed to add a new Location! Error Code: " + err.status);
            }
            
        });
    });

    // Remove Locations View ----------------------------------------------------------------------------
       
    $("#removeLocationForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        const id = $("#pRemoveLocationDropFirst").attr("data-id");
        const name = $("#pRemoveLocationDropFirst").val();

        $.ajax({

            url: "/removeLocationById",
            method: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
            }),

            success: () => {

                updateStatusText("#pRemoveLocationResponse", 200, "Successfully removed location " + name + "!");

                $.fn.loadManageLocations();

            },

            error: (err) => {

                updateStatusText("#pRemoveLocationResponse", err.status,
                    "Failed to remove location! " + name +  " Error Code: " + err.status);
            }
        });
    });

    // Add Authorization View ---------------------------------------------------------------------------

    $("#addAuthorizationForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const locationId = $("#pAddAuthorizationLocationDropdownFirst").attr("data-id");
        const userId     = $("#pAddAuthorizationDropdownFirst").attr("data-id");

        $.ajax({
            
            url: "/addAuthorization",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                locationId: locationId,
                userId: userId
            }),

            success: () => {
                
                updateStatusText("#pAddAuthorizationResponse", 200,
                    "Successfully granted user " + userId + " access to location: " + locationId);

                $.fn.loadManageAuthorizations();
            }, 
            
            error: (err) => {

                if (err.status === 409) {
                    
                    updateStatusText("#pAddAuthorizationResponse", err.status,
                        "User already has access to this location");

                } else {
                    
                    updateStatusText("#pAddAuthorizationResponse", err.status,
                        "Failed to create new Authorisation. Error Code: " + err.status);
                }
            }
        });
    });

    // Remove Authorization View ---------------------------------------------------------------------------

    $("#removeAuthorizationForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input field
        const id = $("#pRemoveAuthorizationLocationDropdownFirst").attr("data-id");

        $.ajax({
            
            url: "/removeAuthorizationById",
            method: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
            }),

            success: () => {
                    
                updateStatusText("#pAddAuthorizationResponse", 200,
                    "Successfully removed authorization");

                $.fn.loadManageAuthorizations();
            }, 
            
            error: (err) => {

                updateStatusText("#pRemoveAuthorizationResponse", err.status,
                    "Failed to delete Authorisation. Error Code: " + err.status);
            }
        });
    });
});

// searches all elements of class trCurData for id trDate + imLabel ------------------------------------------------

function getDatabaseIDByLabel(imTargetLabel) {

    const tableData = document.querySelectorAll(".trCurData");

    for (let i = 0; i < tableData.length; i++) {
        const obj = tableData[i];

        if (obj.id === "trData" + imTargetLabel) {
            return obj.getAttribute("data-valueID");
        }
    }

    console.error("Invalid Input. " + imTargetLabel + " cannot be found");
    return 0;
}

// updates information paragraph for a specific window --------------------------------------------------------------

function updateStatusText(imElementID, imStatus, imMessage) {

    const statusObj = document.querySelector(imElementID);
    statusObj.style.display = "block";

    if (imStatus === 200) {
        statusObj.style.color = "green";
    } else {
        statusObj.style.color = "red";
    }

    statusObj.innerHTML = imMessage
}