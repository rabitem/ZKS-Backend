// Sidebar Collapse (Visual) -----------------------------------------------------------------

const objSidebarNavButton = document.querySelector(".cSidebarNavArrow");
const objSidebar          = document.querySelector(".cSidebar");

objSidebarNavButton.addEventListener("click", () => {
    
    objSidebar.classList.toggle("cSidebarClosed");

});

// Sidebar Item Select (Visual) ---------------------------------------------------------------

const objSidebarItems = document.querySelectorAll(".ulSidebarItem");

objSidebarItems.forEach((obj) => obj.addEventListener("click", updateSidebarSelectionVisuals));

function updateSidebarSelectionVisuals () {

    objSidebarItems.forEach((obj) => obj.classList.remove("ulSidebarItemActive"));

    this.classList.add("ulSidebarItemActive");
}

// Pop-Up Manage Users ------------------------------------------------------------------------

const manageUsersModal = document.querySelector("#popUpManageUser");
const manageUserClose  = document.querySelector("#btnCloseManageUser");
const manageUserStatus = document.querySelector("#pManageUserResponse");

function initializeManageUsers () {
 
    const addUserBtn = document.querySelector("#svgAddSign");
    
    // hide and show inputs, based on add/remove option
    const inputWrapperRole = document.querySelector("#inputWrapperRole");
    const inputWrapperRFID = document.querySelector("#inputWrapperRFID");
    const submitButton     = document.querySelector("#button_manage_location");
 
    // add new user
    addUserBtn.addEventListener("click", () => {
        
        manageUsersModal.style.display = "block";
        inputWrapperRole.style.display = "block";
        inputWrapperRFID.style.display = "block";

        manageUsersModal.setAttribute("data-remove", false);

        submitButton.value = "Add User";
    });

    // try to remove existing user
    const rmvUserBtn = document.querySelector("#svgRemoveSign");

    rmvUserBtn.addEventListener("click", () => {
        
        manageUsersModal.style.display = "block";
        inputWrapperRole.style.display = "none";
        inputWrapperRFID.style.display = "none";
    
        submitButton.value = "Remove User";

        manageUsersModal.setAttribute("data-remove", true);
    });
}

manageUserClose.addEventListener("click", () => {
    
    manageUsersModal.style.display = "none";
    manageUserStatus.style.display = "none";
    document.querySelector("#hManageUser").innerHTML = "Remove User";

});

// Pop-Up Manage Location -----------------------------------------------------------------------

const manageLocationsModal = document.querySelector("#popUpManageLocation");
const manageLocationClose  = document.querySelector("#btnCloseManageLocation");
const manageLocationStatus = document.querySelector("#pManageLocationResponse");

function initializeManageLocations () {
 
    const addLocationBtn = document.querySelector("#svgAddSignLocation");
    
    // hide and show inputs, based on add/remove option
    const inputWrapperRole = document.querySelector("#inputWrapperRole");
    const inputWrapperRFID = document.querySelector("#inputWrapperRFID");
    const submitButton     = document.querySelector("#button_manage_location");
    // add new Location
    addLocationBtn.addEventListener("click", () => {
        
        manageLocationsModal.style.display = "block";
        inputWrapperRole.style.display = "block";
        inputWrapperRFID.style.display = "block";

        manageLocationsModal.setAttribute("data-remove", false);

        submitButton.value = "Add Location";
    });

    // try to remove existing Location
    const rmvLocationBtn = document.querySelector("#svgRemoveSignLocation");

    rmvLocationBtn.addEventListener("click", () => {
        
        manageLocationsModal.style.display = "block";
        inputWrapperRole.style.display = "none";
        inputWrapperRFID.style.display = "none";
    
        submitButton.value = "Remove Location";

        manageLocationsModal.setAttribute("data-remove", true);
    });
}

manageLocationClose.addEventListener("click", () => {
    
    manageLocationsModal.style.display = "none";
    manageLocationStatus.style.display = "none";
    document.querySelector("#hManageLocation").innerHTML = "Remove Location";

});

// Pop-Up Manage Authorizations ----------------------------------------------------------------

const manageAuthsModal = document.querySelector("#popUpManageAuthorization");
const manageAuthClose  = document.querySelector("#btnCloseManageAuthorization");
const manageAuthStatus = document.querySelector("#pManageAuthorizationResponse");

function initializeManageAuthorizations () {
 
    const addAuthBtn   = document.querySelector("#svgAddSignAuthorization");
    const submitButton = document.querySelector("#button_manage_Authorization");
    
    // add new Auth
    addAuthBtn.addEventListener("click", () => {
        
        manageAuthsModal.setAttribute("data-remove", false);

        submitButton.value = "Add Auth";
    });

    // try to remove existing Auth
    const rmvAuthBtn = document.querySelector("#svgRemoveSignAuthorization");

    rmvAuthBtn.addEventListener("click", () => {
            
        submitButton.value = "Remove Auth";

        manageAuthsModal.setAttribute("data-remove", true);
    });
}

manageAuthClose.addEventListener("click", () => {
    
    manageAuthsModal.style.display = "none";
    manageAuthStatus.style.display = "none";
    document.querySelector("#hManageAuth").innerHTML = "Remove Auth";

});

// close all pop-ups if user clicks outside of pop-up ui --------------------------------------

window.onmousedown = (event) => {

    if (event.target === manageUsersModal) {

        manageUsersModal.style.display = "none";
        manageUserStatus.style.display = "none";
    }

    if (event.target === manageLocationsModal) {

        manageLocationsModal.style.display = "none";
        manageLocationStatus.style.display = "none";
    }

    if (event.target === manageAuthsModal) {

        manageAuthsModal.style.display = "none";
        manageAuthStatus.style.display = "none";
    }
}

// Color Change for input on edit -------------------------------------------------------------

const keyColors = {
    
    colorPrimary: "#e9676e",
    colorTextPrimary: "#0a0c16",
    colorTextSecondary: "##11abd6"
}

function pInputOnFocus(imTargetID, imTargetLabel, imTargetLine) {

    document.getElementById(imTargetID).style.color       = keyColors.colorPrimary;
    document.getElementById(imTargetLabel).style.color    = keyColors.colorPrimary;
    document.getElementById(imTargetLine).style.transform = "scaleX(1)";

}

function pInputOnBlur(imTargetID, imTargetLabel, imTargetLine) {

    document.getElementById(imTargetID).style.color       = keyColors.colorTextPrimary;
    document.getElementById(imTargetLabel).style.color    = keyColors.colorTextSecondary;
    document.getElementById(imTargetLine).style.transform = "scaleX(0)";
    
}