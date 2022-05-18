$(document).ready(() => {

    // Manage Users View ----------------------------------------------------------------------------------

    $("#updateUserForm").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const name = $("#iUserName").val();
        const role = $("#iUserRole").val();
        const rfid = $("#iUserRFID").val();

        const removeUser = document.querySelector("#popUpManageUser").getAttribute("data-remove");

        // remove and add user functionality
        if (removeUser === "false") {

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

                    updateStatusText("#pManageUserResponse",rhx.status, messageStatus);
                    
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
                
                url: "/removeUserById",
                method: "DELETE",
                contentType: "application/json",
                data: JSON.stringify({
                    id: targetID
                }),

                success: (res, statusText, rhx) => {

                    let messageStatus = "Successfully removed User";
                    
                    if (rhx.status !== 200) {
                        messageStatus = "Failed to remove User. Error Code: " + rhx.status;
                    }

                    updateStatusText("#pManageUserResponse",rhx.status, messageStatus);
                    
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
           
            $.ajax({
                
                url: "/addLocation",
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({
                    label: locationName,
                    macAdress: locationMACAdress
                }),

                success: (res, statusText, rhx) => {
                
                    let messageStatus = "Successfully created a new Location";
                    
                    if (rhx.status !== 200) {
                        messageStatus = "Failed to create new Location. Error Code: " + rhx.status;
                    }

                    updateStatusText("#pManageLocationResponse",rhx.status, messageStatus);

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

                    updateStatusText("#pManageLocationResponse",rhx.status, messageStatus);

                    $.fn.loadManageLocations();

                    // clears input fields
                    $("#iLocationName").val("");
                    $("#iLocationMACAdress").val("");
                }
            });
        }
    });

    // Manage Authorization View ---------------------------------------------------------------------------

    $("#button_manage_Authorization").on("submit", (event) => {

        // prevents POST form to refresh the page
        event.preventDefault();

        // retrieves data from input fields
        const locationName = $("#iAuthLocationName").val();
        const userName     =  $("#iAuthUserName").val();
        
        const removeLocation = document.querySelector("#popUpManageAuthorization").getAttribute("data-remove");

        // remove and add user functionality
        if (removeLocation === false) {
            
            $.ajax({
                
                url: "/addAuthorization",
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({
                    label: locationName,
                    name: userName
                }),

                success: (res, statusText, rhx) => {
                
                    let messageStatus = "Successfully granted user " + userName + " access to location: " + locationName;
                    
                    if (rhx.status !== 200) {
                        messageStatus = "Failed to create new Authorisation. Error Code: " + rhx.status;
                    }

                    updateStatusText("#pManageAuthorizationResponse",rhx.status, messageStatus);

                    $.fn.loadManageAuthorizations();

                    // clears input fields
                    $("#iAuthLocationName").val("");
                    $("#iAuthUserName").val("");
                }
            });
        
        } else {

            const targetAuthID = getDatabaseIDByLabel(userName + locationName);
            
            $.ajax({
                
                url: "/removeAuthorizationById",
                method: "DELETE",
                contentType: "application/json",
                data: JSON.stringify({
                    id: targetAuthID,
                }),

                success: (res, statusText, rhx) => {
                
                    let messageStatus = "Successfully granted user " + userName + " access to location: " + locationName;
                    
                    if (rhx.status !== 200) {
                        messageStatus = "Failed to create new Authorisation. Error Code: " + rhx.status;
                    }

                    updateStatusText("#pManageAuthorizationResponse",rhx.status, messageStatus);

                    $.fn.loadManageAuthorizations();

                    // clears input fields
                    $("#iAuthLocationName").val("");
                    $("#iAuthUserName").val("");
                }
            });
        }
    });
});

// searches all elements of class trCurData for id trDate + imLabel ------------------------------------------------

function getDatabaseIDByLabel(imTargetLabel) {

    const tableData = document.querySelectorAll(".trCurData");

    for (let i = 0; i < tableData.length; i++) {
        const obj = tableData[i];
        console.log(obj.getAttribute("data-valueID"));

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