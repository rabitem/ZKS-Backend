$(document).ready(() => {

    // Add Users Form ----------------------------------------------------------------------------------

    $("#addUserForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const name = $("#iUserName").val();
        const role = $("#pUserRole").val();
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

            success: (res, statusText, rhx) => {

                let messageStatus = "Successfully created a new user";

                if (rhx.status !== 200) {
                    messageStatus = "Failed to create user. Error Code: " + rhx.status;
                }

                updateStatusText("#pAddUserResponse", rhx.status, messageStatus);

                $.fn.loadManageUserView();

                // clears input fields
                $("#iUserName").val("");
                $("#iUserRole").val("");
                $("#iUserRFID").val("");
            }
        });

    });

    // Remove Users Form ----------------------------------------------------------------------------------
    $("#removeUserForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();
        const id = $("#pRemoveUserDropFirst").attr("data-id");
        const targetID = getDatabaseIDByLabel(id);

        $.ajax({

            url: "/removeUserById",
            method: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({
                id: id
            }),

            success: (res, statusText, rhx) => {

                let messageStatus = "Successfully removed User";

                if (rhx.status !== 200) {
                    messageStatus = "Failed to remove User. Error Code: " + rhx.status;
                }

                updateStatusText("#pRemoveUserResponse", rhx.status, messageStatus);

                $.fn.loadManageUserView();

                // clears input fields
                $("#iUserName").val("");
            }
        });
    });

    // Manage Locations View ------------------------------------------------------------------------------

    $("#updateLocationForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const locationName = $("#iLocationName").val();
        const locationMACAdress = $("#iLocationMACAdress").val();

        const removeLocation = document.querySelector("#popUpManageLocation").getAttribute("data-remove");

        // remove and add user functionality
        if (removeLocation === "false") {

            $.ajax({

                url: "/addLocation",
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({
                    label: locationName,
                    macAddress: locationMACAdress
                }),

                success: (res, statusText, rhx) => {

                    let messageStatus = "Successfully created a new Location";

                    if (rhx.status !== 200) {
                        messageStatus = "Failed to create new Location. Error Code: " + rhx.status;
                    }

                    updateStatusText("#pManageLocationResponse", rhx.status, messageStatus);

                    $.fn.loadManageLocations();

                    // clears input fields
                    $("#iLocationName").val("");
                    $("#iLocationMACAdress").val("");
                }
            });

        } else {

            const targetID = getDatabaseIDByLabel(locationName);

            $.ajax({

                url: "/removeLocationById",
                method: "DELETE",
                contentType: "application/json",
                data: JSON.stringify({
                    id: targetID,
                }),

                success: (res, statusText, rhx) => {

                    let messageStatus = "Successfully removed location " + locationName;

                    if (rhx.status !== 200) {
                        messageStatus = "Failed to remove location " + locationName + ". Error Code: " + rhx.status;
                    }

                    updateStatusText("#pManageLocationResponse", rhx.status, messageStatus);

                    $.fn.loadManageLocations();

                    // clears input fields
                    $("#iLocationName").val("");
                    $("#iLocationMACAdress").val("");
                }
            });
        }
    });

    // Add Authorization View ---------------------------------------------------------------------------
    $("#addAuthorizationForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const locationId = $("#pAddAuthorizationLocationDropdownFirst").attr("data-id");
        const userId = $("#pAddAuthorizationDropdownFirst").attr("data-id");

        // remove and add user functionality
        $.ajax({
            url: "/addAuthorization",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                locationId: locationId,
                userId: userId
            }),

            success: (res, statusText, rhx) => {
                let messageStatus = "Successfully granted user " + userId + " access to location: " + locationId;

                if (rhx.status !== 200) {
                    messageStatus = "Failed to create new Authorisation. Error Code: " + rhx.status;
                }

                updateStatusText("#pAddAuthorizationResponse", rhx.status, messageStatus);

                $.fn.loadManageAuthorizations();
            }, error: (err) => {
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
});

// Remove Authorization View ---------------------------------------------------------------------------
$("#removeAuthorizationForm").on("submit", (event) => {

    // prevents POST form to refresh the page
    event.preventDefault();

    // retrieves data from input fields
    const id = $("#pRemoveAuthorizationLocationDropdownFirst").attr("data-id");

    // remove and add user functionality
    $.ajax({
        url: "/removeAuthorizationById",
        method: "DELETE",
        contentType: "application/json",
        data: JSON.stringify({
            id: id,
        }),

        success: (res, statusText, rhx) => {
            let messageStatus = "Successfully removed authorization";

            if (rhx.status !== 200) {
                messageStatus = "Failed to remove authorization. Error Code: " + rhx.status;
            }

            updateStatusText("#pAddAuthorizationResponse", rhx.status, messageStatus);

            $.fn.loadManageAuthorizations();
        }, error: (err) => {
            updateStatusText("#pRemoveAuthorizationResponse", err.status,
                "Failed to delete Authorisation. Error Code: " + err.status);
        }
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